<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-projects-start.asp";
}
</script>
<script language="javascript">
function ValidatefrmAddProject() {
	var lProjectName;
	
	lProjectName = document.frmAddProject.ebProjectName.value;
	if (lProjectName == "") {
		alert ("Please enter the project name");
		document.frmAddProject.ebProjectName.focus ();
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
<form name="frmAddProject" action="ts-projects-insert.asp" method="post" onsubmit="return ValidatefrmAddProject();">
   <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Add a new Project
          </span></td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Project Name</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="256" name="ebProjectName">
        </td>
      </tr>
      <tr> 
        <td height="16" valign='top' align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Project Description</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <textarea rows=5 cols=18 name="taProjectDescription"></textarea>
        </td>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sAddProject" value="Add" style='BACKGROUND-COLOR: aqua'>
			<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'>
	   </td>
      </tr>
    </table>
            </form>
    
</center>
<script language="javascript">
document.frmAddProject.ebProjectName.focus ();
</script>
</body>
</html>
