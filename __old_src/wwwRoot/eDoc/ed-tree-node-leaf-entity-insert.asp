<% 
Function TreeFolderPageInsert(piNodeID, piDirection)
	'Create the Folder/Leaf insert here 
	if piDirection <> "After" Then
		piDirection = ""
	end if

	if piDirection = "After" Then
%>
		<BR><BR><HR>
<%  end if %>

	<TABLE align="center" width=100%>
	<TR>
	<TD align="right"><A href="javascript:here();" onclick="ToggleFolderPageInsert<%=piDirection%>(<%=piNodeID%>);"><font style ="Color:darkgreen;">Insert Web Folder/Page</font></A></TD>
	</TR>
	<TR>
	<TD><div id="divFolderPage<%=piDirection%>" name="divFolderPage<%=piDirection%>"></div></TD>
	</TR>
	</TABLE>
<%
	if piDirection = "" Then
%>
		<HR>
<%  end if
end function
%>

<% 
Function TreePageElementInsert(piNodeID, piLeafElementID, piDirection)
	'Create the Folder/Leaf insert here 
	if piDirection <> "After" Then
		piDirection = ""
	end if
%>
	<BR><BR>
	<TABLE align="center" width=100%>
	<TR>
	<TD align="right"><A href="javascript:here();" onclick="TogglePageElementInsert<%=piDirection%>(<%=piNodeID%>, <%=piLeafElementID%>);"><font style ="Color:silver;">Insert Web Element</font></A></TD>
	</TR>
	<TR>
	<TD><div id="divPageElementInsert<%=piDirection%><%=piLeafElementID%>" name="divPageElementInsert<%=piDirection%><%=piLeafElementID%>"></div></TD>
	</TR>
	</TABLE>
	<input type=hidden name=hInsertElementExpanded<%=piDirection%><%=piLeafElementID%> value="false">
	<BR><BR>
<% 
end function
%>

