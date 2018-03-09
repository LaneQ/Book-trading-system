<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%


%><!--#include file="manage/inc/config.asp"--> 
<!--#include file="inc/conn.asp"--> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>校园网书城</title>
<link href="style.css" rel="stylesheet" type="text/css">
</style>
<!-- European format dd-mm-yyyy -->
<script language="JavaScript" src="calendar.js"></script>

</head>

<body>
<!--#include file="head.htm"-->


<table width="780" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="219" align="left" valign="top"><!--#include file="left.asp"--></td>
    <td width="561" align="left" valign="top">
      <br>      <script language=javascript>
var whitespace = " \t\n\r";

function IsWhitespace (s)
{
  var i;
  if (IsEmpty(s)) return true;

  for (i = 0; i < s.length; i++)
  {
    var c = s.charAt(i);
    if (whitespace.indexOf(c) == -1) return false;
  }
  return true;
}

function IsEmpty(s)
{ 
  return ((s == null) || (s.length == 0))
}


function IsDate(fDate)
{

    var arrDaysInMonth=new Array(12);
    arrDaysInMonth[1]=31;
    arrDaysInMonth[2]=29;
    arrDaysInMonth[3]=31;
    arrDaysInMonth[4]=30;
    arrDaysInMonth[5]=31;
    arrDaysInMonth[6]=30;
    arrDaysInMonth[7]=31;
    arrDaysInMonth[8]=31;
    arrDaysInMonth[9]=30;
    arrDaysInMonth[10]=31;
    arrDaysInMonth[11]=30;
    arrDaysInMonth[12]=31;
    
    if (IsEmpty(fDate))
        return true
        
    var NameList=fDate.split("-");
    if (NameList.length!=3)
        return false
    
    if (!(IsYear(NameList[0]) && IsMonth(NameList[1]) && IsDay(NameList[2])) )
        return false
    
    if ( NameList[1]>arrDaysInMonth[NameList[1]] )
        return false
        
    if ( (NameList[1]==2) && (NameList[2]>DaysInFebruary(NameList[0]) ) )
        return false
        
    return true

}


function search()   
{
  var name          = document.forms['frmdata'].elements['name'].value;
  var author        = document.forms['frmdata'].elements['author'].value;
  var manufacturer  = document.forms['frmdata'].elements['manufacturer'].value;
  var smallprice    = document.forms['frmdata'].elements['smallprice'].value;
  var largeprice    = document.forms['frmdata'].elements['largeprice'].value;
  var enabledate    = document.forms['frmdata'].elements['enabledate'].value;
  var expiredate    = document.forms['frmdata'].elements['expiredate'].value;



  if (!IsWhitespace(enabledate))
  {
    if (!IsDate(enabledate))
    {
      alert("出版日期 开始日期格式错误!");
      return false;
    }
  }


  if (!IsWhitespace(expiredate))
  {
    if (!IsDate(expiredate))
    {
      alert("出版日期 结束日期格式错误!");
      return false;
    }
  }

  var allNotEmpty = (!IsWhitespace(name)) ||
	             (!IsWhitespace(author)) ||
	             (!IsWhitespace(manufacturer)) ||
	             (!IsWhitespace(smallprice)) ||
	             (!IsWhitespace(largeprice))||
	             (!IsWhitespace(enabledate)) ||
	             (!IsWhitespace(expiredate));

  if (!allNotEmpty)
  {
      alert("必需输入一个搜索条件");
      return false;
  }

  if (!IsWhitespace(smallprice))
  {
    if (!IsPlusNumeric(smallprice))
    {
      alert("价格数据不合法");
      return false;
    }
  }

  if (!IsWhitespace(largeprice))
  {
    if (!IsPlusNumeric(largeprice))
    {
      alert("价格数据不合法");
      return false;
    }
  }

  if ((!IsWhitespace(enabledate)) && (!IsWhitespace(expiredate)))
  {
	  if (enabledate>expiredate)
	  {
	    alert("出版日期范围错误");
        return false;
	  }
  }

  if ((!IsWhitespace(smallprice)) && (!IsWhitespace(largeprice)))
  {
	  if (parseFloat(smallprice)>parseFloat(largeprice))
	  {
	    alert("价格范围错误");
        return false;
	  }
  }
}
                </script>      <br>      <table cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td><img src="images/w.gif"></td>
          <td style="color:#415373">搜索图书</td>
        </tr>
      </table>      <br>      <FORM name=frmdata  method=get action="rsearch.asp">
        <TABLE cellSpacing=10 cellPadding=0 width="100%" border=0>
         
          <TBODY>
            <TR>
              <TD align=right width="31%" height=30>商品名称：</TD>
              <TD width="69%"><INPUT name=name class="inputstyle">
              </TD>
            </TR>
            <TR>
              <TD align=right width="31%" height=30>作者名称：</TD>
              <TD width="69%"><INPUT name=author class="inputstyle">
              </TD>
            </TR>
            <TR>
              <TD align=right width="31%" height=30>出版社：</TD>
              <TD width="69%"><INPUT name=manufacturer class="inputstyle">
              </TD>
            </TR>
            <TR>
              <TD align=right width="31%" height=28>出版时间：</TD>
              <TD vAlign=center width="69%"><INPUT name=enabledate class="inputstyle" size=12>
                <a 
            href="javascript:cal1.popup();"><img height=16 alt=点击选择日期 
            src="images/cal.gif" width=16 border=0></a>              &nbsp;至&nbsp;
                  <INPUT name=expiredate class="inputstyle" size=12>
                  <a 
            href="javascript:cal2.popup();"><img height=16 alt=点击选择日期 
            src="images/cal.gif" width=16 border=0></a> <script language=JavaScript>
  var cal1 = new calendar1(document.forms['frmdata'].elements['enabledate']);
  cal1.year_scroll = true;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['frmdata'].elements['expiredate']);
  cal2.year_scroll = true;
  cal2.time_comp = false;
                  </script></TD>
            </TR>
            <TR>
              <TD align=right width="31%" height=30>价格范围：</TD>
              <TD width="69%">                <input name="smallprice" type="text" id="smallprice"  size="5" >
            至
              
              <input name="largeprice" type="text" id="largeprice" 
 size="5" >
              </TD>
            </TR>
            <TR>
              <TD align=right height=30>分类：</TD>
              <TD><select name=code>
                <option value="" selected>所有图书</option>
                <%
set rs=server.CreateObject("adodb.recordset")
rs.open "select * from category",conn,1,1
do while not rs.eof
%>
                <option value="<%=rs("categoryid")%>" ><%=rs("category")%></option>
                <%
rs.movenext
loop
rs.close
set rs=nothing
%>
              </select></TD>
            </TR>
            <TR>
              <TD align=right height=30>排序字段：</TD>
              <TD><input name="OrderField" type="radio" value="adddate" checked>
                添加日期&nbsp;                  <input type="radio" name="OrderField" value="productdate">
                  出版日期
                  <input type="radio" name="OrderField" value="price2">
                  价钱(会员价)
                  <br>
                  <br>                  <input type="radio" name="OrderField" value="vipprice">
价钱(VIP)
<input type="radio" name="OrderField" value="pagenum">
页数&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="OrderField" value="discount">
折扣</TD>
            </TR>
            <TR>
              <TD align=right width="31%" height=30>排序方式：</TD>
              <TD width="69%"><input type="radio" name="Order" value="ASC"> 
                升序
                  <input name="Order" type="radio" value="DESC" checked>
              降序</TD>
            </TR>
            <TR align=center>
              <TD height=40 colSpan=2><INPUT type=submit value=开始搜索 name=Submit2 onClick="return search()">              </TD>
            </TR>
          
      </TABLE>
    </FORM></td>
  </tr>
</table>

<!--#include file="foot.htm"-->
</body>
</html>


