<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title>Login</title>
<LINK REL=StyleSheet HREF="../timesheet/theme.css" >
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("../timesheet/ts-logon-start.asp")
	end if
%>
<%
	Dim lGroupID
	
	lGroupID = Request.Form("sBugsGroups")
%>
<% 
	Dim lValidUser
	
	lValidUser=Request.QueryString("ValidUser")
%>	
<% ' Get the Employee Name
	Dim lEmpName
	Dim lEmpRs
	Dim lTSObj

	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lEmpRs = Server.CreateObject ("ADODB.RecordSet")
	Set lEmpRs = lTSObj.GetUserProfile (lEmpID)
	
	lEmpName = ""
	if lEmpRs.RecordCount > 0 Then
		lEmpName = trim(lEmpRs("U_Name"))
	End If
%>
<%
	Dim lBugsGroupsRs
	Dim lBugsGroupsSelectStr

	' Get bugs groups
	Set lBugsGroupsRs = Server.CreateObject ("ADODB.RecordSet")		
	Set lBugsGroupsRs = lTSObj.GetBugsGroups ()
	
	'Create the select strings here
	lBugsGroupsSelectStr = "<Select name='sBugsGroups'>"

	if lBugsGroupsRs.RecordCount > 0 Then
		lBugsGroupsRs.MoveFirst 
		while not lBugsGroupsRs.EOF
			lBugsGroupsSelectStr = lBugsGroupsSelectStr & "<OPTION Value='" & trim(lBugsGroupsRs("G_GroupID")) & "'>" & trim(lBugsGroupsRs("G_GroupName")) & "</OPTION>"
			lBugsGroupsRs.MoveNext 
		wend
	End if
	
	lBugsGroupsSelectStr = lBugsGroupsSelectStr & "</Select>"
%>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivSelGroup.style.background = "lightblue";
</script>
<br><br><br>
<center>
<form name="frmGroupSelect" action="psdb-bugs-group-choose.asp" method="post">
<table width="50%" border="0" cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
		<tr><td align="center"><div id="DivError"></div></td></tr>
      <tr> 
        <td valign="center" align="left"> 
            <B><%=lEmpName%></B>
        </td>
       </TR>
</table>
<table width="50%" border="0" cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse" class="tdbgdark">
<tr class="tdbgdark">
<td>
	<font class="whiteboldtext">Select a Group to Logon to the Software Bugs Domain</font>
</td>
</tr>
       <TR class="tdbglight">
        <td align="center"> 
            <%=lBugsGroupsSelectStr%>
        </td>
      </tr>
    </table>
    <br>
<table width="50%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="slogin" value="Enter Bugs Domain" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
</form>
</center>
<% 
	if lValidUser = "false" Then
%>
		<script language="javascript">
			document.all.DivError.innerHTML = "You are not a Member of this Group";
			document.all.DivError.style.color = "red";
		</script>
<%		
	end if
	
	Set lBugsGroupsRs = Nothing
	Set lEmpRs = Nothing
	Set lTSObj = Nothing
%>
</body>
</html>
