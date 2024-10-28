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
	Dim lParaTitle
	Dim lPara
	Dim lInsertFormName
	Dim lRadioButtonName
	Dim lDirection
	Dim lLeafElementType
	Dim lParaInserted
	Dim lNewParaID
		
	lNodeID = Request.Form("hNodeID")
	lLeafElementID = Request.Form("hLeafElementID")
	lDirection = Request.Form("hDirection")
	
	lInsertFormName = "frmInsertEntity" & lDirection & lLeafElementID
	lRadioButtonName = "rEntity" & lDirection & lLeafElementID
	lLeafElementType = Request.Form(lRadioButtonName)
	lParaTitle = Request.Form("tbParaTitle" & lDirection & lLeafElementID)
	lPara = Request.Form("taPara" & lDirection & lLeafElementID)
		
	Set lEDObj = Server.CreateObject ("eDoc.clseDoc")
	lParaInserted = true 
	
	lParaInserted = lEDObj.InsertPara(eval(lNodeID), lParaTitle, lPara, eval(lLeafElementID), lDirection, lNewParaID)
	
	if lParaInserted then
		Response.Redirect ("ed-tree-leaf-view.asp?NodeID=" & lNodeID & "&GotoElement=Para" & lNewParaID)
	end if
%>
</BODY>
</HTML>
