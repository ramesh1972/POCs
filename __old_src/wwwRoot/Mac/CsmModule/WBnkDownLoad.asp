<%@Language=VBSCRIPT%>
<%
'Option Explicit
%>
<%	'**************************************************************************
	'* Application	:	MAC 												  *
	'* Module		:	MAC Module      								      *
	'* File name	:	WBnkDownLoad.asp	    							      *
	'* Purpose		:	This page is used to Display on Revoked TCM's      	  * 
	'* Prepared by	:	P Obula Reddy       	    						  *
	'* Date			:	24.10.2001			 								  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This page is used to Display on Revoked TCM's       					  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   		   C.Satheesh Kumar               First Baseline      *
	'*																		  *
	'**************************************************************************
%>		
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
	<!---#include file="../includes/header.inc"--->
	<br>
	<!--- #include file="../includes/MAClinks.inc" --->
	<br><br>
<%
		DIM lResult
		Dim lObjBnkDownLoad
		dim lResponse
		dim lprev
		dim lnext
		dim lStartDate
		dim separator
		dim lFileSystemObject
		dim lRsFileSystemObject
		set lObjBnkDownLoad = server.CreateObject("Mac.DownWrgDetMgr")
		lStartDate=Request.Form("hidStartDate")
		lResult = lObjBnkDownLoad.DoDownloadRBnk(lStartDate,"1900-01-01:00:00:00.000001","V",lResponse)
		
		separator = split(lResponse,"$")
		Const ForReading = 1, ForWriting = 2, ForAppending = 8
		
		Set lFileSystemObject = CreateObject("Scripting.FileSystemObject")
		Set lRsFileSystemObject = lFileSystemObject.OpenTextFile("c:\inetpub\wwwroot\mac\WngDownLoad-" & replace(date,"/","-") & ".txt",ForWriting,true)
	  	For i = 0 To UBound(separator)
			lRsFileSystemObject.Write separator(i) & vbcrlf
		next
	%>
	
	<Table width="60%" border="1" cellspacing="1" cellpadding="1">
	<tr  width="40%"><td class=tdbgdark><font class=whiteboldtext>Exchange Wrong Account Number  Details</font></td></tr>
	<tr width="40%"><td class=tdbglight>
	<font class=colorboldtext1>The Exchange Wrong Account Number download details has been downloaded.Click <a href="MacClearingSettlement.asp">here</a> to view the previous page</font>
	</td></tr>
	</table>
	<P>&nbsp;</P>
	<!---#include file="../includes/footer.inc"--->
	<br>
	<%
	set lFileSystemObject=nothing
    %>
  </BODY>
 </HTML>
		
		
	