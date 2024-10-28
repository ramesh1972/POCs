<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title>Login</title>
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
	
	Set lGroupUsersRs = lTSObj.GetGroupUsers (lGroupID)
	Set lGroupRs = lTSObj.GetGroupProfile  (lGroupID)
	if eval(trim(lGroupRs("G_GroupLeader"))) <> 0 Then
		Set lUserProfileRs = lTSObj.GetUserProfile(eval(trim(lGroupRs("G_GroupLeader"))))
		lGroupLeader = trim(lUserProfileRs("U_Name"))
	End if
	
	'Create the select strings here
	Dim lGroupUsersSelectStr
	
	lGroupUsersSelectStr = ""
	if lGroupUsersRs.RecordCount > 0 Then
		lGroupUsersRs.MoveFirst 
		while not lGroupUsersRs.EOF
			Set lUsersRs = lTSObj.GetUserProfile(eval(trim(lGroupUsersRs("U_Employee_ID"))))
			If lUsersRs.RecordCount > 0 Then
				lGroupUsersSelectStr = lGroupUsersSelectStr & "<OPTION Value='" & trim(lUsersRs("U_Employee_ID")) & "'>" & trim(lUsersRs("U_Name")) & "</OPTION>"
			End If
			lGroupUsersRs.MoveNext 
		wend
	End if
%>
<script language="javascript">
function onClickGroupUsersRemove() {
	var lRemovedGroupUsersStr;
	var lNoOfOpts;
	var lIdx;
	lNoOfOpts = document.frmRemoveUsersFromGroup.sGroupUsers.options.length;

	lRemovedGroupUsersStr = "";
	for (lIdx = 0; lIdx < lNoOfOpts; lIdx++) {
		if (document.frmRemoveUsersFromGroup.sGroupUsers.options[lIdx].selected == true) {
			lRemovedGroupUsersStr = lRemovedGroupUsersStr + document.frmRemoveUsersFromGroup.sGroupUsers.options[lIdx].value + ",";		
		}
	}

	document.frmRemoveUsersFromGroup.hRemovedUsers.value = lRemovedGroupUsersStr;
	return true;
}
function OnClickStartPage() {
	document.location.href="ts-groups-start.asp";
}
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivGroups.style.background = "lightblue";
</script>
<BR>
<center>
<form name="frmRemoveUsersFromGroup" action="ts-groups-remove-users.asp" method="post" onsubmit="return onClickGroupUsersRemove();">
<input type="hidden" name="hGroupID" value="<%=lGroupID%>">
<input type="hidden" name="hRemovedUsers" value="">
    <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Remove Users From Group
          </span></td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Group Name</div>
        </td>
        <td  align="left" height="16" valign="top" width="43%" class="tdbglight"> 
          <%=trim(lGroupRs("G_GroupName"))%>
        </td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Group Leader</div>
        </td>
        <td  align="left" height="16" valign="top" width="43%" class="tdbglight"> 
        <%=lGroupLeader%>
        </td>
      </tr>
      <tr> 
        <td align="left" valign="top" height="16" class="tdbglight">Select Users to Remove</td>
		 <TD align="left" valign="top"  height="16" class="tdbglight">
          <SELECT multiple size=5 name="sGroupUsers" style="HEIGHT: 86px; WIDTH: 150px"><%=lGroupUsersSelectStr%></SELECT>
        </TD>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sRemoveUsers" value="Remove Users" style='BACKGROUND-COLOR: aqua'>
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
