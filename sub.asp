<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%


%><!--#include file="manage/inc/config.asp"--> 
<!--#include file="inc/conn.asp"--> 

<%
'��ʼ��ҳ
Const MaxPerPage=5
dim totalPut   
dim CurrentPage
dim TotalPages
dim j
dim sql
dim sortsid
sortsid=request.querystring("nid")

if Not isempty(request("page")) then
	currentPage=Cint(request("page"))
else
	currentPage=1
end if 
set rs=server.CreateObject("adodb.recordset")
rs.open "select  pagenum,name,mark,vipprice,discount,score,id,author,productdate,price2,price1,discount,pic from product where sortsid="&sortsid&" order by adddate desc",conn,1,1
if err.number<>0 then
	call MsgBox("���ݿ���������","Back","None")
	response.End
end if
if rs.eof And rs.bof then
	call MsgBox("�Բ���Ŀǰû�и�����Ʒ��","Back","None")
	response.End
else
	totalPut=rs.recordcount

if currentpage<1 then
	urrentpage=1
end if

if (currentpage-1)*MaxPerPage>totalput then
	if (totalPut mod MaxPerPage)=0 then
		currentpage= totalPut \ MaxPerPage
	else
		currentpage= totalPut \ MaxPerPage + 1
	end if
end if

if currentPage=1 then
else
	if (currentPage-1)*MaxPerPage<totalPut then
		rs.move  (currentPage-1)*MaxPerPage
		dim bookmark
        bookmark=rs.bookmark
        
	else
		currentPage=1
	end if
	end if

end if

dim i
i=0

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>У԰�����</title>
<link href="style.css" rel="stylesheet" type="text/css">

</head>

<body>
<!--#include file="head.htm"-->


<table width="780" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="219" align="left" valign="top"><!--#include file="left.asp"--></td>
    <td width="561" align="left" valign="top">      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="left" valign="top"><br>
          <br></td>
        </tr>
        <tr>
          <td align="center" valign="top"><table width="568"  border="0" cellpadding="0" cellspacing="0">
<%
do while not rs.eof
%>
			  <tr>
                <td width="17%" height="130" align="center" valign="middle" class="shadow"><a href="vpro.asp?id=<%=trim(rs("id"))%>" target="_blank"><img src="<%=trim(rs("pic"))%>" width="85" height="125" border="0"></a></td>
                <td height="130" align="left" valign="top"><table width="100%"  border="0" cellspacing="2" cellpadding="0">
                  <tr>
                    <td colspan="2"><img src="images/w.gif" width="18" height="18"><span class="booktitle"><%=trim(rs("name"))%></span></td>
                  </tr>
                  <tr class="bookinfo">
                    <td width="50%" height="12" class="bookinfo">�����ߣ�<%=trim(rs("author"))%></td>
                    <td width="50%" class="bookinfo"> �����磺<%=trim(rs("mark"))%></td>
                  </tr>
                  <tr class="bookinfo">
                    <td width="50%">�Żݼۣ� <%=trim(rs("price2"))%></td>
                    <td width="50%">�ա��ڣ�<%=trim(rs("productdate"))%></td>
                  </tr>
                  <tr class="bookinfo">
                    <td>�����ۣ�<%=trim(rs("price1"))%></td>
                    <td>VIP�۸�<%=rs("vipprice")%></td>
                  </tr>
                  <tr class="bookinfo">
                    <td>�ۡ��ۣ�<%=trim(rs("discount")*100)%></td>
                    <td> �����֣�<%=rs("score")%></td>
                  </tr>
                  <tr class="bookinfo">
                    <td width="50%">&nbsp;</td>
                    <td width="50%">&nbsp; </td>
                  </tr>
                  <tr>
                    <td colspan="2" align="center"><a href="icar.asp?id=<%=rs("id")%>&action=add" target="pcart"><img src="images/car.gif" width="23" height="20" border="0">���빺�ﳵ</a></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><img src="images/line.gif" width="568" height="9"></td>
              </tr>
<%i=i+1
			if i>=MaxPerPage then Exit Do
			rs.movenext
			loop
			rs.close
			set rs=nothing%>
                                                      <%  
  
				Function showpage(totalnumber,maxperpage,filename)  
  				Dim n
  				
				If totalnumber Mod maxperpage=0 Then  
					n= totalnumber \ maxperpage  
				Else
					n= totalnumber \ maxperpage+1  
				End If
				
				Response.Write "<form method=Post action="&filename&">"  
				Response.Write "<p align='center' > "  
				If CurrentPage<2 Then  
					Response.Write "��ҳ ��һҳ "  
				Else  
					Response.Write "<a href="&filename&"?page=1&nid="&sortsid&">��ҳ</a> "  
					Response.Write "<a href="&filename&"?page="&CurrentPage-1&"&nid="&sortsid&" >��һҳ</a> "  
				End If
				
				If n-currentpage<1 Then  
					Response.Write "��һҳ βҳ"  
				Else  
					Response.Write "<a href="&filename&"?page="&(CurrentPage+1)&"&nid="&sortsid&" >"  
					Response.Write "��һҳ</a> <a href="&filename&"?page="&n&"&nid="&sortsid&">βҳ</a>"  
				End If  
					Response.Write " ҳ�Σ�"&CurrentPage&"/"&n&"ҳ "  
					Response.Write " ����<b>&nbsp;"&totalnumber&"&nbsp;</b>����Ʒ "&maxperpage&"����Ʒ/ҳ " 
					Response.Write "ת����<input type='text' name='page' size=2 maxlength=10 class=smallInput value="&currentpage&">"  
					Response.Write "&nbsp;<input type='submit'   value='GO' name='cndok'></form>"  
				End Function  
			%>
			  
              <tr align="center">
                <td colspan="2"><br>
                  <form name="form1" method="get" action="">
				  <INPUT TYPE="hidden" name="nid" value="<%=sortsid%>">
                    <%
showpage totalput,MaxPerPage,"sub.asp"
%>
                  </form> </td>
              </tr>
          </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
    </table></td>
  </tr>
</table>

<!--#include file="foot.htm"-->
</body>
</html>

