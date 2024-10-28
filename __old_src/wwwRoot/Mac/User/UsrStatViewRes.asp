<%@ Language=VBScript %>
	<%
	dim lObjUserStatus
	dim lResult
	dim lUserType
	dim lUserId
	dim lStatus
	dim lCompanyId
	dim lActionValue
	dim poRecCount
	dim poFRecDate
	dim poLRecDate
	dim poReportStr
	
	dim lRecSep
	dim lIndRecord
	dim lRecCounter
	dim lValueCounter
	
	lUserType	= trim(Request.Form("optUserType"))
	lUserId		= trim(Request.Form("optUserId"))
	lStatus		= trim(Request.Form("optStatus"))
	lCompanyId	= trim(Request.Form("optCompanyId"))
	lActionValue= trim(Request.Form("hidActionValue"))
		
	set lObjUserStatus	=	server.CreateObject("Mac.UsrAndCompanyBrowseMgr")

'lResult = lObjUserStatus.UsrBorwse(lUserType,lUserId,lStatus,lCompanyId, "1900-01-01:01:01:01.000001", _
 '      "V","MZE0006000", cint(poRecCount), poFRecDate, poLRecDate, poReportStr)

	
	lResult = lObjUserStatus.UsrBrowse(lUserType, lUserId,lStatus,lCompanyId,"1900-01-01:01:01:01.000001", _
			 "V", "MZE0006000", cint(poRecCount), poFRecDate, poLRecDate, poReportStr)

	
	'Response.Write "String = " & poReportStr
	
	lRecSep = Split(poReportStr, "$")
	%>
	<html>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor >
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	<table width="80%" border="1"  cellpadding=1 cellspacing=1 align="center">
	<tr class="tdbgdark"> 
			<td valign=center width="80%" colspan=4 height="27"><font class="whiteboldtext1"> User Status Browse </font></td>
	</tr>
	<tr class="tdbgdark"> 
			<td valign=center align=center width="20%" height="27"><font class="whiteboldtext1"> User ID</font></td>
			<td valign=center align=center width="20%" height="27"><font class="whiteboldtext1"> Status</font></td>
			<td valign=center align=center width="20%" height="27"><font class="whiteboldtext1"> From Date</font></td>
			<td valign=center align=center width="20%" height="27"><font class="whiteboldtext1"> End Date</font></td>
	</tr>
	
	
	<tr class="tdbglight"> 
	<%For lRecCounter = 0 To UBound(lRecSep)
		lIndRecord = Split(lRecSep(lRecCounter), "|")
		For lValueCounter = 0 To UBound(lIndRecord) %>
			<td height="27" align=center  width="20%">
				<font align="left" class="blacktext"> 
				<%if lValueCounter = 0 then %>
					<a href= "UsrStatChange.asp?uid=<%=lIndRecord(lValueCounter)%>&st=<%=lIndRecord(lValueCounter+1)%>&sd=<%=lIndRecord(lValueCounter+2)%>&ed=<%=lIndRecord(lValueCounter+3)%>"><%=lIndRecord(lValueCounter)%> </a>
				<%else%>
					<%=lIndRecord(lValueCounter)%>
				<%end if%>
				
				</td>
	    <%Next%>
	    </tr>
	<%Next %>
	</table>

	<br>
	<table width="80%" border="1"  cellpadding=1 cellspacing=1 align="center">
	<tr class="tdbgdark" > 
			<td valign=center width="80%" colspan=4 height="16"><font class="whiteboldtext1">User Status Legend</font></td>
	</tr>
	<tr class="tdbglight"> 
			<td valign=center align=left width="20%" height="27"><font class="blacktext">N - Active</font></td>
			<td valign=center align=left width="20%" height="27"><font class="blacktext">H - Halt</font></td>
			<td valign=center align=left width="20%" height="27"><font class="blacktext">P - Procedural Suspension</font></td>
			<td valign=center align=left width="20%" height="27"><font class="blacktext">D - Disciplinary Suspension</font></td>
	</tr>
	</table>
	
	<br><br><!---#include file="../includes/footer.inc"--->
	</body>
	</html>