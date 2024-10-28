<%@ Language=VBScript %>
<%
	Response.Expires=0
	Response.Buffer = TRUE
	Response.Clear
	byteCountVar = Request.TotalBytes
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<%
	RequestBin = Request.BinaryRead(byteCountVar)

	Dim UploadRequest
	Set UploadRequest = CreateObject("Scripting.Dictionary")
'	BuildUploadRequest RequestBin
	set fs=server.CreateObject("Scripting.FileSystemObject")

    contentType = UploadRequest.Item("filePath").Item("ContentType")
	filepathname = UploadRequest.Item("filePath").Item("FileName")
	filename = Right(filepathname,Len(filepathname)-InstrRev(filepathname,"\"))

	if byteCountVar<100000 then
		value = UploadRequest.Item("filePath").Item("Value")
		strlogo=replace(filename,"'","''")
		'Create and Write to a File
		pathEnd = Len(Server.mappath(Request.ServerVariables("PATH_INFO")))-14
		'Response.Write filename
		'on error resume next
		set MyFile = ScriptObject.CreateTextFile(server.MapPath(filename))
		For CountVar = 1 to LenB(value)
			 MyFile.Write chr(AscB(MidB(value,CountVar,1)))
		Next
		MyFile.Close
	End If
%>
<BODY>
</BODY>
</HTML>
