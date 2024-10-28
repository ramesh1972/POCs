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
	Dim lEmpName
	
	lEmpName = Request.Form("sUsers")
%>
<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-users-start.asp";
}
</script>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivUsers.style.background = "lightblue";
</script>
<BR>

<% 'Get all required data from the database
	Dim lTSObj
	Dim lUserRs
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lUserRs = Server.CreateObject ("ADODB.RecordSet")
	Set lUserRs = lTSObj.GetUserDetails(lEmpName)

	if Not lUserRs.EOF Then
		' Display table 
		Response.Write("<TABLE align=center>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><B>Employee Details</B></TD>")
		Response.Write("</TR>")			
		Response.Write("</TABLE>")
		
		Response.Write("<TABLE align=center border=1 class=tdbgdark STYLE='BORDER-COLLAPSE: collapse'>")
		Response.Write("<TR>")
		Response.Write("<TD align=center><font class=whiteboldtext>Employee ID</TD>")
		Response.Write("<TD align=center><font class=whiteboldtext>Employee Name</font></TD>")		
		Response.Write("<TD align=center><font class=whiteboldtext>Administrator</font></TD>")
		Response.Write("</TR>")			
				
		while Not lUserRs.EOF
			Response.Write("<TR class=tdbglight> ")
			Response.Write("<TD>")
			If trim(lUserRs("U_Employee_ID")) <> "" Then
				Response.Write("<A href=ts-users-modify.asp?EmpID=" & trim(lUserRs("U_Employee_ID")) & ">" & trim(lUserRs("U_Employee_ID")) & "</A>")
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If trim(lUserRs("U_Name")) <> "" Then
				Response.Write(trim(lUserRs("U_Name")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("<TD>")
			If trim(lUserRs("U_Administrator")) <> "" Then
				Response.Write(trim(lUserRs("U_Administrator")))
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			Response.Write("</TR>")
			lUserRs.MoveNext 
		wend
		Response.Write("</TABLE>") %>
		<TABLE width=50% align="center">
		<TR>
			<TD align="center"><INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'></TD>
		</TR>
		</TABLE>
		<%
	else 
		' Display User details not available %>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">User details not available</font></TD>
		</TR>
		</TABLE>

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-users-start.asp">Click here</A> to go to try again.</TD>
		</TR>
		</TABLE>	
 <% end if 
 
 	Set lTSObj = Nothing
	Set lUserRs = Nothing
 %>
</BODY>
</HTML>
