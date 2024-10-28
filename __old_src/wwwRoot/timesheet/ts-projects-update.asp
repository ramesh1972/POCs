<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
<% 'Get the required data from the form
	Dim lProjectID
	Dim lTSObj
	Dim lProjectRs
	Dim lProjectName
	Dim lProjectDesc
	lProjectID = Request.Form ("sProjects")
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lProjectRs = Server.CreateObject ("ADODB.RecordSet")
	Set lProjectRs = lTSObj.GetProjectProfile (lProjectID)
	if lProjectRs.RecordCount > 0 Then
		lProjectName = trim(lProjectRs("P_ProjectName"))
		lProjectDesc = trim(lProjectRs("P_ProjectDescription"))
	End if
%>
<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-projects-start.asp";
}
</script>
<script language="javascript">
function ValidatefrmUpdateProject() {
	var lProjectName;
	
	lProjectName = document.frmUpdateProject.ebProjectName.value;
	if (lProjectName == "") {
		alert ("Please enter the project name");
		document.frmUpdateProject.ebProjectName.focus ();
		return false;
	}
	return true;
}	
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivProjects.style.background = "lightblue";
</script>
<BR>
<center>
<form name="frmUpdateProject" action="ts-projects-modify.asp" method="post" onsubmit="return ValidatefrmUpdateProject();">
<input type="hidden" name="hProjectID" value="<%=lProjectID%>">
   <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Update Project
          </span></td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Project Name</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="256" name="ebProjectName" value="<%=lProjectName%>">
        </td>
      </tr>
      <tr> 
        <td height="16" valign='top' align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Project Description</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <textarea rows=5 cols=18 name="taProjectDescription"><%=lProjectDesc%></textarea>
        </td>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sUpdateProject" value="Update" style='BACKGROUND-COLOR: aqua'>
			<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'>
	   </td>
      </tr>
    </table>
            </form>
    
</center>
<script language="javascript">
document.frmUpdateProject.ebProjectName.focus ();
</script>
<%
	Set lTSObj = Nothing 
	Set lProjectRs = Nothing
%>
</body>
</html>
