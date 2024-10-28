<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Trading												  *
	'* File name	:	UserLogon.asp										  *
	'* Purpose		:	This is used to Logon for TCM,ICM,Client and SubBroker*
	'* Prepared by	:	V.Christopher Britto								  *	
	'* Date			:	03.04.2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used to go to the Login Page deponds on the user.Here TCM,	  *
	'* ICM, SubBroker & Client can go to their appropriate Login Page.		  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No.-Date		 - By					- Explanation	   		  *
	'*	1		   03.04.2001  V.Christopher Britto   First Baseline		  *
	'*	2		   05.05.2001  V.Christopher Britto   SubBroker method is	  *
	'*												  removed				  *						  *
	'**************************************************************************
	option explicit

	%>
	
	<HTML>
	<HEAD>
	<style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<LINK REL=StyleSheet HREF="../Includes/Theme.css" TITLE="Contemporary">
	<script language="JavaScript">
	function validateLogon()		// To Validate UserId and Password for TCM, ICM and Client
	{
	 if ((validateUName()) && (validatePassword()))
	   {
	   return true;
	   
	   }
	 return false;
	}
	function validateUName()   // To Validate UserId
	{
		var UName = document.frmLogon.txtUserId.value;
		if (UName == "") 
		{
			alert("Please Enter your User Name.")
			document.frmLogon.txtUserId.value =""; 		
			document.frmLogon.txtUserId.focus();
			return false;
		}
		for (var i = 0; i < UName.length; i++) 
	    {
			var ch = UName.substring(i, i + 1);
			if ( ((ch < "a" || "z" < ch) && (ch < "A" || "Z" < ch)) && (ch < "0" || "9" < ch) && (ch != '_')) 
			{
				alert("Please Enter a valid User Name");
				document.frmLogon.txtUserId.value =""; 		
				document.frmLogon.txtUserId.focus();
				return false;
		  }
	   }
	return true;
	}

	function validatePassword()		// Validate Password range
	{
		var UPass = document.frmLogon.txtPassword.value;
		if (UPass == "") 
		{
			alert("Please Enter your Password.");
			document.frmLogon.txtPassword.value ="";
			document.frmLogon.txtPassword.focus();
			return false;
		  }
		  
		  
		if ((UPass.length < 5 ) ||(UPass.length > 11))
		{
			alert("\nThe Password is not in the range of 5 to 10 characters.\nPlease re-enter your Password.")
			document.frmLogon.txtPassword.value =""; 		
			document.frmLogon.txtPassword.focus();
			return false;
		}
			 return true;
	}
	
	function defaultfocus()
	{
		document.frmLogon.txtUserId.focus(); 
	}
	
	</script></HEAD>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor onload="defaultfocus()">
	<!--#include file="../Includes/header.inc" ----><br>
	<center>
	<%
	Logon()
	%>
	<p>&nbsp;</p>
	<br>
	<br>
	<center><!-- #include file="../Includes/footer.inc"--></center>
	</body>
	</html>

	<% sub Logon()%>
	<form name="frmLogon" method="post" action="validatelogon.asp" onsubmit ="return validateLogon()" >
			<br>
			<table width="40%" border="1"  cellpadding=1 cellspacing=1 align=center height="146">
			<tr class="tdbgdark"> 
			    <td valign=center colspan=2 height="27"><span class="whiteboldtext1">MAC - Logon
			     </span></td>
			</tr>
	      <tr> 
			<td height="27" align=middle class="tdbglight" >
	          <div align="left" class="blacktext">User Name</div>
	        </td>
		        <td  align="left" height="20"  class="tdbglight" >  
	          <input size="15" maxlength="10" name="txtUserId" >
	        </td>
	      </tr>
	      <tr> 
	        <td  height="27" align=middle  class="tdbglight">  
	          <div align="left"><font class=blacktext>Password</font></div>
	        </td>
	        
	        <td align="left" height="27"  class="tdbglight">  
	          <input type="password" size="15" maxlength="10" name="txtPassword" >
	        </td>
	      </tr>
	      <tr> 
	       
	        <td colspan=2 valign="center" align=middle class="tdbglight" height="27" width="57%"> 
	          <div align="center"> 
				   <input type="submit" name="sbtLogin" value="Login">
	          </div>
	        </td>
	      </tr>
	    </table>
	  </form>
	<%end sub%>




