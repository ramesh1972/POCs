<%@ Language=VBScript %>
<%Option Explicit
  dim UploadRequest
  dim ltimestamp
  dim filename
  dim filepathname 
  dim lfileextn
  dim lfileextnlen
  dim lextn 
  dim byteCount 
  dim RequestBin 
  dim PosBeg
  dim i
  dim char
  dim PosEnd
  dim boundary
  dim boundaryPos
  dim Pos
  dim intCount
  dim Name
  dim PosFile
  dim PosBound 
  dim ContentType
  dim value
  dim lyear
  dim lmonth
  dim ldate
  dim ltime
  dim lsecond
  dim tfilename
  dim ScriptObject
  dim MyFile
  dim lFlag
'end of variable declaration
	
  Response.Expires=0
  Response.Buffer = TRUE
  Response.Clear
  byteCount = Request.TotalBytes
  RequestBin = Request.BinaryRead(byteCount)
  Set UploadRequest = CreateObject("Scripting.Dictionary")
  BuildUploadRequest RequestBin

'calling timestamp
  ltimestamp=getTimestamp()

'populating file name 
  filename="file_"&ltimestamp
	
'checking file extn and keep it for in temp var
 filepathname = UploadRequest.Item("lfile").Item("FileName")					
 lfileextn=right(filepathname,6)
 lfileextnlen=instr(lfileextn,".")
 lextn=mid(lfileextn,lfileextnlen)

'assigning filename 
 tfilename=filename&lextn

'writing the binery content
Set ScriptObject = Server.CreateObject("Scripting.FileSystemObject")
 

	if filepathname<>"" then
'	filename = Right(filepathname,Len(filepathname)-InstrRev(filepathname,"\"))
	filename=tfilename
	value = UploadRequest.Item("lfile").Item("Value")
	Set MyFile = ScriptObject.CreateTextFile(server.MapPath(filename))
		For i = 1 to LenB(value)
			 MyFile.Write chr(AscB(MidB(value,i,1)))
		Next
		MyFile.Close
		lFlag="Y"
	end if 
         
'end of uploading

%>
<!--#include file="upload.asp"-->

<%
Function getTimestamp()
lyear=year(now())
lmonth=month(now())
	if len(lmonth)<2 then lmonth="0"&lmonth
ldate=day(now())
	if len(ldate)<2 then ldate="0"&ldate
ltime=FormatDateTime(Now(), vbShortTime)
ltime=replace(ltime,":","") 
lsecond=second(time)
	if len(lsecond)<2 then lsecond="0"&lsecond
	getTimestamp=lyear&lmonth&ldate&ltime&lsecond
End Function

%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY BGCOLOR="#e0ffff">
<br><br><br>
<h2 align="center"><font face="Times New Roman" Size="4" color="#ff0000">Response Information </Font></h2>

<TABLE align="center" WIDTH="75%" BORDER=1 CELLSPACING=1 CELLPADDING=1>
		<TR>
		<TD width="35%"><font face="Times New Roman" Size="4" color="#ff0000">File Uploaded 
			<%If lFlag="Y" then Response.Write "Succesfully" else Response.Write "Failed"%></font></TD>
		<TD width="40%"><font face="Times New Roman" Size="4" color="#ff0000">
			<A href="SelFile.htm">Click here</A> to Upload 
			<%If lFlag="Y" then Response.Write "More" else Response.Write "Again"%></font></TD>
		</TR>
	</TABLE>
</BODY>
</HTML>
	
		


