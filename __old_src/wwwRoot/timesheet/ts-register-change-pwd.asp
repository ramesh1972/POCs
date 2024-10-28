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
function ValidateInteger() {
	if (!((window.event.keyCode >= 48 && window.event.keyCode <= 57) || (window.event.keyCode == 13))) {
		event.returnValue = 0;
		alert("Please enter integer only");
	}
}

function OnClickChangePwd() {
	var lEmpID;
	var lOldPassword;
	var lPwd;
	var lConfPwd;
	
	lEmpID = document.frmRegister.ebEmpId.value; 
	lOldPassword = document.frmRegister.ebOldPassword.value;
	lPwd = document.frmRegister.ebNewPassword.value;
	lConfPwd = document.frmRegister.ebConfirmPassword.value;
	
	if (lEmpID == "") {
		alert ("Please enter the Employee ID");
		document.frmRegister.ebEmpId.focus ();
		return false;
	}
			
	if (lEmpID == 0) {
		alert ("Please enter a valid Employee ID");
		document.frmRegister.ebEmpId.focus ();
		return false;
	}

	if (lOldPassword == "") {
		alert ("Please enter the Old Password");
		document.frmRegister.ebOldPassword.focus ();
		return false;
	}

	if (lPwd  == "") {
		alert ("Please enter the New Password");
		document.frmRegister.ebNewPassword.focus ();
		return false;
	}

	if (lPwd != lConfPwd) {
		alert ("Confirm Password does not match.\nPlease re-enter.");
		document.frmRegister.ebNewPassword.focus ();
		return false;
	}
	return true;
}	
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivLogon.style.background = "lightblue";
</script>
<BR>
<center>
<form name="frmRegister" action="ts-register-update-pwd.asp" method="post" onsubmit="return OnClickChangePwd();">
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      
    </table>
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Change Password
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
          <div align="left"><font class=blacktext>Old Password</font></div>
        </td>
        <td align="left" height="27" valign="top" width="57%" class="tdbglight"> 
          <input type="password" size="22" maxlength="15" name="ebOldPassword">
        </td>
      </tr>
      <tr> 
        <td  height="27" align=middle width="43%" class="tdbglight"> 
          <div align="left"><font class=blacktext>New Password</font></div>
        </td>
        <td align="left" height="27" valign="top" width="57%" class="tdbglight"> 
          <input type="password" size="22" maxlength="15" name="ebNewPassword">
        </td>
      </tr>
      <tr> 
        <td  height="27" align=middle width="43%" class="tdbglight"> 
          <div align="left"><font class=blacktext>Confirm New Password</font></div>
        </td>
        <td align="left" height="27" valign="top" width="57%" class="tdbglight"> 
          <input type="password" size="22" maxlength="15" name="ebConfirmPassword">
        </td>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sChangePwd" value="ChangePwd" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
            </form>
      
<span class="blacktext"><br>
</span>


</center>
<script language="javascript">
document.frmRegister.ebEmpId.focus ();
</script>
</body>
</html>
