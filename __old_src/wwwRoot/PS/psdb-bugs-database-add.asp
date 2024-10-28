<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
<%
	Dim lProjectID 
	Dim lProjectName
	Dim lTSObj
	Dim lRs
	
	lProjectID = Request.Form("sGroups")

	Set lTSObj = Server.CreateObject("TimeSheet.clsTimeSheet")
	Set lRs = Server.CreateObject("ADODB.RecordSet")
	
	Set lRs = lTSObj.GetGroupProfile(eval(lProjectID)) 
	lProjectName = trim(lRs("G_GroupName"))
%>
	
<script language="javascript">
function ValidatefrmAddDatabase() {
	var lGroupName;

	lGroupName = document.frmAddDatabase.ebBDName.value;
	if (lGroupName == "") {
		alert("Please enter the Database name");
		document.frmAddDatabase.ebBDName.focus();
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
<form name="frmAddDatabase" action="psdb-bugs-database-insert.asp" method="post" onsubmit="return ValidatefrmAddDatabase();">
    <table  valign="top" width="75%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign="top" colspan=2><span class="whiteboldtext1">Add Database to Project
          </span></td>
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
          <div align="left" class="blacktext"><b>Bugs Database Name</b></div>
        </td>
        <td  align="left" height="16" valign="top" width="60%" class="tdbglight"> 
          <input size="40" maxlength="64" name="ebBDName">
        </td>
      </tr>
      <tr> 
        <td height="16"  valign="top" align=middle class="tdbglight" width="40%"> 
          <div align="left" class="blacktext"><b>Bugs Database Description</b></div>
        </td>
        <td  align="left" height="16" valign="top" width="60%" class="tdbglight"> 
          <Textarea cols=30 rows=5 name="ebBDDesc"></textarea>
        </td>
      </tr>
</table>
<br>
<table width="75%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sAddBugsDatabase" value="Add" style='BACKGROUND-COLOR: aqua'>
			<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
</table>
<input type="hidden" name="hProjectID" value="<%=lProjectID%>">
</form>
    
</center>
<script language="javascript">
document.frmAddDatabase.ebBDName.focus ();
</script>
<%
	Set lTSObj = Nothing
	Set lRs = Nothing
%>
</body>
</html>
