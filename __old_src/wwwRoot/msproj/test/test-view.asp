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
<TABLE border=1 align=center width=75% class="tdbgdark" style="border-collapse:collapse">
<TR>
<TD align=left>
Task Information
</TD>
</TR>
</TABLE>
<TABLE border=1 align=center width=75% class="tdbgdark" style="border-collapse:collapse">
<%
	Dim lPH 
	Dim lFile
	
	Set lPH = Server.CreateObject("MSProjectHTML.MSProjHTML")
	
	lFile = "c:\inetpub\wwwroot\msproj\uploadfiles\" & lProject & ".mpp"
	
	Call lPH.SetProjFile(lFile) 
	'lTree = lPH.GetTaskDetails(lTaskID) 
%>
<%=lTree%>
</TABLE>
</BODY>
</HTML>