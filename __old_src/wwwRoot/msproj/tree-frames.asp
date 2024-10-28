<HTML>
<HEAD>
<LINK REL=StyleSheet HREF="theme.css">
<TITLE></TITLE>
<%
	Dim lProject
	
	lProject = Request.QueryString("MSProject")
	if lProject = "" then
%>
<BR><BR><BR>
<TABLE border=1 align=center width=75% class="tdbglight" style="border-collapse:collapse">
<TR>
<TD align=left>
<FONT class=whiteboldtext>Select a <A href="index.asp">Project Plan</A></FONT>
</TD>
</TR>
</TABLE>
<%
	else
%>

<frameset style="border-width:thin"	name="fseDocument" border="1" cols="40%,*">
	<frame style="border-right:1" frameborder=1 name="fContents" src="tree-contents.asp?MSProject=<%=lProject%>" scrolling="auto">
	<frame style="border-width:thin" frameborder=1 name="fNodeBody" src="tree-view.asp?MSProject=<%=lProject%>" scrolling="auto">
</frameset>

<%
	end if
%>
</HEAD>
</HTML>
