<%@ Language=VBScript %>
<%Response.Buffer =true%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<% 'Get the required data from the form
	Dim lProjectID
	Dim lDatabaseID
	Dim lBDName
	Dim lBDDescription

	lProjectID = Request.Form("hProjectID")
	lDatabaseID = Request.Form("hDatabaseID")
	lBDName = Request.Form("ebBDName")
	lBDDescription = Request.Form("ebBDDesc")
%>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR><br><br>
<BR>

<% 'Get all required data from the database
	Dim lTSObj
	Dim lDatabaseUpdated
	
	' Update user details
	Set lTSObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	lDatabaseUpdated = lTSObj.UpdateBugsDatabase (eval(lProjectID), eval(lDatabaseID),lBDName, lBDDescription)

	if lDatabaseUpdated Then %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Bugs Database details Updated</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to go to Bugs Database start page.</TD>
		</TR>
		</TABLE>	
	<% else 
		' Display User details not updated %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Bugs Database details not updated</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to try again.</TD>
		</TR>
		</TABLE>	
 <% end if 
 	Set lTSObj = Nothing
 %>
</BODY>
</HTML>
