<%@ Language=VBScript%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
 <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
</HEAD>
<BODY marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor">
<center>
<%

Const ForReading = 1 , ForWriting = 2
  Dim fso, f
  dim filename
  Set fso = CreateObject("Scripting.FileSystemObject")
  
  
    dd=day(date)
	if len(dd)=1 then dd="0"&dd
	mm=month(date)
	if len(mm)=1 then mm="0"&mm
	yy=year(date)	
	hr=hour(time)
	if len(hr)=1 then hr="0"&hr
	mn=minute(time)
	if len(mn)=1 then mn="0"&mn
	sc=second(time)
	if len(sc)=1 then hr="0"&sc	
	webserverdate=cstr(yy)+"-"+cstr(mm)+"-"+cstr(dd)
	webservertime=cstr(hr)+"."+cstr(mn)+"."+cstr(sc)
	
	tmpfilename="tmpBnkdetail.txt"
	filename="tcmm2mdetail-"&webserverdate+"."+webservertime+".txt"
  
    fso.CopyFile server.MapPath(tmpfilename),server.MapPath(filename)
    fso.DeleteFile(server.MapPath(tmpfilename)) 




Response.Write "hai" & "<br>"
Response.Write Request.Form("txtValue")
Response.Write "after"
dim lpstrzero
dim lpstr1
dim lpstr2
dim lpstr3
dim lpstr4
dim lpstr5
dim lpstr6
dim lRecCount
dim lResult
dim mrkBul

lpstrzero = Request.Form("hidfldzero")
Response.Write lpstrzero
lpstr1    = Request.Form("hidfld2")
Response.Write lpstr1 
lpstr2 = Request.Form("hidfld3")
lpstr3 = Request.Form("hidfld1")
lpstr4 = Request.Form("hidfld4")
lpstr5 = Request.Form("hidfld5")
lpstr6 = Request.Form("hidfld6")


'**
set mrkBul = server.CreateObject("MAC.BankUploadMgr")
lResult  = mrkBul.DoBnkUpload(lpstrzero,lpstr1,lpstr2,lpstr3,lpstr4,lpstr5,lpstr6,lRecCount)
Response.Write lRespStr
Response.Write lResult  
'Response.Write optMkrAdd
Response.Write "lResult=" & lResult	 
select case lresult
case "0":
	lResponse = "The Record has been Added"
case "1800":
	lResponse = "The System Date doesn't match"
case "1100":
	lResponse = "The Record already exists"
case "9598":
	lResponse = "The Connection to the Server cannot be established"
case "57309":
	lResponse = "Record Already Exists"
case "-8227":
	lResponse = "Record Already Exists"
End Select%>

<Table width="40%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Market Contract Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1><%=lResponse%> Click <a href="MktctnMod.asp">here</a> to view the previous page</font>
	</td></tr>
	</table>
<P>&nbsp;</P>

	
	<br>
	
	
</BODY>
</HTML>


