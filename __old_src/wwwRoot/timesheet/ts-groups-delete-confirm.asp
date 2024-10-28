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
	Dim lGroupID
	
	lGroupID = Request.Form ("sGroups")

	Dim lTSObj
	Dim lGroupRs
	Dim lUserRs
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lGroupRs = Server.CreateObject ("ADODB.RecordSet")
	Set lUserRs = Server.CreateObject ("ADODB.RecordSet")
	Set lGroupRs = lTSObj.GetGroupProfile (lGroupID)
	if lGroupRs.RecordCount > 0 Then
		Dim lGroupLeadID 
		lGroupLeadID = eval(trim(lGroupRs("G_GroupLeader")))
		Set lUserRs = lTSObj.GetUserProfile (lGroupLeadID)
	end if
%>

<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-groups-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivGroups.style.background = "lightblue";
</script>
<BR>
<form name="frmGroupDelete" action="ts-groups-delete.asp" method="post">
<input type="hidden" name="hGroupID" value="<%=trim(lGroupRs("G_GroupID"))%>">
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      
    </table>
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Confirm Group Delete</span></td>
      </tr>
		<tr>
        <td height="16"  valign="top" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Group ID</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <%=trim(lGroupRs("G_GroupID"))%>
        </td>
      </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Group Name</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <%=trim(lGroupRs("G_GroupName"))%>
        </td>
      </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Group Description</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <%=trim(lGroupRs("G_GroupDescription"))%>
        </td>
      </tr>
      <tr> 
        <td  height="16"  valign="top" align=middle width="43%" class="tdbglight"> 
          <div align="left"><font class=blacktext>Group Leader</font></div>
        </td>
        <td align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <%If lUserRs.RecordCount > 0 then 
				Response.Write(trim(lUserRs("U_Name")))
			else 
				Response.Write("&nbsp;") 
			end if%>
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
<%
	Set lTSObj = Nothing
	Set lGroupRs = Nothing
	Set lUserRs = Nothing
%>
</BODY>
</HTML>
