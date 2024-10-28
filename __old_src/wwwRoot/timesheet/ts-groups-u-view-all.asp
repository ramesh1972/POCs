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
<% 'Get the required data from the form
	Dim lGroupName
	
	lGroupName = Request.Form("sGroups")
%>
<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-groups-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivGroups.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lTSObj
	Dim lGroupRs
	Dim lLeadRs
	Dim lEmployeeID
	Dim lGroupUsersRs
	Dim lUserProfileRs
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lGroupRs = Server.CreateObject ("ADODB.RecordSet")
	Set lLeadRs = Server.CreateObject ("ADODB.RecordSet")	
	Set lGroupUsersRs = Server.CreateObject ("ADODB.RecordSet")	
	Set lUserProfileRs = Server.CreateObject ("ADODB.RecordSet")				
	Set lGroupRs = lTSObj.GetGroupDetails("")

	if lGroupRs.RecordCount > 0 Then
		' Display table 
		Response.Write("<TABLE align=center>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><B>Group Details</B></TD>")
		Response.Write("</TR>")			
		Response.Write("</TABLE>")
		
		Response.Write("<TABLE align=center border=1 class=tdbgdark STYLE='BORDER-COLLAPSE: collapse'>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><font class=whiteboldtext>Group ID</TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Group Name</font></TD>")		
		Response.Write("<TD align=center><font class=whiteboldtext>Group Description</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Group Leader</font></TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Group Members</font></TD>")				
		Response.Write("</TR>")			
				
		while Not lGroupRs.EOF
			Response.Write("<TR class=tdbglight> ")
			Response.Write("<TD valign='top'>")
			If trim(lGroupRs("G_GroupID")) <> "" Then
				Response.Write(trim(lGroupRs("G_GroupID")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lGroupRs("G_GroupName")) <> "" Then
				Response.Write(trim(lGroupRs("G_GroupName")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD valign='top'>")
			If trim(lGroupRs("G_GroupDescription")) <> "" Then
				Response.Write(trim(lGroupRs("G_GroupDescription")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")
			
			lEmployeeID = trim(lGroupRs("G_GroupLeader"))
			Set lLeadRs = lTSObj.GetUserProfile(eval(lEmployeeID))

			Response.Write("<TD valign='top'>")
			if lLeadRs.RecordCount > 0 then
				If trim(lLeadRs("U_Name")) <> "" Then
					Response.Write(trim(lLeadRs("U_Name")))
				Else
					Response.Write("&nbsp")
				End If
			else
				Response.Write("&nbsp")
			end if
			Response.Write("</TD>")
	
			Dim lGroupMembersStr
			lGroupMembersStr = ""
			Set lGroupUsersRs = lTSObj.GetGroupUsers (eval(trim(lGroupRs("G_GroupID"))))
			while not lGroupUsersRs.EOF 
				Set lUserProfileRs = lTSObj.GetUserProfile (eval(trim(lGroupUsersRs("U_Employee_ID"))))
				if not lUserProfileRs.EOF Then			
					lGroupMembersStr = lGroupMembersStr & trim(lUserProfileRs("U_Name")) & "<BR>"
				end if
				lGroupUsersRs.MoveNext 
			wend

			Response.Write("<TD valign='top'>")
			If lGroupMembersStr <> "" Then
				Response.Write(lGroupMembersStr)
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("</TR>")
			lGroupRs.MoveNext 
		wend
		Response.Write("</TABLE>") %>
		<%If (lUserType <> "U") Then%>
			<TABLE width=50% align="center">
			<TR>
				<TD align="center"><INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" id=button1 name=button1></TD>
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
	Set lGroupRs = Nothing
	Set lLeadRs = Nothing
	Set lEmployeeID = Nothing
	Set lGroupUsersRs = Nothing
	Set lUserProfileRs = Nothing
 %>
</BODY>
</HTML>
