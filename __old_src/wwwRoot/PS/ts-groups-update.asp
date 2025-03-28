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
	Dim lGroupName
	
	lGroupName = Request.Form("sGroups")
%>
<script language="javascript">
function OnClickStartPage() {
	document.location.href="psdb-bugs-cat-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lTSObj
	Dim lGroupRs
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lGroupRs = Server.CreateObject ("ADODB.RecordSet")
	Set lGroupRs = lTSObj.GetGroupDetails(lGroupName)

	if lGroupRs.RecordCount > 0 Then
		' Display table 
		Response.Write("<TABLE align=center>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><B>Project Details</B></TD>")
		Response.Write("</TR>")			
		Response.Write("</TABLE>")
		
		Response.Write("<TABLE align=center border=1 class=tdbgdark STYLE='BORDER-COLLAPSE: collapse'>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><font class=whiteboldtext>Project ID</TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Project Name</font></TD>")		
		Response.Write("<TD align=center><font class=whiteboldtext>Project Description</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Project Leader</font></TD>")
		Response.Write("</TR>")			
				
		while Not lGroupRs.EOF
			Response.Write("<TR class=tdbglight> ")
			Response.Write("<TD>")
			If trim(lGroupRs("G_GroupID")) <> "" Then
				Response.Write("<A href=ts-groups-modify.asp?GroupID=" & trim(lGroupRs("G_GroupID")) & ">" & trim(lGroupRs("G_GroupID")) & "</A>")
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If trim(lGroupRs("G_GroupName")) <> "" Then
				Response.Write(trim(lGroupRs("G_GroupName")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If trim(lGroupRs("G_GroupDescription")) <> "" Then
				Response.Write(trim(lGroupRs("G_GroupDescription")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")
			
			lEmployeeID = trim(lGroupRs("G_GroupLeader"))
			Dim lLeadRs
			Set lLeadRs = lTSObj.GetUserProfile(eval(lEmployeeID))

			if lLeadRs.RecordCount > 0 then
				Response.Write("<TD>")
				If trim(lLeadRs("U_Name")) <> "" Then
					Response.Write(trim(lLeadRs("U_Name")))
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			end if
			Set lLeadRs = Nothing
			
			Response.Write("</TR>")
			lGroupRs.MoveNext 
		wend
		Response.Write("</TABLE>") %>
		<TABLE width=50% align="center">
		<TR>
			<TD align="center"><INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'></TD>
		</TR>
		</TABLE>
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
			<TD align="center"><A href="psdb-bugs-cat-start.asp">Click here</A> to go to try again.</TD>
		</TR>
		</TABLE>	
 <% end if %>
</BODY>
</HTML>
