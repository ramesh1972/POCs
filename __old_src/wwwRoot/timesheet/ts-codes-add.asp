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
function ValidatefrmAddCode() {
	var lCode;
	var lDesc;
	
	lCode = document.frmAddCode.ebCode.value;
	lDesc = document.frmAddCode.taCodeDescription.value;
	
	if (lCode == "") {
		alert ("Please enter the code");
		document.frmAddCode.ebCode.focus ();
		return false;
	}

	if (lDesc == "") {
		alert ("Please enter the description");
		document.frmAddCode.taCodeDescription.focus ();
		return false;
	}

	return true;
}	
</script>
<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-codes-start.asp";
}
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivCodes.style.background = "lightblue";
</script>
<BR>
<center>
<form name="frmAddCode" action="ts-codes-insert.asp" method="post" onsubmit="return ValidatefrmAddCode();">
   <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Add a new Code
          </span></td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Code</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="5" name="ebCode">
        </td>
      </tr>
      <tr> 
        <td height="16" valign='top' align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Code Description</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input type="text" maxlength=256 size=30 name="taCodeDescription">
        </td>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sAddCode" value="Add" style='BACKGROUND-COLOR: aqua'>
            <INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
            </form>
    
</center>
<script language="javascript">
document.frmAddCode.ebCode.focus ();
</script>
</body>
</html>
