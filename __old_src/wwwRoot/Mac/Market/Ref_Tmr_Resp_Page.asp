<%
dim lResp_Code
dim lUpdResp_Code
dim lAddResp_Code
dim lSqlOperation
dim lDelResp_Code
lSqlOperation=Request.QueryString("hSqlOpern")
lAddResp_Code=1
lUpdResp_Code=1
if lSqlOperation="butAdd" then
  lAddResp_Code = Request.QueryString ("hAddResponse")
else if lSqlOperation="butUpdate" then
  lUpdResp_Code = Request.QueryString("hUpdResponse")
else if lSqlOperation="butDelete" then  
  lDelResp_Code = Request.QueryString("hDelResponse")
end if
end if
end if 
%>
<br>
  <!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>

<html>
<link rel="Stylesheet" Content="contemporary" href="../includes/theme.css">
	<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Calendar Maintenace</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<% if lAddResp_Code=0 then %>
	<font class=colorboldtext1>The Record has been Added. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
	<%else if lAddResp_Code=9605 then%>
	<font class=colorboldtext1>Date Should be greater than System Date. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
    <%else if lAddResp_Code=9620 or lAddResp_Code=9601 or lAddResp_Code=9608 or lAddResp_Code=9608 then%>
    	<font class=colorboldtext1>Event Id does not matching. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
    <% else if lAddResp_Code=9609 then 	%>
     <font class=colorboldtext1>Time Of Execution Shd. be greater than previous time. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
	<%else if lUpdResp_Code=4017 or lUpdResp_Code=0 then%>
     <font class=colorboldtext1>The Record has been Updated. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
	<% else if lDelResp_Code=0 then %>
	<font class=colorboldtext1>The Record has been Deleted. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
   	<% else if lDelResp_Code<>0 then %>
	<font class=colorboldtext1>The Record has not been Deleted. Click <a href="javascript:history.back()">here</a> to view the previous page</font>
	<%end if
	  end if
	  end if
	  end if
	  end if
	  end if
	  end if %>
	</td></tr>
</table>
<form method="post">
<input type=hidden name="hResPageCode" value=<%=lSqlOperation%>>
</form>
<br>
	<!---#include file="../includes/footer.inc"--->
</html>


