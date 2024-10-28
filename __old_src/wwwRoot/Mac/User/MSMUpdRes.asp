<%@ Language=VBScript %>

 <script language="JavaScript">
	function FunctionUpdate()
	{
	document.MSMUpdate.action="MSMUpdResult.asp";
	document.MSMUpdate.method="Post";
	document.MSMUpdate.submit();
	}
	function FunctionCancel()
	{
	document.MSMUpdate.action="MSMMenu.asp";
	document.MSMUpdate.submit();
	}         
  
  </script>
  <HTML>
   <HEAD>
    <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
   </HEAD>
   <form name="MSMUpdate">
   <%
	dim recno
	dim strln
	dim lResponse
	dim lTotalRecNo
    dim lFullString	
	lTotalRecNo=Request.Form("hidTotalRec") 
	recno=Request.QueryString("recno")
	lResponse=Request.Form("hidStr"&recno)
	strln=split(lResponse,"|")
	lFullString=Request.form("hidFullString")
  %>
   <body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	
    <!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
    <br>
	
 <table width="70%" border="0"  cellpadding=1 cellspacing=1 align=center>
 <tr class="tdbglight" >
	 <td  align = "middle" colspan=4 height="10"><font class="tdbglight"><b>Market Session Management</b></font></td>
  <tr>
  <td height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Event Type</div></td>
  <td align="left"   class="tdbglight" height="16"  width="30%" ><INPUT name = "lEventType" disabled value=<%=strln(0)%>></td>   
  </tr> 
  
  <tr>
  <td height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Event Code</div></td>
  <td align="left"   class="tdbglight" height="16"  width="30%" ><INPUT name = "lEventCode" disabled value=<%=strln(1)%>></td>   
  </tr> 
 
  <tr>
  <td height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Event</div></td>
  <td align="left"   class="tdbglight" height="16"  width="30%" ><INPUT name = "lEvent"disabled value=<%=strln(2)%>></td>   
  </tr> 
  
  <tr>
  <td height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Event Time</div></td>
  <td align="left"   class="tdbglight" height="16"  width="30%" ><INPUT name = "lEventTime" value=<%=strln(3)%>></td>   
  </tr> 
  
  <tr>
  <td height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Next Session</div></td>
  <td align="left"   class="tdbglight" height="16"  width="30%" ><INPUT name = "lNextSession" disabled value=<%=strln(4)%>></td>   
  </tr> 
  
  <tr>
  <td height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Random Delay</div></td>
  <td align="left"   class="tdbglight" height="16"  width="30%" ><INPUT name = "lRandomDelay"  disabled value=<%=strln(5)%>></td>   
  </tr> 
  
  <tr>
  <td height="27" align=left  width="20%" class="tdbglight" ><div align="left" class="blacktext">Status</div></td>
  <td align="left"   class="tdbglight" height="16"  width="30%" ><INPUT name = "lStatus" disabled value=<%=strln(6)%>></td>   
  </table>
  </tr>
  <br>
  <table align="center">
  <tr class=tdbglight>
  <td align="center">
  <input align=center type=button name="btnUpdate" value="Update" onclick="FunctionUpdate();">
  <input align=center type=button name="btnCancel" value="Cancel" onclick="FunctionCancel();"> 
  </td>
  </tr>
  </table>
  <input type=hidden name=hidRecNo value=<%=recno%>> 
  
  <input type=hidden name="hidResponse" value=<%=lFullString%>>
  <input type=hidden name=hidEventTime value=<%=strln(3)%>>
  <input type=hidden name=hidTotalRecNo value=<%=lTotalRecNo%>>
  <input type=hidden name=hidTimeStamp value=<%=strln(8)%>>
 </form>
 <!---#include file="../includes/footer.inc"--->

 </body>
 </html>
  
 
	
