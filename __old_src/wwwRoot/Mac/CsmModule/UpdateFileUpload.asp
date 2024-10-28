<%@ Language=VBScript %>
<%
  server.ScriptTimeout=180

  Response.Expires=0
  Response.Buffer = TRUE
  Response.Clear
  byteCount = Request.TotalBytes
  
  RequestBin = Request.BinaryRead(byteCount)
  Dim UploadRequest
  Set UploadRequest = CreateObject("Scripting.Dictionary")
  BuildUploadRequest RequestBin
  
  	'uploaing file
  	Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
    contentType = UploadRequest.Item("file1").Item("ContentType")
	filepathname = UploadRequest.Item("file1").Item("FileName")
	filename = Right(filepathname,Len(filepathname)-InstrRev(filepathname,"\"))
	value = UploadRequest.Item("file1").Item("Value")
	strimage1=replace(filename,"'","''")
	'Create and Write to a File
	pathEnd = Len(Server.mappath(Request.ServerVariables("PATH_INFO")))-14
	'on error resume next
	
	dd=day(date)
	if len(dd)=1 then dd="0"&dd
	mm=month(date)
	if len(mm)=1 then mm="0"&mm
	yy=year(date)
	
	webserverdate=cstr(yy)+"-"+cstr(mm)+"-"+cstr(dd)
	filename="tmpBnkdetail.txt"
	
	Set MyFile = ScriptObject.CreateTextFile(server.MapPath(filename))
	For i = 1 to LenB(value)
		 MyFile.Write chr(AscB(MidB(value,i,1)))
	Next
	MyFile.Close
	
	Response.Redirect "bnkupload.asp"
%>


<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<!--#include file="upload.asp"-->
<BODY>

<P>&nbsp;</P>

</BODY>
</HTML>
