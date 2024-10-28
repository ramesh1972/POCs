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
	Dim lTSObj
	Dim lGroupProfileRs
	Dim lGroupsRs
	
	lGroupID = Request.QueryString ("GroupID")
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lGroupProfileRs = Server.CreateObject ("ADODB.RecordSet")
	Set lGroupsRs = Server.CreateObject ("ADODB.RecordSet")
	
	Set lGroupProfileRs = lTSObj.GetGroupProfile(lGroupID)
	Set lGroupsRs = lTSObj.GetUserDetails("")  

	'Create the select strings here
	Dim lGroupsSelectStr
	
	lGroupsSelectStr = "<SELECT name='sUsers'><OPTION Value=0>None</OPTION>"
	lGroupsRs.MoveFirst 
	while not lGroupsRs.EOF 
		if (trim(lGroupProfileRs("G_GroupLeader")) = trim(lGroupsRs("U_Employee_ID"))) Then
			lGroupsSelectStr = lGroupsSelectStr & "<OPTION Value='" & trim(lGroupsRs("U_Employee_ID")) & "' selected>" & trim(lGroupsRs("U_Name")) & "</OPTION>"
		Else
			lGroupsSelectStr = lGroupsSelectStr & "<OPTION Value='" & trim(lGroupsRs("U_Employee_ID")) & "'>" & trim(lGroupsRs("U_Name")) & "</OPTION>"
		End If
		lGroupsRs.MoveNext 
	wend
	lGroupsSelectStr = lGroupsSelectStr & "</SELECT>"
%>

<script language="javascript">
function ValidatefrmGroupModify() {
	var lGroupName;

	lGroupName = document.frmGroupModify.ebGroupName.value;
	if (lGroupName == "") {
		alert("Please enter the group name");
		document.frmGroupModify.ebGroupName.focus();
		return false;
	}
	
	return true;
}

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
<form name="frmGroupModify" action="ts-groups-edit.asp" method="post" onsubmit="return ValidatefrmGroupModify();">
<input type="hidden" name="hGroupID" value="<%=trim(lGroupProfileRs("G_GroupID"))%>">
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      
    </table>
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Update Group Profile</span></td>
      </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Group ID</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="64" name="ebGroupID" value="<%=trim(lGroupProfileRs("G_GroupID"))%>" disabled>
        </td>
      </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Group Name</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="64" name="ebGroupName" value="<%=trim(lGroupProfileRs("G_GroupName"))%>">
        </td>
      </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Group Description</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <Textarea cols=30 rows=5 name="taGroupDesc"><%=trim(lGroupProfileRs("G_GroupDescription"))%></textarea>
        </td>
      </tr>
      <tr> 
        <td  height="27"  valign="top" align=middle width="43%" class="tdbglight"> 
          <div align="left"><font class=blacktext>Group Leader</font></div>
        </td>
        <td align="left" height="27" valign="top" width="57%" class="tdbglight"> 
          <%=lGroupsSelectStr%>
        </td>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sModify" value="Update" style='BACKGROUND-COLOR: aqua'>
   			<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
</form>
<%
	Set lTSObj = Nothing
	Set lGroupProfileRs = Nothing
	Set lGroupsRs = Nothing
%>
</BODY>
</HTML>
