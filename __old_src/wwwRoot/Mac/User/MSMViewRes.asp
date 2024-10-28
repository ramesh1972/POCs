<%@ Language=VBScript %>

<%
	dim lObjMSMBrowse        
	dim lDisRecords
	dim lNoOfRecords
	dim lResult
	dim lEntyType

	lEntyType = trim(Request.Form("optEntityType"))
	lEntyCode = trim(Request.Form("optEntityCode"))
	'Response.Write "Entity Type = " & lEntyType & "<BR>"
	'Response.Write "Entity Code = " & lEntyCode & "<BR>"
	
	set lObjMSMBrowse = server.CreateObject("Mac.MSMMgr")
	
	'Response.Write "Before calling the Dll" & "<BR>"
    'ia = a.DoBrowse("MAS0001000", " ", " ", " ", " ", " ", " ", " ", msval, rec) 'All
	'ia = a.DoBrowse("MAS0001000", "2002-01-02", "M", "BOOE", " ", " ", " ", " ", msval, rec) 'Market browse
	'ia = a.DoBrowse("MZE0006000", " ", "B", " ", " ", "BOOE", " ", " ", msval, rec) 'bastek browse
	'ia = a.DoBrowse("MZE0006000", " ", "I", " ", "RBDPAM0102", " ", " ", " ", msval, rec) ' Contract Browse
	'ia = a.DoBrowse("MAS0001000", " ", " ", " ", " ", " ", " ", "18:00:00", msval, rec) 'Next(Pass the last record's event time)
	'ia = a.DoBrowse("MAS0001000", " ", " ", " ", " ", " ", " ", "18:00:00", msval, rec) 'Previous (Same Like Next
                
	'Response.Write "event type=" & lEntyType 	
	select case(lEntyType)
           case "M"	    :
             lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " ",lEntyType, lEntyCode," ", " "," "," ", lDisRecords,lNoOfRecords)
		   case "E"	    :
             lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " "," "," "," ", " ",lEntyCode," ", lDisRecords,lNoOfRecords)
	       case "B" :
			  lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " ",lEntyType," "," ", lEntyCode, " ", " ", lDisRecords,lNoOfRecords)
           case "I" :
			  lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " ",lEntyType," ",lEntyCode, " ", " "," ", lDisRecords,lNoOfRecords)
         case "A" :
			  lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " "," "," "," ", " ", " ", " ", lDisRecords,lNoOfRecords)
	   
	    end select
	

		'Response.Write "Result = " & cint(lResult) & " <br>"
		'Response.Write  "Display Records = " & lDisRecords & "<br>"
		'Response.Write "No Of Records = " & cint(lNoOfRecords) & " <br>"
	%>
	<head>
	<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
	<title>Welcome to the Bombay Commodity Exchange Limited</title>
	<form  name="frmMSMUpdate">
	<script language="JavaScript">
   /*function FunctionUpdate()
   {
    document.FrmMSMUpdate.action="MSMUpdRes.asp";
    document.FrmMSMUpdate.method="post";
    document.FrmMSMUpdate.submit();
   }*/
   function FunctionCancel()
   {
    document.frmMSMUpdate.action="MSMMenu.asp";
    document.frmMSMUpdate.submit();
   }
   </script>       
   <body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	<!---#include file="../Includes/header.inc"---><br>
	<!--#include file="../Includes/MACLinks.inc" ----><br>
	<%
	if lResult= 0 then
		Response.Write "<table border='1' cellspacing='1' cellpadding='1' align='center'>"
		Response.Write "<tr class='tdbgdark'><td colspan='7'>"
		Response.Write "<font class='whiteboldtext1'>Market Session Management</font></td> </tr>"
		Response.Write "<tr class='tdbgdark'><td width='10'><font class='whiteboldtext1'>Entity Type</font></td>"
		Response.Write "<td><font class='whiteboldtext1'>Entity Code</font></td><td><font class='whiteboldtext1'>Event</font></td>"
		Response.Write "<td><font class='whiteboldtext1'>Event Time</font></td><td><font class='whiteboldtext1'>Next Session</font></td>"
		Response.Write "<td><font class='whiteboldtext1'>Random Delay</font></td>"
		Response.Write "<td><font class='whiteboldtext1'>Status</font></td>"
		Response.Write "</tr>"
		
	'Response.Write "Come from Tandem = " & lDisRecords
	'	Response.Write "After str = " & mid(lDisRecords,2)

		lIndRecord = split(mid(lDisRecords,2),"$")
		lTotalRecords = ubound(lIndRecord)
		'Response.Write "Total Records = " & lTotalRecords
'		lIndValue = split(lIndRecord(lIndRecordCount),"|")

		
		for lIndRecordCount = 0 to ubound(lIndRecord)
'		for lIndRecordCount = 0 to lTotalRecords
'		Response.Write ubound(lIndRecord)
		lIndValue = split(lIndRecord(lIndRecordCount),"|")
		lTotalFields = ubound(lIndValue)
		'Response.Write "No of Fields= " & lTotalFields
			Response.Write "<tr class='tdbglight'>"
			
			'for lndValueCount = 0 to ubound(lIndValue)-1
'			for lndValueCount = 0 to lTotalFields -1
			for lndValueCount = 0 to 6
			
				Response.Write "<td align='left'>" & "<font align='left' class='blacktext1'>" &lIndValue(lndValueCount) & "</font></td>"
			next
			Response.Write "</tr>"
			
		next
		Response.Write "</table>"
		
	else
		Response.Write "No Value"
	end if
	
	set lObjMSMBrowse = nothing
'	Response.Write lEntyType
	%>
	<br>
	<table align="Center">
	<tr class="tdbglight">
	<td align="center">
	<!--	input type="submit" align="center" name="btnBrowse" value="Update" onclick="FunctionUpdate();">-->
    <input type="submit" align="center" name="btnCancel" value="Cancel" onclick="FunctionCancel();">
    </td>
    </tr>
    </table>
   </form>
   </body>
   </html>
   

