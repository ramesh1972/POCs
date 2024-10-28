<%@ Language=VBScript %>
<% Response.Buffer = True 
	Server.ScriptTimeout = 1500
%>
<HTML>
<HEAD>
<!-- #include = file="adovbs.inc" -->
<LINK REL=StyleSheet HREF="theme.css">
</HEAD>
<BODY>
<%
	Dim lNewNodeTitle
	Dim lNewLeafTitle
	Dim lNodeID
	Dim lNewNodeID
	Dim lDirection
	Dim lRadioButtonName
	Dim lRadioLeafType
	Dim lNodeType	
	Dim lNodeInserted
			
	Dim lLeafType
	Dim lLeafElementID
	Dim lEDObj
	Dim lParaTitle
	Dim lPara
	Dim lLeafElementType
	Dim lParaInserted
	Dim lLeafInserted
	Dim lParentNodeID
	Dim lNodePosition
	Dim lNewLeafID
	Dim lFromURL
		
	lNewNodeTitle = Request.Form("tSectionNodeTitle")
	lNewLeafTitle = Request.Form("tSectionLeafTitle")
	lNodeID = Request.Form("hNodeID")
	lDirection = Request.Form("hDirection")
	lRadioButtonName = "rSection" & lDirection
	lNodeType = Request.Form(lRadioButtonName)
	lRadioLeafType = Request.Form("rEntity" & lDirection) 
	lNodeInserted = false
	lLeafInserted = false
	lFromURL = Request.Form("hFromURL")
	
	Set lEDObj = Server.CreateObject  ("eDoc.clseDoc")
	
	if lNodeType = "Folder" Then 
		' Create a new row in eD_tree with node type as Node
		lNewNodeID = lEDObj.InsertNode (eval(lNodeID), lNewNodeTitle, lDirection)
			
		If lNewNodeID <> -1 Then
			' Create a new leaf in the newly created node
			lNewLeafID = lEDObj.InsertLeaf(eval(lNewNodeID), 0, lDirection, lNewLeafTitle)
		end if	

		Response.Redirect ("ed-tree-leaf-view.asp?NodeID=" & lNewLeafID & "&RefreshContents=true")
	elseif lNodeType = "Leaf" Then
		' Create a new leaf in the newly created node
		Set lNodeRs = Server.CreateObject ("ADODB.RecordSet")
		Set lNodeRs = lEDObj.GetNodeDetails(eval(lNodeID))
	
		if lNodeRs.RecordCount > 0 Then
			' Get Parent Node iD and position
			lParentNodeID = eval(lNodeRs("T_ParentNode"))
			lNodePosition = eval(lNodeRs("T_Position"))
			
			lNewLeafID = lEDObj.InsertLeaf(lParentNodeID, eval(lNodeID), lDirection, lNewLeafTitle)
			Response.Redirect ("ed-tree-leaf-view.asp?NodeID=" & lNewLeafID & "&RefreshContents=true")
		end if
	end if
%>
</BODY>
</HTML>
