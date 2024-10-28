<%@ Language=VBScript %>
<HTML>
<HEAD>
<LINK REL=StyleSheet HREF="theme.css">

<!-- #include = file="adovbs.inc" -->
<!-- #include file="ed-common-selects.asp" -->
<!-- #include file="ed-tree-node-leaf-entity-insert.asp" -->
<!-- #include file="ed-tree-leaf-para-edit.asp" -->
<!-- #include file="ed-tree-leaf-break-edit.asp" -->

<script language="javascript" src="ed-tree-node-leaf.js">
</script>
<script language="javascript" src="ed-tree-leaf-para.js">
</script>
<script language="javascript" src="ed-tree-leaf-table.js">
</script>
</HEAD>

<BODY>
<script language="javascript">
parent.frames("fContents").document.location = "ed-contents-edit.asp";
</script>

<TABLE align="center" width=100%>
<TR>
<TD align="right"><A href="ed-tree-leaf-view.asp?NodeID=<%=lNodeID%>">View</A></TD>
</TR>
</TABLE>

<%
	Dim lNodeID
	Dim lNodeType
	Dim lLeafType
	Dim lLeafElementID
	Dim lEDObj
	Dim lRs
	Dim lFormAction
		
	lNodeID = Request.QueryString("NodeID")
	lNodeType = Request.QueryString("NodeType")
	
	Set lEDObj = Server.CreateObject ("eDoc.clseDoc")
	Set lRs = Server.CreateObject("ADODB.RecordSet")
	
	lLeafElementID = 0
	Set lRs = lEDObj.GetLeafLets  (eval(lNodeID))

	'Create the Folder/Leaf insert here 
	Call TreeSectionInsert(lNodeID) 
%>
<HR>
<%
	Dim gTableCount
	
	gTableCount = 0
	if lRs.RecordCount > 0 then
		lRs.MoveFirst 
		while Not lRs.EOF 
			' Based on the type of leaf element display the para, table etc...
			lLeafType = trim(lRs("TL_LeafType"))
			lLeafElementID = trim(lRs("TL_LeafElementID"))

			' Create the standard Insert toolbar
			Call TreeLeafEntityInsert(lNodeID, lLeafElementID)
			
			if lLeafType = "PARA" Then
				Call TreeLeafParaEdit(lEDObj, lNodeID, lLeafElementID)
			end if
			
			if lLeafType = "BREAK" Then
				Call TreeLeafBreakEdit(lEDObj, lNodeID, lLeafElementID)
			end if
			
			lRs.MoveNext 
		wend
	end if
		
	' Put the Insert toolbar here after all the elements in this leaf
	Call TreeLeafEntityAfterInsert(lNodeID, lLeafElementID)
%>
<HR>
<% 
	'Create the Folder/Leaf insert here
	Call TreeSectionAfterInsert(lNodeID) 
%>
</BODY>
</HTML>
