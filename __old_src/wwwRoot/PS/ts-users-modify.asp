<%@ Language=VBScript %>
<%Response.Buffer =true%>
<HTML>
<HEAD>
<script language="javascript">
function GroupChange() {
	var lProjID = document.frmUserModify.sUserGroups.value;
	
	var lhDvlp = document.frmUserModify("hGroupDvlp" + lProjID).value;
	var lhTest = document.frmUserModify("hGroupTester" + lProjID).value;
	
	if (lhDvlp == "Y") 
		document.frmUserModify.cbDvlp.checked = true;
	else
		document.frmUserModify.cbDvlp.checked = false;
		
	if (lhTest == "Y") 
		document.frmUserModify.cbTester.checked = true;
	else
		document.frmUserModify.cbTester.checked = false;
}

function ChangeUserRights() {
	var lProjID = document.frmUserModify.sUserGroups.value;
	
	if (document.frmUserModify.cbDvlp.checked == true)
		document.frmUserModify("hGroupDvlp" + lProjID).value = "Y";
	else 
		document.frmUserModify("hGroupDvlp" + lProjID).value = "N";

	if (document.frmUserModify.cbTester.checked == true)
		document.frmUserModify("hGroupTester" + lProjID).value = "Y";
	else 
		document.frmUserModify("hGroupTester" + lProjID).value = "N";
}
</script>
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
	
	lEmployeeID = Request.QueryString ("EmpID")

	Dim lTSObj
	Dim lUserRs
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lUserRs = Server.CreateObject ("ADODB.RecordSet")
	Set lUserRs = lTSObj.GetUserProfile(lEmployeeID)
%>
<script language="javascript">
function OnClickStartPage() {
	document.location.href="psdb-bugs-cat-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR>
<form name="frmUserModify" action="ts-users-edit.asp" method="post">
<%
	' Get the list of groups that the user belongs to
	Dim lGroupRs
	Dim lUserGroupsStr
	
	Set lGroupRs = Server.CreateObject ("ADODB.RecordSet")
	Set lGroupRs = lTSObj.GetUserGroups (eval(lEmployeeID)) 

	lUserGroupsStr = "<Select name='sUserGroups' onchange='GroupChange();'>"
	lRecCount = lGroupRs.RecordCount
	
	if lRecCount > 0 Then
		lGroupRs.MoveFirst()
		while Not lGroupRs.EOF 
			lUserGroupsStr = lUserGroupsStr & "<Option Value='" & eval(trim(lGroupRs("G_GroupID"))) & "'>" & trim(lGroupRs("G_GroupName")) & "</Option>"
			
			' Save the Properties of the user for each group in form hidden variables
%>
			<input type=hidden name="hGroupDvlp<%=eval(trim(lGroupRs("G_GroupID")))%>" Value="<%=trim(lGroupRs("G_GroupDeveloper"))%>">
			<input type=hidden name="hGroupTester<%=eval(trim(lGroupRs("G_GroupID")))%>" Value="<%=trim(lGroupRs("G_GroupTester"))%>">
<%
			lGroupRs.MoveNext() 
		wend 
	end if
	lUserGroupsStr = lUserGroupsStr & "</Select>"
%>
<input type="hidden" name="hEmpID" value="<%=trim(lUserRs("U_Employee_ID"))%>">
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      
    </table>
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Update User Profile</span></td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Employee ID</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="5" name="ebEmployeeID" value="<%=trim(lUserRs("U_Employee_ID"))%>" disabled>
        </td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Employee Name</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="256" name="ebEmpName" value="<%=trim(lUserRs("U_Name"))%>">
        </td>
      </tr>
      <tr> 
        <td  colspan=2 height="27" align=middle width="43%" class="tdbglight"> 
		<div align="left">
			<% If trim(lUserRs("U_Administrator")) = "Y" Then %>
          <Input type="checkbox" name="cbAdministrator" checked>Administrator</div>
            <% else %>
            <Input type="checkbox" name="cbAdministrator">Administrator</div>
            <% end if %>
        </td>
      </tr>
<%	if lRecCount > 0 Then %>
      <tr> 
        <td  height="27" align=left width="43%" class="tdbglight"><b>Select Project</b></td>
        <td  height="27" align=left width="43%" class="tdbglight"><%=lUserGroupsStr%></td>
      </tr>
      <tr>
        <td colspan=2 height="27" align=left width="43%" class="tdbglight"> 
			<Input type="checkbox" name="cbDvlp" onclick="ChangeUserRights();">Developer
		</td>
		<tr>
		<td colspan=2 height="27" align=left width="43%" class="tdbglight"> 
		    <Input type="checkbox" name="cbTester" onclick="ChangeUserRights();">Tester
        </td>
      </tr>
<% else %>
      <tr> 
        <td  colspan=2 height="27" align=left width="43%" class="tdbglight"><b>The User does not belong to any Project</b></td>
      </tr>
<% end if %>
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
</BODY>
<script language="javascript">
GroupChange();
</script>
<% 
 	Set lTSObj = Nothing
	Set lUserRs = Nothing
%>
</HTML>
