<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
<% ' Get the group id
	Dim lGroupID
	
	lGroupID = Request.Form("sGroups")
%>
<% 'Get all required data from the database
	Dim lTSObj
	Dim lUsersRs
	Dim lGroupUsersRs
	Dim lGroupRs
	dim lUserProfileRs
	Dim lGroupLeader
		
	lGroupLeader="None"
	
	' Get projects
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lUsersRs = Server.CreateObject ("ADODB.RecordSet")
	Set lGroupUsersRs = Server.CreateObject ("ADODB.RecordSet")
	Set lGroupRs = Server.CreateObject ("ADODB.RecordSet")
	Set lUserProfileRs = Server.CreateObject ("ADODB.RecordSet")			
	
	Set lUsersRs = lTSObj.GetUserDetails ("")
	Set lGroupUsersRs = lTSObj.GetGroupUsers (lGroupID)
	Set lGroupRs = lTSObj.GetGroupProfile (lGroupID)
	if eval(trim(lGroupRs("G_GroupLeader"))) <> 0 Then
		Set lUserProfileRs = lTSObj.GetUserProfile(eval(trim(lGroupRs("G_GroupLeader"))))
		lGroupLeader = trim(lUserProfileRs("U_Name"))
	End if

	'Create the select strings here
	Dim lUsersSelectStr
	Dim lGroupUsersSelectStr
	Dim lFound
	Dim lOrgGroupUsersCount
	
	lOrgGroupUsersCount = 0
	lUsersSelectStr = ""
	lUsersRs.MoveFirst 
	while not lUsersRs.EOF 
		lFound = False
		if lGroupUsersRs.RecordCount > 0 Then
			lGroupUsersRs.MoveFirst 
			while not lGroupUsersRs.EOF
				if (trim(lUsersRs("U_Employee_ID")) = trim(lGroupUsersRs("U_Employee_ID"))) Then	
					lOrgGroupUsersCount = lOrgGroupUsersCount + 1
					lFound = True
					lGroupUsersSelectStr = lGroupUsersSelectStr & "<OPTION Value='" & trim(lUsersRs("U_Employee_ID")) & "'>" & trim(lUsersRs("U_Name")) & "</OPTION>"
				End if
				lGroupUsersRs.MoveNext 
			wend
		End if
		if not lFound THen
			lUsersSelectStr = lUsersSelectStr & "<OPTION Value='" & trim(lUsersRs("U_Employee_ID")) & "'>" & trim(lUsersRs("U_Name")) & "</OPTION>"
		End if
		lUsersRs.MoveNext 
	wend

%>
<script language="javascript">
function MoveUser() {
	var lUserName;
	var lUserValue;
	var lUserText;
	var oOption = document.createElement("OPTION");

	// Move user
	lUserValue = document.frmAddUserToGroup.sAllUsers.value;
	if (lUserValue == "") return;
		
	lUserText = document.frmAddUserToGroup.sAllUsers.options[document.frmAddUserToGroup.sAllUsers.selectedIndex].text;
	lUserIndex = document.frmAddUserToGroup.sAllUsers.selectedIndex;

	// now move the user
	oOption.text=lUserText;
	oOption.value=lUserValue;
	
	document.frmAddUserToGroup.sGroupUsers.add(oOption);
	document.frmAddUserToGroup.sAllUsers.remove (lUserIndex);
}

function onClickGroupUsersUpdate() {
	var lAddedGroupUsersStr;
	var lNoOfOpts;
	var lIdx;
	lNoOfOpts = document.frmAddUserToGroup.sGroupUsers.options.length;

	lAddedGroupUsersStr = "";
	for (lIdx = <%=lOrgGroupUsersCount%>; lIdx < lNoOfOpts; lIdx++) {
		if (lIdx == lNoOfOpts-1) 
			lAddedGroupUsersStr = lAddedGroupUsersStr + document.frmAddUserToGroup.sGroupUsers.options[lIdx].value;		
		else
			lAddedGroupUsersStr = lAddedGroupUsersStr + document.frmAddUserToGroup.sGroupUsers.options[lIdx].value + ",";
	}

	document.frmAddUserToGroup.hAddedUsers.value = lAddedGroupUsersStr;
	return true;
}
function OnClickStartPage() {
	document.location.href="psdb-bugs-cat-start.asp";
}
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="psdb-header.asp" -->
<script language="javascript">
document.all.oDivCat.style.background = "lightblue";
</script>
<BR>
<center>
<form name="frmAddUserToGroup" action="ts-groups-insert-users.asp" method="post" onsubmit="return onClickGroupUsersUpdate();">
<input type="hidden" name="hGroupID" value="<%=lGroupID%>">
<input type="hidden" name="hOrgGroupUsersCount" value="<%=lOrgGroupUsersCount%>">
<input type="hidden" name="hAddedUsers" value="">
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Add Users to Projects
          </span></td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Project Name</div>
        </td>
        <td  align="left" height="16" valign="top" width="43%" class="tdbglight"> 
          <%=trim(lGroupRs("G_GroupName"))%>
        </td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Project Leader</div>
        </td>
        <td  align="left" height="16" valign="top" width="43%" class="tdbglight"> 
        <%=lGroupLeader%>
        </td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="center" class="blacktext"><B>All Users</B></div>
        </td>
        <td  align="middle" height="16" valign="top" width="43%" class="tdbglight"> 
        <B>Project Users</B>
        </td>
      </tr>
      </table>
	<table width="47%" cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">      
      <tr> 
        <td align="middle" height="16" class="tdbglight"><SELECT size=5 name="sAllUsers" style="HEIGHT: 86px; WIDTH: 150px"><%=lUsersSelectStr%></select>
		</td>
		<td align="middle"  height="16" class="tdbglight">
		  <INPUT type="button" value=">" onclick="MoveUser();">
		 </td>
		 <TD align="middle" height="16" class="tdbglight">
          <SELECT size=5 name="sGroupUsers" style="HEIGHT: 86px; WIDTH: 150px"><%=lGroupUsersSelectStr%></SELECT>
        </TD>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sAddUsers" value="Update" style='BACKGROUND-COLOR: aqua'>
			<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
            </form>
    
</center>
<% 
	Set lTSObj = Nothing
	Set lUsersRs = Nothing
	Set lGroupUsersRs = Nothing
	Set lGroupRs = Nothing
	Set lUserProfileRs = Nothing
%>
</body>
</html>
