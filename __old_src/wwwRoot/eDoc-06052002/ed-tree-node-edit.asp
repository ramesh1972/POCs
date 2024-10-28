<%@ Language=VBScript %>
<HTML>
<HEAD>
<!-- #include = file="adovbs.inc" -->
<LINK REL=StyleSheet HREF="theme.css">
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
function ToggleNode() {
	var lRadioValue = document.frmInsertSectionBefore.rSectionBefore;

	if (lRadioValue[1].checked) {
		document.all.dSectionTitle.innerHTML = "Enter Leaf Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
	else if (lRadioValue[0].checked) {
		document.all.dSectionTitle.innerHTML = "Enter Folder Title<BR><Input type='text' maxlength=256 size=60 name='tSectionNodeTitle'><BR>Enter Leaf Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
}

function ToggleNodeAfter() {
	var lRadioValue = document.frmInsertSectionAfter.rSectionAfter;

	if (lRadioValue[1].checked) {
		document.all.dSectionTitleAfter.innerHTML = "Enter Leaf Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
	else if (lRadioValue[0].checked) {
		document.all.dSectionTitleAfter.innerHTML = "Enter Folder Title<BR><Input type='text' maxlength=256 size=60 name='tSectionNodeTitle'><BR>Enter Leaf Title<BR><Input type='text' maxlength=256 size=60 name='tSectionLeafTitle'>";
	}
}
//-->
</SCRIPT>
<%
	Dim lNodeID
	Dim lNodeType
	
	lNodeID = Request.QueryString("NodeID")
	lNodeType = Request.QueryString("NodeType")
%>
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
<% 'Create the Folder/Leaf insert here %>
<FORM name="frmInsertSectionBefore" method="post" action="ed-tree-node-insert.asp">
<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Insert Section Before Node</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=100% border=1 class="tlightb" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD width=50% align="left"><input type="radio" name="rSectionBefore" Value="Folder" onclick="ToggleNode();">Folder</TD>
	<TD width=50% align="left"><input type="radio" name="rSectionBefore" Value="Leaf" checked onclick="ToggleNode();">Leaf</TD>
</TR>
</TABLE>
<TABLE align="center" width=100% border=1 class="tlightb" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD width=100%><div id="dSectionTitle"></div></TD>
</TR>
<TR>
	<TD align='center'><INPUT type=submit value='Insert Section'>
	</TD>
</TR>
</TABLE>

<input type="hidden" name="hNodeID" Value="<%=lNodeID%>">
<input type="hidden" name="hDirection" Value="Before">
<input type="hidden" name="hFromURL" Value="Node">
</FORM>	

<script language="javascript">
ToggleNode();
</script>

<HR>
<% 'Create the Folder/Leaf insert here %>
<FORM name="frmInsertSectionAfter" method="post" action="ed-tree-node-insert.asp">
<TABLE align="center" width=100% class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD><font class="whiteboldtext">Insert Section After Node</font></TD>
</TR>
</TABLE>

<TABLE align="center" width=100% border=1 class="tlightb" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD width=50% align="left"><input type="radio" name="rSectionAfter" Value="Folder" onclick="ToggleNodeAfter();">Folder</TD>
	<TD width=50% align="left"><input type="radio" name="rSectionAfter" Value="Leaf" checked onclick="ToggleNodeAfter();">Leaf</TD>
</TR>
</TABLE>
<TABLE align="center" width=100% border=1 class="tlightb" STYLE='BORDER-COLLAPSE: collapse'>
<TR>
	<TD width=100%><div id="dSectionTitleAfter"></div></TD>
</TR>
<TR>
	<TD align='center'><INPUT type=submit value='Insert Section' id=submit1 name=submit1>
	</TD>
</TR>
</TABLE>

<input type="hidden" name="hNodeID" Value="<%=lNodeID%>">
<input type="hidden" name="hDirection" Value="After">
<input type="hidden" name="hFromURL" Value="Node">
</FORM>
<script language="javascript">
ToggleNodeAfter();
</script>
</BODY>
</HTML>
