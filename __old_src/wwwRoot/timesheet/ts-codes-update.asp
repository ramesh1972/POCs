<%@ Language=VBScript %>
<HTML><head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<style>
a {text-decoration:none}
a:hover { color:#3333FF}
</style>
<title></title>
<LINK REL=StyleSheet HREF="theme.css" >
<% 'Get the required data from the form
	Dim lCodeID
	Dim lTSObj
	Dim lCodeRs
	Dim lCodeDesc

	lCodeID = Request.Form ("sCodes")
	
	' Get Codes
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")
	Set lCodeRs = Server.CreateObject ("ADODB.RecordSet")
	Set lCodeRs = lTSObj.GetCodeProfile (eval(lCodeID))
	if lCodeRs.RecordCount > 0 Then
		lCodeDesc = trim(lCodeRs("AC_Description"))
	End if
%>
<script language="javascript">
function ValidatefrmUpdateCode() {
	var lCode;
	var lDesc;
	
	lCode = document.frmUpdateCode.ebCode.value;
	lDesc = document.frmUpdateCode.taCodeDescription.value;
	
	if (lCode == "") {
		alert ("Please enter the code");
		document.frmUpdateCode.ebCode.focus ();
		return false;
	}

	if (lDesc == "") {
		alert ("Please enter the description");
		document.frmUpdateCode.taCodeDescription.focus ();
		return false;
	}

	return true;
}	
</script>
<script language="javascript">
function OnClickStartPage() {
	document.location.href="ts-codes-start.asp";
}
</script>
</head>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' >
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivCodes.style.background = "lightblue";
</script>
<BR>
<center>
<form name="frmUpdateCode" action="ts-codes-modify.asp" method="post" onsubmit="return ValidatefrmUpdateCode();">
<input type="hidden" name="hCode" value="<%=lCodeID%>">
   <table width="47%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr class="tdbgdark"> 
        <td valign=center colspan=2><span class="whiteboldtext1">Update Code
          </span></td>
      </tr>
      <tr> 
        <td height="16" align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Code</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input size="22" disabled maxlength="5" name="ebCode" value="<%=lCodeID%>">
        </td>
      </tr>
      <tr> 
        <td height="16" valign='top' align=middle class="tdbglight" width="43%"> 
          <div align="left" class="blacktext">Code Description</div>
        </td>
        <td  align="left" height="16" valign="top" width="57%" class="tdbglight"> 
          <input type="text" maxlength=256 size=30 name="taCodeDescription" value="<%=lCodeDesc%>">
        </td>
      </tr>
</table>
<br>
<table width="47%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="border-collapse:collapse">
      <tr> 
        <td colspan=2 valign="center" align=middle> 
            <input type="submit" name="sUpdateCode" value="Update" style='BACKGROUND-COLOR: aqua'>
            <INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua'>
        </td>
      </tr>
    </table>
            </form>
    
</center>
<script language="javascript">
document.frmUpdateCode.taCodeDescription.focus ();
</script>
<%
	Set lTSObj = Nothing
	Set lCodeRs = Nothing
%>
</body>
</html>
