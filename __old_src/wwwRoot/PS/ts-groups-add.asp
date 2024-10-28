<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
<% 'Get all required data from the database
	Dim lTSObj
	Dim lGroupsRs

	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lGroupsRs = Server.CreateObject ("ADODB.RecordSet")
	
	Set lGroupsRs = lTSObj.GetUserDetails("")  

	'Create the select strings here
	Dim lGroupsSelectStr
	
	lGroupsSelectStr = "<SELECT name='sUsers'><OPTION Value='None'>None</OPTION>"
	lGroupsRs.MoveFirst 
	while not lGroupsRs.EOF 
		lGroupsSelectStr = lGroupsSelectStr & "<OPTION Value='" & trim(lGroupsRs("U_Employee_ID")) & "'>" & trim(lGroupsRs("U_Name")) & "</OPTION>"
		lGroupsRs.MoveNext 
	wend
	lGroupsSelectStr = lGroupsSelectStr & "</SELECT>"
%>
<script language="javascript">
function ValidatefrmAddGroup() {
	var lGroupName;

	lGroupName = document.frmAddGroup.ebGroupName.value;
	if (lGroupName == "") {
		alert("Please enter the group name");
		document.frmAddGroup.ebGroupName.focus();
		return false;
	}
	
	return true;
}
function OnClickStartPage() {
document.location.href="psdb-bugs-cat-start.asp";
}
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR>
<center>
<form name="frmAddGroup" action="ts-groups-insert.asp" method="post" onsubmit="return ValidatefrmAddGroup();">
    <table  valign="top" width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign="top" colspan=2><span class="whiteboldtext1">Add Project
          </span></td>
      </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Project Name</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="64" name="ebGroupName">
        </td>
      </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Project Description</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <Textarea cols=30 rows=5 name="ebGroupDesc"></textarea>
        </td>
      </tr>
      <tr> 
        <td  height="27"  valign="top" align=middle width="43%" class="tdbglight"> 
          <div align="left"><font class=blacktext>Project Leader</font></div>
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
            <input type="submit" name="sAddGroup" value="Add" style='BACKGROUND-COLOR: aqua'>
			<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
            </form>
    
</center>
<script language="javascript">
document.frmAddGroup.ebGroupName.focus ();
</script>
<%
	Set lTSObj = Nothing
	Set lGroupsRs = Nothing
%>
</body>
</html>
