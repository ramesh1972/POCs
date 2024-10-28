<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title>Register</title>
<LINK REL=StyleSheet HREF="theme.css" >
<% ' See if there is a Query string
	Dim lFromAddUser
	
	lFromAddUser="N"
	lFromAddUser = Request.QueryString ("FromAddUser")
%>
<script language="javascript">
function ValidateInteger() {
	if (!((window.event.keyCode >= 48 && window.event.keyCode <= 57) || (window.event.keyCode == 13))) {
		event.returnValue = 0;
		alert("Please enter integer only");
	}
}

function OnClickRegister() {
	var lPwd;
	var lConfPwd;
	var lEmpID;
	var lEmpName;
	
	lEmpID = document.frmRegister.ebEmpId.value;
	lEmpName = document.frmRegister.ebEmpName.value
	if (lEmpID == "") {
		alert("Please enter the Employee ID");
		document.frmRegister.ebEmpId.focus();
		return false;
	}

	if (lEmpID == 0) {
		alert("Please enter a valid Employee ID");
		document.frmRegister.ebEmpId.focus();
		return false;
	}

	if (lEmpName == "") {
		alert("Please enter the Employee Name");
		document.frmRegister.ebEmpName.focus();
		return false;
	}

	lPwd = document.frmRegister.ebPassword.value;
	lConfPwd = document.frmRegister.ebConfirmPassword.value;
	
	if (lPwd == "") {
		document.frmRegister.ebPassword.focus();
		alert("Please enter the Password");
		return false;
	}

	if (lPwd != lConfPwd) {
		alert ("Confirm Password does not match.\nPlease re-enter.");
		document.frmRegister.ebPassword.focus ();
		return false;
	}
	return true;
}	
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivLogon.style.background = "lightblue";
</script>
<BR>
<br><br><br>
<center>
<form name="frmRegister" action="ts-register-add-user.asp" method="post" onsubmit="return OnClickRegister();">
<input type="hidden" name="hFromAddUser" Value="<%=lFromAddUser%>">
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Register
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
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Employee Name</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" maxlength="256" name="ebEmpName">
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
      <tr> 
        <td  height="27" align=middle width="43%" class="tdbglight"> 
          <div align="left"><font class=blacktext>Confirm Password</font></div>
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
            <input type="submit" name="sRegister" value="Register" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
            </form>
    
</center>
<script language="javascript">
document.frmRegister.ebEmpId.focus();
</script>
</body>
</html>
