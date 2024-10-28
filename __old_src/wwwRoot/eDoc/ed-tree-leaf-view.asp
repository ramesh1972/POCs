<%@ Language=VBScript %>
<HTML>
<HEAD>	
<LINK REL=StyleSheet HREF="theme.css">

<!-- #include = file="adovbs.inc" -->
<!-- #include file="ed-tree-node-leaf-entity-insert.asp" -->
<!-- #include = file="ed-tree-leaf-para-view.asp" -->
<!-- #include = file="ed-tree-leaf-break-view.asp" -->
<!-- #include = file="ed-tree-leaf-para-edit.asp" -->
<!-- #include = file="ed-tree-leaf-break-edit.asp" -->

<script language="javascript" src="ed-common-selects.js">
</script>
<script language="javascript" src="ed-tree-node-leaf.js">
</script>
<script language="javascript" src="ed-tree-node-leaf.js">
</script>
<script language="javascript" src="ed-tree-leaf-para.js">
</script>
<script language="javascript" src="ed-tree-leaf-table.js">
</script>
</HEAD>

<BODY>
<%
	Dim lNodeID
	Dim lNodeType
	Dim lLeafElementID
	Dim lLeafElementIDFromRs
	Dim lLeafType
	Dim lEDObj
	Dim lRs
	Dim lRefreshContents
	Dim lGotoElement 
		
	lNodeID = Request.QueryString("NodeID")
	lNodeType = Request.QueryString("NodeType")
	lLeafElementID = Request.QueryString("LeafElementID")
	lRefreshContents = Request.QueryString("RefreshContents")
	lGotoElement = Request.QueryString("GotoElement")
	
	if lRefreshContents = "true" Then
%>
<script language="javascript">
parent.frames("fContents").document.location = "ed-contents-view.asp";
</script>
<%
	end if
	
	' Insert the Web Folder/Page bar before current page
	Call TreeFolderPageInsert(eval(lNodeID), "Before")
	
	Set lEDObj = Server.CreateObject ("eDoc.clseDoc")
	Set lRs = Server.CreateObject("ADODB.RecordSet")
	Set lRs = lEDObj.GetLeafLets  (eval(lNodeID))

	if lRs.RecordCount > 0 then
		lRs.MoveFirst 
		while Not lRs.EOF 
			' Based on the type of leaf element display the para, table etc...
			lLeafType = trim(lRs("TL_LeafType"))
			lLeafElementIDFromRs = trim(lRs("TL_LeafElementID"))
			
			' The insert element toolbar
			Call TreePageElementInsert(eval(lNodeID), eval(lLeafElementIDFromRs), "Before")
			
			if lLeafType = "PARA" Then
				if lLeafElementID = lLeafElementIDFromRs Then
					Call TreeLeafParaEdit(lEDObj, lNodeID, lLeafElementID)
				else
					Call TreeLeafParaView(lEDObj, lRs)
				end if
			elseif lLeafType = "BREAK" Then
				if lLeafElementID = lLeafElementIDFromRs Then			
					Call TreeLeafBreakEdit(lEDObj, lNodeID, lLeafElementID)
				else
					Call TreeLeafBreakView(lEDObj, lRs)
				end if
			end if
			
			lRs.MoveNext()
		wend

		' The insert element toolbar
		Call TreePageElementInsert(eval(lNodeID), eval(lLeafElementIDFromRs), "After")
	else
		' The insert element toolbar
		Call TreePageElementInsert(eval(lNodeID), 0, "Before")
%>
		Leaf contents not found<BR>
<%
		' The insert element toolbar
		Call TreePageElementInsert(eval(lNodeID), 0, "After")
	end if	
	
	' Insert the Web Folder/Page bar before current page
	Call TreeFolderPageInsert(eval(lNodeID), "After")
	
	if lGotoElement <> "" Then
%>
		<script language="javascript">
		document.location.href  = "#<%=lGotoElement%>";
		</script>
<%
	end if
%>
</BODY>
</HTML>
