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
<% ' Check the type of user and redirect
	Dim lUserType
	
	lUserType = Request.Cookies("EmployeeType")
%>

<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-projects-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivProjects.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lTSObj
	Dim lProjectsRs
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lProjectsRs = Server.CreateObject ("ADODB.RecordSet")
	Set lProjectsRs = lTSObj.GetAllProjects ()

	if lProjectsRs.RecordCount > 0 Then
		' Display table 
		Response.Write("<TABLE align=center>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><B>Project Details</B></TD>")
		Response.Write("</TR>")			
		Response.Write("</TABLE>")
		
		Response.Write("<TABLE align=center width=80% border=1 class=tdbgdark STYLE='BORDER-COLLAPSE: collapse'>")
		Response.Write("<TR>")
		Response.Write("<TD width=12% align=center><font class=whiteboldtext>Project ID</TD>")
		Response.Write("<TD width=30% align=center><font class=whiteboldtext>Project Name</font></TD>")		
		Response.Write("<TD width=58% align=center><font class=whiteboldtext>Project Description</font></TD>")		
		Response.Write("</TR>")	
				
		while Not lProjectsRs.EOF
			Response.Write("<TR class=tdbglight> ")
			Response.Write("<TD valign='top'>")
			If trim(lProjectsRs("P_ProjectID")) <> "" Then
				Response.Write(trim(lProjectsRs("P_ProjectID")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lProjectsRs("P_ProjectName")) <> "" Then
				Response.Write(trim(lProjectsRs("P_ProjectName")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lProjectsRs("P_ProjectDescription")) <> "" Then
				Response.Write(trim(lProjectsRs("P_ProjectDescription")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")
			Response.Write("</TR>")
			
			lProjectsRs.MoveNext
		wend
		Response.Write("</TABLE>") %>
		<%
			if lUserType = "A" Then %>
				<TABLE width=50% align="center">
				<TR>
					<TD align="center"><INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'></TD>
				</TR>
				</TABLE>
			<%end if%>
	<%
	else 
		' Display Group details not available %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Group details not available</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-Groups-start.asp">Click here</A> to go to try again.</TD>
		</TR>
		</TABLE>	
 <% end if 
 
 	Set lTSObj = Nothing
	Set lProjectsRs = Nothing
 %>
</BODY>
</HTML>
