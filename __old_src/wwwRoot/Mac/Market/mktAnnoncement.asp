<%@language="VBScript"%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<TITLE></TITLE>
<link rel="stylesheet" href="../Includes/Theme.css">
</HEAD>
<BODY>
<form name="frmMktAnnounce" method="post" action ="" >
<%
if trim(Request.Form("txtAreaMktAnce"))<>"" then
	dim objMktMon
	set objMktMon=server.CreateObject("Mac.MarketAnnouncementMgr")
	'lexe.DoAdd("macid","","","welcome to bceindia......")
	objMktMon.DoAdd "MDI0002000","","",Request.Form("txtAreaMktAnce")%>
	<table  align="center" border="1"  cellpadding=1 cellspacing=1>
	<tr class=tdbgdark height=10 align=middle><td align=left width="337"><font class=whiteboldtext1>Market Announcement</font></td></tr>
	<tr class=tdbglight height=10 align="middle">
	 <td>
		Market Announcement Message Inserted Successfully	
	</td>
     </tr>
	</table>
	<p><center>To Add More Messages <a href="http://obulap/mac/MARKET/mktAnnoncement.asp">Click Here</a><center></p>
	<%set objMktMon=nothing%>

<%else%>
<table width="347" align="center" border="1"  cellpadding=1 cellspacing=1 style="HEIGHT: 234px; WIDTH: 348px">
	<tr class=tdbgdark height=30 align=middle><td align=left width="337"><font class=whiteboldtext1>Market Announcement</font></td></tr>
	<tr class=tdbglight height=30 align=left><td><TEXTAREA name=txtAreaMktAnce rows=5 style="height: 138; width: 339" cols="20"></TEXTAREA></td></tr>
	<tr class=tdbglight height=30 align="middle">
	   <td>
		  <INPUT type="submit" value="Submit" id=submit1 name=submit1>
		  <input name="rstClear" type="reset" value=Reset>
		  </td>
     </tr>
</table>
<%end if%>
</form>
<!---#include file="../includes/footer.inc"--->
</BODY>
</HTML>
