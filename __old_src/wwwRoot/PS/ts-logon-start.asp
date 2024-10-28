<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title>Login</title>
<LINK REL=StyleSheet HREF="theme.css" >
<script language="javascript">
function ValidateFormData() {
	var lEmpID;

	lEmpID = document.frmLogon.ebEmpId.value;

	if (lEmpID == "") {
		alert("Please enter the Employee ID");
		return false;
	}

	if (lEmpID == 0) {
		alert("Please enter a valid Employee ID");
		return false;
	}

	return true;
}

function ValidateInteger() {
	if (!((window.event.keyCode >= 48 && window.event.keyCode <= 57) || (window.event.keyCode == 13))) {
		event.returnValue = 0;
		alert("Please enter integer only");
	}
}
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivLogon.style.background = "lightblue";
</script>
<br><br><br><br>
<center>
<form name="frmLogon" action="ts-logon-login.asp" method="post" onSubmit="return ValidateFormData();">
<table width="47%" border="0" cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
      <tr border=0> 
        <td border=0 valign="center" align="left"> 
            <A href="ts-register-start.asp">Register</A>
        </td>
        <td border=0 valign="center" align="right"> 
            <A href="ts-register-change-pwd.asp">Change Password</A>
        </td>
      </tr>
</table>      
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Logon 
          </span></td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Employee ID</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="15" name="ebEmpId" onkeypress="ValidateInteger();">
        </td>
      </tr>
      <tr> 
        <td  height="27" align=middle width="43%" class="tdbglight"> 
          <div align="left"><font class=blacktext>Password</font></div>
        </td>
        <td align="left" height="27" valign="top" width="57%" class="tdbglight"> 
          <input type="password" size="22" maxlength="15" name="ebPassword">
        </td>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="slogin" value="Login" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
</form>
      
</center>
<script language="javascript">
document.frmLogon.ebEmpId.focus ();
</script>
</body>
</html>
