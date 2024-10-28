 <%@ Language=VBScript %>
 <HTML>
 <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../includes/Theme.css" title="Contemporary" rel="stylesheet">
	</head>

	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class="bodycolor">
	
</HEAD>
<br>
  <!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>

<BODY>

<!--<table width="25%" align="center" border="1"  cellpadding=1 cellspacing=1 align=center>
  <tr class=tdbgdark height=30 align=center><td align=center><font class=whiteboldtext1> Calendar Maintenance </font></td></tr>	-->
  		<table width="85%" align="center" border=1>
			<tr class=tdbgdark height=10 align=middle>
				<td colspan=2 align="left"><font class=whiteboldtext1>Reference Timer Control</font></FONT></td>
			</tr>
   <form name=frmLogonLinks method=post action ="Ref_Tmr_Main.asp" >
   	  <tr class=tdbglight height=30 align=left>
   	  <td><a href="Javascript:document.frmLogonLinks.lUserType.value='sqlAdd';document.frmLogonLinks.submit();" > <font class=blackboldtext><li>Add </li></font> </a></td>
<!--	  <td><a href="Javascript:document.frmLogonLinks.lUserType.value='sqlUpdate';document.frmLogonLinks.submit();"> <font class=blackboldtext><li>Update</li></font> </a></td>-->
	  </tr>
   	  <tr class=tdbglight height=30 align=left>
<!--	  <td><a href="Javascript:document.frmLogonLinks.lUserType.value='sqlView';document.frmLogonLinks.submit();"> <font class=blackboldtext><li>View</li></FONT></a></td>-->
	  <td><a href="Javascript:document.frmLogonLinks.lUserType.value='sqlViewAll';document.frmLogonLinks.submit();"> <font class=blackboldtext><li>View All</li></FONT></a></td>
	  </tr>
	  </tr>
	  <input type=hidden name=lUserType>
	</form>
</table>
<br>
	<!---#include file="../includes/footer.inc"--->
</BODY>
</HTML>


