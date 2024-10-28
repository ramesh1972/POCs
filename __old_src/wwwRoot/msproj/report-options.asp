<%@ Language=VBScript %>
<HTML>
<HEAD>	
<LINK REL=StyleSheet HREF="theme.css">
<script language="javascript">
function SelField() {
	var lFieldName;
	var lFieldValue;
	var lFieldText;
	var oOption = document.createElement("OPTION");
	
	// Move Field
	lFieldValue = document.frmSelectTaskFields.sAllTaskFields.value;
	if (eval(lFieldValue) < 0) return;
		
	lFieldText = document.frmSelectTaskFields.sAllTaskFields.options[document.frmSelectTaskFields.sAllTaskFields.selectedIndex].text;
	lFieldIndex = document.frmSelectTaskFields.sAllTaskFields.selectedIndex;

	// Check if the option already is selected
	var lIdx;	
	for (lIdx = 0; lIdx < document.frmSelectTaskFields.sSelTaskFields.options.length; lIdx++) {	
		if (document.frmSelectTaskFields.sSelTaskFields.options[lIdx].value == lFieldValue) 
			return;
	}
	
	// now move the Field
	oOption.text=lFieldText;
	oOption.value=lFieldValue;
	
	document.frmSelectTaskFields.sSelTaskFields.add(oOption);
	document.frmSelectTaskFields.sAllTaskFields.remove(lFieldIndex);
	
	document.frmSelectTaskFields.sAllTaskFields.selectedIndex = lFieldIndex;
	DisableTaskSelButtons();
}

function UnSelField() {
	var lFieldName;
	var lFieldValue;
	var lFieldText;
	var oOption = document.createElement("OPTION");
	
	// Move Field
	lFieldValue = document.frmSelectTaskFields.sSelTaskFields.value;
	if (eval(lFieldValue) < 0) return;
		
	lFieldText = document.frmSelectTaskFields.sSelTaskFields.options[document.frmSelectTaskFields.sSelTaskFields.selectedIndex].text;
	lFieldIndex = document.frmSelectTaskFields.sSelTaskFields.selectedIndex;

	// Check if the option is default
	var lDefList = document.frmSelectTaskFields.hDefaultTaskFields.value;
	var lDefArr;
	var lIdx1;
	
	lDefArr = lDefList.split(",");
	for (lIdx1 = 0; lIdx1 < lDefArr.length; lIdx1++) {
		if (eval(lDefArr[lIdx1]) == eval(lFieldValue)) {
			alert("You cannot remove default fields.");
			return;
		}
	}
	
	// now move the Field
	oOption.text=lFieldText;
	oOption.value=lFieldValue;
	
	document.frmSelectTaskFields.sAllTaskFields.add(oOption);
	document.frmSelectTaskFields.sSelTaskFields.remove(lFieldIndex);

	DisableTaskSelButtons();
}

function onUpdateFields() {
	// Update the sel task field list hidden var
	var lSelFields = "";
	var lIdx;	
	for (lIdx = 0; lIdx < document.frmSelectTaskFields.sSelTaskFields.options.length; lIdx++) {	
		lSelFields += document.frmSelectTaskFields.sSelTaskFields.options[lIdx].value + ",";
	}

	lSelFields = lSelFields.substring(0, lSelFields.length-1);
	document.frmSelectTaskFields.hSelTaskFields.value = lSelFields;

	return true;
}
function DisableTaskSelButtons() {
	if (document.frmSelectTaskFields.sSelTaskFields.selectedIndex < 0)
		document.frmSelectTaskFields.bTaskUnSel.disabled = true;
	else
		document.frmSelectTaskFields.bTaskUnSel.disabled = false;

	if (document.frmSelectTaskFields.sAllTaskFields.selectedIndex < 0)
		document.frmSelectTaskFields.bTaskSel.disabled = true;
	else
		document.frmSelectTaskFields.bTaskSel.disabled = false;
}

function MoveFieldUp() {
	var lFieldName;
	var lFieldValue;
	var lFieldText;
	var lOption;
		
	// check Field
	lFieldIndex = document.frmSelectTaskFields.sSelTaskFields.selectedIndex;
	if (lFieldIndex < 1 || lFieldIndex > document.frmSelectTaskFields.sSelTaskFields.options.length) return;
	
	// swap field
	lOption = document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex-1];
	lFieldText = lOption.text;
	lFieldValue = lOption.value;

	document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex-1].text = document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex].text;
	document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex-1].value = document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex].value;

	document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex].text = lFieldText;
	document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex].value = lFieldValue;
	
	document.frmSelectTaskFields.sSelTaskFields.selectedIndex = lFieldIndex-1;
}

function MoveFieldDown() {
	var lFieldName;
	var lFieldValue;
	var lFieldText;
	var lOption;
		
	// check Field
	lFieldIndex = document.frmSelectTaskFields.sSelTaskFields.selectedIndex;
	if (lFieldIndex < 0 || lFieldIndex == document.frmSelectTaskFields.sSelTaskFields.options.length-1) return;
	
	// swap field
	lOption = document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex];
	lFieldText = lOption.text;
	lFieldValue = lOption.value;

	document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex].text = document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex+1].text;
	document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex].value = document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex+1].value;

	document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex+1].text = lFieldText;
	document.frmSelectTaskFields.sSelTaskFields.options[lFieldIndex+1].value = lFieldValue;
	
	document.frmSelectTaskFields.sSelTaskFields.selectedIndex = lFieldIndex+1;
}
</script>
</HEAD>
<%
	Dim lProject
	Dim lTaskID
	
	lProject = Request.QueryString("MSProject")
%>
<BODY onload="DisableTaskSelButtons();">
<TABLE border=1 align=center width=75% class="tdbgdark" style="border-collapse:collapse">
<TR>
<TD align=left>
<FONT class=whiteboldtext>Report Options</FONT>
</TD>
</TR>
</TABLE>
<%
	Dim lPH 
	Dim lFieldArr
	Dim lResArr
	Dim lFieldsSelectStr
	Dim lFieldsSelectedStr
	Dim lOrgFieldsSelCount
	Dim lOrgResSelCount
	Dim lResSelectStr
	Dim lResSelectedStr
	Dim lIdx
	Dim lIdx1
	Dim lDefaultTaskFields
	Dim lDefaultResFields
	Dim lTaskFieldsSel
	Dim lResFieldsSel
	Dim lFound
	Dim lSelTaskFields
	Dim lSelResFields	
	
	lFound = false
	lOrgFieldsSelCount = 0
	lOrgResSelCount = 0
	lFieldsSelectStr = ""
	lFieldsSelectedStr = ""
	lResSelectStr = ""
	lResSelectedStr = ""
	lDefaultTaskFields = "1,2,5,10"
	lDefaultResFields = "1,5,8"
	lTaskFieldsSel = split(lDefaultTaskFields,",")
	lResFieldsSel = split(lDefaultResFields,",")
	lSelTaskFields = "1,2,5,10"
	lSelResFields = "1,5,8"	
	
	Set lPH = Server.CreateObject("MSProjectHTML.MSProjHTML")
	lFieldArr = lPH.GetTaskFields 
	lResArr = lPH.GetResFields 

	For lIdx = 0 to uBound(lFieldArr)-1
		lFound = false
		for lIdx1 = 0 to uBound(lTaskFieldsSel)
			if lIdx = eval(lTaskFieldsSel(lIdx1)) Then
				lFieldsSelectedStr = lFieldsSelectedStr & "<OPTION Value='" & lIdx & "'>" & CStr(lFieldArr(lIdx)) & "</OPTION>"
				lFound = True
				lOrgFieldsSelCount = lOrgFieldsSelCount + 1				
				exit for
			end if 
		next
		
		If Not lFound Then
			lFieldsSelectStr = lFieldsSelectStr & "<OPTION Value='" & lIdx & "'>" & CStr(lFieldArr(lIdx)) & "</OPTION>"			
		End if
	next
%>
<form name="frmSelectTaskFields" action="report-options-set.asp" method="post" onsubmit="return true;">
<input type="hidden" name="hOrgTaskFieldCount" value="<%=lOrgFieldsSelCount%>">
<input type="hidden" name="hOrgResFieldCount" value="<%=lOrgResSelCount%>">
<input type="hidden" name="hSelTaskFields" value="<%=lSelTaskFields%>">
<input type="hidden" name="hSelResFields" value="<%=lSelResFields%>">
<input type="hidden" name="hDefaultTaskFields" value="<%=lDefaultTaskFields%>">
<input type="hidden" name="hDefaultResFields" value="<%=lDefaultResFields%>">

<table width="90%" border="1"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
<tr class="tdbgdark"> 
<td valign=center colspan=2><span class="whiteboldtext">Select Task fields to be displayed</span></td>
</tr>
<tr> 
<td align=middle class="tdbglight" width="50%"> 
<div align="center" class="blacktext"><B>All Fields</B></div>
</td>
<td align="middle" valign="top" width="50%" class="tdbglight"> 
<B>Selected Fields</B>
</td>
</tr>
</table>
<table width="90%" cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">      
<tr> 
<td align="middle" class="tdbglight">
<SELECT size=5 name="sAllTaskFields" style="HEIGHT: 86px; WIDTH: 200px" onchange="return DisableTaskSelButtons();"><%=lFieldsSelectStr%></select>
</td>
<td align="middle" class="tdbglight">
<table>
<tr colspan=1>
<TD><INPUT id="bTaskSel" type="button" value=">" onclick="SelField();"></TD>
</tr>
<tr>
<TD><INPUT id="bTaskUnSel" type="button" value="<" onclick="UnSelField();"></TD>
</tr>
</table>
</td>
<TD align="middle" class="tdbglight">
<SELECT size=5 name="sSelTaskFields" style="HEIGHT: 86px; WIDTH: 200px" onchange="return DisableTaskSelButtons();"><%=lFieldsSelectedStr%></SELECT>
</TD>
<TD class="tdbglight">
<table STYLE="BORDER-COLLAPSE: collapse" class="tdbglight">
<tr colspan=1>
<TD><IMG Src="images/up.gif" onclick="MoveFieldUp();"></TD>
</tr>
<tr>
<TD><IMG Src="images/down.gif" onclick="MoveFieldDown();"></TD>
</tr>
</table>
</TD>
</tr>
</table>
<br>
<table width="90%" border="0"  cellpadding="0" cellspacing="0" align=center STYLE="BORDER-COLLAPSE: collapse">
<tr> 
<td colspan=2 valign="center" align=middle> 
<input type="submit" name="sAddFields" value="Update" style='BACKGROUND-COLOR: aqua'>
<INPUT type="button" Value="Start Page" onclick="OnClickStartPage();" style='BACKGROUND-COLOR: aqua' id=button2 name=button2>
</td>
</tr>
</table>
</form>
</BODY>
</HTML>
