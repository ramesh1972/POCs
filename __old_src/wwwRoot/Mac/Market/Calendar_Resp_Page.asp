<%
dim lResp_Code
dim lUpdResp_Code
dim lAddResp_Code
dim lSqlOperation

lSqlOperation=Request.QueryString("hSqlOpern")
lAddResp_Code=1
lUpdResp_Code=1
if lSqlOperation="butAdd" then
  lAddResp_Code = Request.QueryString ("hAddResponse")
else if lSqlOperation="butUpdate" then
  lUpdResp_Code = Request.QueryString("hUpdResponse")
end if
end if
%>
<html>
<link rel="Stylesheet" Content="contemporary" href="../includes/theme.css">
<br>
<!---#include file="../includes/header.inc"--->
<br>
<!---#include file="../includes/MACLinks.inc"--->
<br>
<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Calendar Maintenace</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<% if lAddResp_Code=0 then %>
	<font class=colorboldtext1>The Record has been Added. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
	<%else if lAddResp_Code=4084 then%>
	<font class=colorboldtext1>Duplicate Record. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
	<%else if lUpdResp_Code=0 then%>
     <font class=colorboldtext1>The Record has been Updated. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
	<%end if
	  end if
	  end if%>
	</td></tr>
</table>
<form method="post" >
<input type=hidden name="hResPageCode" value=<%=lSqlOperation%>>
</form>
<br>
<!---#include file="../includes/footer.inc"--->
</html>


