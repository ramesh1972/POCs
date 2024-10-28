<%@ Language=VBScript %>
<%Response.Buffer =true%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<% 'Get the required data from the form
	Dim lEmployeeID
	
	lEmployeeID = Request.Form ("sUsers")

	Dim lTSObj
	Dim lUserRs
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lUserRs = Server.CreateObject ("ADODB.RecordSet")
	Set lUserRs = lTSObj.GetUserProfile(lEmployeeID)
%>

<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-users-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivUsers.style.background = "lightblue";
</script>
<BR>
<form name="frmUserModify" action="ts-users-delete.asp" method="post">
<input type="hidden" name="hEmpID" value="<%=trim(lUserRs("U_Employee_ID"))%>">
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      
    </table>
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Confirm User Delete</span></td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext"><B>Employee ID</B></div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
		<%=trim(lUserRs("U_Employee_ID"))%>
        </td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext"><B>Employee Name</B></div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <%=trim(lUserRs("U_Name"))%>
        </td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext"><B>Administrator</B></div>
        </td>
        <td  align="left" height="16" align=middle width="43%" class="tdbglight"> 
			<%=trim(lUserRs("U_Administrator"))%>
        </td>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sDelete" value="Delete" style='BACKGROUND-COLOR: aqua'>
			<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
</form>
</BODY>
<%
 	Set lTSObj = Nothing
	Set lUserRs = Nothing
%>
</HTML>
