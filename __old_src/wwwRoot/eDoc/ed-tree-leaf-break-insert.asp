<%@ Language=VBScript %>
<% Response.Buffer = True %>
<HTML>
<HEAD>
<!-- #include = file="adovbs.inc" -->
<LINK REL=StyleSheet HREF="theme.css">
</HEAD>
<BODY>
<%
	Dim lNodeID
	Dim lLeafType
	Dim lLeafElementID
	Dim lEDObj
	Dim lNoOfBreaks
	Dim lInsertFormName
	Dim lRadioButtonName
	Dim lDirection
	Dim lLeafElementType
	Dim lBreakInserted
	
	lNodeID = Request.Form("hNodeID")
	lLeafElementID = Request.Form("hLeafElementID")
	lDirection = Request.Form("hDirection")
	
	lInsertFormName = "frmInsertEntity" & lDirection & lLeafElementID
	lRadioButtonName = "rEntity" & lDirection & lLeafElementID
	lLeafElementType = Request.Form(lRadioButtonName)
	lNoOfBreaks = Request.Form("tNoOfBreaks" & lDirection & lLeafElementID)
		
	Set lEDObj = Server.CreateObject ("eDoc.clseDoc")
	lBreakInserted = false 
	
	lBreakInserted = lEDObj.InsertBreak (eval(lNodeID), eval(lNoOfBreaks), eval(lLeafElementID), lDirection)
	if lBreakInserted then
		Response.Redirect ("ed-tree-leaf-edit.asp?NodeID=" & lNodeID)
	end if
%>
</BODY>
</HTML>
