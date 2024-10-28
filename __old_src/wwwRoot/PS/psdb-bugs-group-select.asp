<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<script language="javascript">
function RefreshDatabaseFrame() {
	var lProjectID = document.frmGroupSelect.sBugsGroups.value;
	var lFrame = document.all("frameDatabase")
	
	lFrame.src = "psdb-bugs-database-list.asp?ProjectID=" + lProjectID;
}

</script>
<LINK REL=StyleSheet HREF="theme.css" >
<%  ' Check if the user is logged in
	Dim lEmpID
	Dim lEmpType
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
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
<%  ' Check if the user is admin
	Dim lEmpAdmin
	Dim lEmpProjectLead

	lEmpAdmin = lTSObj.CheckIfAdministrator(eval(lEmpID))
	lEmpProjectLead = lTSObj.CheckIfGroupLead(eval(lEmpID), eval(lProjectID))
%>
<%  ' Get the project and database ids
	Dim lProjectID
	Dim lDatabaseID
	
	lProjectID = Request.Cookies("BugsProjectID")
	if lProjectID = "" Then
		lProjectID = 0
	end if
	
	lDatabaseID = Request.Cookies("BugsDatabaseID")
	if lDatabaseID = "" Then
		lDatabaseID = 0
	end if
%>
<% 
	Dim lValidUser
	
	lValidUser=Request.QueryString("ValidUser")
%>	
<%
	Dim lBugsGroupsRs
	Dim lBugsGroupsSelectStr

	' Get bugs groups
	Set lBugsGroupsRs = Server.CreateObject ("ADODB.RecordSet")		
	if lEmpAdmin = true Then
		Set lBugsGroupsRs = lTSObj.GetGroupDetails ("")
	else
		Set lBugsGroupsRs = lTSObj.GetUserGroups(eval(lEmpID))
	end if
	
	'Create the select strings here
	lBugsGroupsSelectStr = "<Select name='sBugsGroups' onchange='return RefreshDatabaseFrame();'>"

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
<!-- #include file=psdb-header.asp -->

<script language="javascript">
document.all.oDivSelGroup.style.background = "lightblue";
</script>
<br><br><br>
<center>
<form name="frmGroupSelect" action="psdb-bugs-group-choose.asp" method="post">
<table width="40%" border="0" cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
		<tr><td align="center"><div id="DivError"></div></td></tr>
      <tr> 
        <td valign="center" align="left"> 
            <B><%=lEmpName%></B>
        </td>
       </TR>
</table>
<table width="40%" border="0" cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse" class="tdbgdark">
<tr class="tdbgdark">
<td>
	<font class="whiteboldtext">Select a Project</font>
</td>
</tr>
       <TR class="tdbglight">
        <td align="center"> 
            <%=lBugsGroupsSelectStr%>
        </td>
      </tr>
   <tr>
	<td align=center>
<iframe width=100% align="center" frameborder="0" name="frameDatabase"></iframe>    
</td>
</tr>
</table>
</form>
</center>
<% 
	if lValidUser = "false" Then
%>
		<script language="javascript">
			document.all.DivError.innerHTML = "You are not a Member of this Project";
			document.all.DivError.style.color = "red";
		</script>
<%		
	end if
	
	Set lBugsGroupsRs = Nothing
	Set lEmpRs = Nothing
	Set lTSObj = Nothing
%>
</body>
<script language=javascript> 
	var lProjID = <%=lProjectID%>;
	var lDBID = <%=lDatabaseID%>;
	
	if (lProjID !=0 && lDBID != 0) {
		document.frmGroupSelect.sBugsGroups.value = lProjID;
		RefreshDatabaseFrame();
	}
	else
		RefreshDatabaseFrame();
</script>
</html>
