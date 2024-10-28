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
	Dim lProjectID
	Dim lModuleID
	Dim lBugsObj
	Dim lModuleRs
	
	lProjectID = Request.QueryString ("ProjectID")
	lModuleID = Request.QueryString ("ModuleID")
	
	' Get projects
	Set lBugsObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	Set lModuleRs = Server.CreateObject ("ADODB.RecordSet")
	Set lModuleRs = lBugsObj.GetProjectModules(eval(lProjectID), eval(lModuleID)) 
%>
<%
	Dim lProjectName
	Dim lTSObj
	Dim lRs
	
	Set lTSObj = Server.CreateObject("TimeSheet.clsTimeSheet")
	Set lRs = Server.CreateObject("ADODB.RecordSet")
	
	Set lRs = lTSObj.GetGroupProfile(eval(lProjectID)) 
	lProjectName = trim(lRs("G_GroupName"))
%>

<script language="javascript">
function ValidatefrmModuleModify() {
	var lGroupName;

	lGroupName = document.frmModuleModify.ebModule.value;
	if (lGroupName == "") {
		alert("Please enter the Module name");
		document.frmModuleModify.ebModule.focus();
		return false;
	}
	
	return true;
}

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
<BR><br><br>
<BR>
<form name="frmModuleModify" action="psdb-groups-modules-edit.asp" method="post" onsubmit="return ValidatefrmModuleModify();">
<input type="hidden" name="hProjectID" value="<%=lProjectID%>">
<input type="hidden" name="hModuleID" value="<%=lModuleID%>">
<table width="75%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
	<tr class="tdbgdark"> 
      <td valign=center colspan=2><span class="whiteboldtext1">Update Project Module Profile</span></td>
    </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="40%"> 
          <div align="left" class="blacktext"><b>Project Name</b></div>
        </td>
        <td height="16"  valign="top" align=middle class="tdbglight" width="60%"> 
          <div align="left" class="blacktext"><%=lProjectName%></div>
        </td>
	  </tr>      
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="40%"> 
          <div align="left" class="blacktext"><b>Module Name</b></div>
        </td>
        <td  align="left" height="16" valign="top" width="60%" class="tdbglight"> 
          <input type=text size="40" maxlength="64" name="ebModule" value="<%=trim(lModuleRs("M_ModuleName"))%>">
        </td>
      </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="40%"> 
          <div align="left" class="blacktext"><b>Module Description</b></div>
        </td>
        <td  align="left" height="16" valign="top" width="60%" class="tdbglight"> 
          <Textarea cols=30 rows=5 name="ebModuleDesc"><%=trim(lModuleRs("M_ModuleDescription"))%></textarea>
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
	Set lBugsObj = Nothing
	Set lModuleRs = Nothing
	Set lRs = Nothing
%>
</BODY>
</HTML>
