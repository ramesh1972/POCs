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
	Dim lUpdateFormName
	Dim lBreakUpdate
	
	lNodeID = Request.Form("hNodeID")
	lLeafElementID = Request.Form("hLeafElementID")
	
	lInsertFormName = "frmUpdateBreak" & lLeafElementID
	lNoOfBreaks = Request.Form("tNoOfBreaks" & lLeafElementID)
		
	Set lEDObj = Server.CreateObject ("eDoc.clseDoc")
	lBreakUpdate = false 
	
	lBreakUpdate = lEDObj.UpdateBreak(eval(lNodeID), lNoOfBreaks, eval(lLeafElementID))
	if lBreakUpdate then
		Response.Redirect ("ed-tree-leaf-view.asp?NodeID=" & lNodeID)
	end if
%>
</BODY>
</HTML>
