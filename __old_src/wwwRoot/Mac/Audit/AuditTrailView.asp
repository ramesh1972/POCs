<%@ Language=VBScript %>

<%
Dim lAuditRs
Dim lAuditObj
Dim lUserid
lUserid = Request.Form("hiduserid")

Dim lTransCode
lTransCode = Request.Form("hidtransType")
Dim lContCode
lContCode = Request.Form("hidContCode")
Dim lDateSt 
lDateSt = Request.Form("txtDtSt")
Dim lTimeSt
lTimeSt = Request.form("txtTmSt")

Dim  LTimeStamp
LTimeStamp = lDateSt + " : " +  lTimeSt


Dim lmacusercode 'As Variant
Dim lmlgusercode 'As Variant
Dim lmlgtimestamp 'As Variant
Dim ipcuserid 'As Variant
Dim ipcbroketimestamp 'As Variant
Dim ipccompanyno 'As Variant
Dim ipcreqtrxcode 'As Variant
Dim ipctradingcode 'As Variant
Dim lresbuffer 'As Variant
Dim lreccount 'As Long
Dim lResult 'As Integer
dim obj
set obj = server.CreateObject("Mac.AtsMgr")


lResult = obj.DoBrowse("MZE0006000",lUserid, "0001-01-01:00:00:00.000000", ipcuserid, "1001-01-01:00:00:00.000000", ipccompanyno,lTransCode, ipctradingcode, lresbuffer, cdbl(lreccount))


MyString = "Mid Function Demo"   ' Create text string.

FirstWord = Mid(MyString, 1, 3)   ' Returns "Mid".


'LastWord = Mid(MyString, 14, 4)   ' Returns "Demo".
'MidWords = Mid(MyString, 5)   ' Returns "Function Demo".


dim RecCount
	RecCount=cint(lreccount)
	Response.Write reccount
	if lResult = 0 then
		Dim strLn  'used for finding the line
		Dim strFld 'Used for finding the Columns
		strLn = Split(lresbuffer,"$") 'here EOL is used to find the End Of File(VbCrlf)
		'Response.Write strLn(0)
		Dim i 
		Dim FstPpPos  'used to find the First Pipe Character Position
		FstPpPos = InStr(1,lresbuffer, "|")
		Dim fstPpChar 'is used to find the character between start and Fist Character
		fstPpChar = Mid(lresbuffer,1, FstPpPos - 1)
end if
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<form id=form1 name=form1>
<table width="100%" border="1" align="center">
<tr>
	<td align="center" width=10%><font class=Whitetext>Userid</font></td>
	<td align="center" width=20%><font class=Whitetext>Time Stamp</font></td>
	<td align="center" width=5%><font class=Whitetext>Transaction</font></td>
	<td align="center" width=10%><font class=Whitetext>Contract Code </font></td>
	<td align="center" width=10%><font class=Whitetext>Order Ref No</font></td>
	<td align="center" width=5%><font class=Whitetext>Code</font></td>
	<td align="center" width=5%><font class=Whitetext>Request</font></td>
	<td align="center" width=5%><font class=Whitetext>Response</font></td>
</tr>
</table>
<%
For i = 0 To UBound(strLn)-1
	    strFld = Split(strLn(i), "|")
		'Response.Write strFld(10) & " <br> "
%>
<table width="100%" border="1" align="center">
<tr>
	<td width="10%"><%=strFld(0)%></td>
	<td width="20%"><%=trim(strFld(3))%></td>
	<td width="5%"><%=strFld(5)%> </td>
	<td width=10%><%=strFld(9)%></td>
	<td width=10%><%=strFld(4)%></td>
	<td width=8%><%=strFld(6)%></td>
	<td width=5%><%=strFld(7)%></td>
	<td width=5%><%=strFld(8)%></td>
</tr>
</table>
<% next %>		
<center>
	<input type="submit" name="subReq" value="Request">
	<input type="submit" name="subRes" value="Response">
</center>

</form>
</BODY>
</HTML>
