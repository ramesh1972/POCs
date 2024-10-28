<%@ Language=VBScript %>
<HTML>
<HEAD>	
<LINK REL=StyleSheet HREF="theme.css">
</HEAD>
<%
	Dim lProject
	Dim lTaskID
	
	lProject = Request.QueryString("MSProject")
	lTaskID = Request.QueryString("TaskID") 
	if eval(lTaskID) < 1 Then
		lTaskID = 1
	end if
%>
<BODY>
<TABLE border=1 align=center width=75% style="border-collapse:collapse">
<TR>
<TD align=right>
<FONT class=whiteboldtext><A href="report-options.asp">Report Options</A></FONT>
</TD>
</TR>
<TABLE border=1 align=center width=75% class="tdbgdark" style="border-collapse:collapse">
<TR>
<TD align=left>
<FONT class=whiteboldtext>Task Information</FONT>
</TD>
</TR>
</TABLE>
<TABLE border=1 align=center width=75% class="tdbgdark" style="border-collapse:collapse">
<%
	Dim lPH 
	Dim lFile
	
	Set lPH = Server.CreateObject("MSProjectHTML.MSProjHTML")
	
	lFile = "c:\inetpub\wwwroot\msproj\uploadfiles\" & lProject & ".mpp"
	
	Call lPH.Init 
	Call lPH.SetProjFile(lFile) 
	lTree = lPH.GetTaskDetails(eval(lTaskID)) 
%>
<%=lTree%>
</TABLE>
</BODY>
</HTML>
