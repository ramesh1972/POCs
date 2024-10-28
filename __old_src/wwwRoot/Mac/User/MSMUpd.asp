<%@ Language=VBScript %>

<%
	dim lObjMSMBrowse        
	dim lDisRecords
	dim lNoOfRecords
	dim lResult
	dim lEntyType
	dim lResponse
	dim butAction
	dim gTimeStamp
	dim gTimeStampPrev
	dim gTimeStampNext
	dim Bstatus
	dim lRecCount 
	
	lRecCount=0
	lEntyType = trim(Request.Form("optEntityType"))
	lEntyCode = trim(Request.Form("optEntityCode"))
	
	set lObjMSMBrowse = server.CreateObject("Mac.MSMMgr")
	if Request.Form("hidstatus") ="" then
	   Bstatus = "V"
	else
		Bstatus = Request.Form("hidstatus")
	end if 
	
	if trim(Request.Form("hidtimeStamp"))="" or Bstatus="V" then
	   gTimeStamp="00:00:00"
    else
		gTimeStampNext=trim(Request.Form("hidtimeStampNext"))
		gTimeStampPrev=trim(Request.Form("hidtimeStampPrev"))
	end if
	
	select case Bstatus
		case "N":
			butAction= gTimeStampNext
		case "P":
			butAction=gTimeStampPrev
	    case "V":
		    butAction=gTimeStamp
		case else:
			butAction=gTimeStamp
	end select
	
	if  Bstatus="V" THEN
		select case(lEntyType)
               case "A"	:
                    lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " "," "," "," ", " ", " ", " ", lResponse,lNoOfRecords)
	 		   case "M"	:
        	         lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " ", lEntyType,lEntyCode," ", " ", " ", " ", lResponse,lNoOfRecords)
		       case "B"	:
			        lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " ", lEntyType," "," ", lEntyCode, " ", " ", lResponse,lNoOfRecords)
			   case "I"	:
			        lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " ", lEntyType," ",lEntyCode," ", " "," ", lResponse,lNoOfRecords)
			             
	   end select
   	end if
   	if Bstatus ="N"  or Bstatus ="P" THEN 
	   select case(lEntyType)
	          case "A"	:
        	        lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " "," "," "," ", " ", " ", butAction,lResponse,lNoOfRecords)
	 	      case "M"	:
	    	         lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " ", lEntyType,lEntyCode," ", " ", " ", butAction, lResponse,lNoOfRecords)
		      case "B"	:
			        lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " ", lEntyType," "," ", lEntyCode, " ", butAction, lResponse,lNoOfRecords)
   		      case "I"	:
	    	        lResult = lObjMSMBrowse.DoBrowse("MAS0001000", " ", lEntyType," ",lEntyCode," ", " ",butAction, lResponse,lNoOfRecords)
	
   	    end select
   	end if
   	 
	%>
	<HTML>
   <HEAD>
    <style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
	<Title>Welcome to the Bombay Commodity Exchange Limited</Title>
	<link href="../Includes/Theme.css" title="Contemporary" rel="stylesheet">
   </HEAD>
	<script language="JavaScript">
	
	function FunctionPrevious()
	{
		document.frmMSMUpdate.hidstatus.value ='P';
		document.frmMSMUpdate.method='post';
		document.frmMSMUpdate.action='MSMUpd.asp';
		document.frmMSMUpdate.submit();
	 } 
		                    
	function FunctionNext()
	{
		document.frmMSMUpdate.hidstatus.value ='N';
		document.frmMSMUpdate.method='post';
		document.frmMSMUpdate.action='MSMUpd.asp';
		document.frmMSMUpdate.submit();
	} 
	
	</script>
	<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
	
    <!---#include file="../includes/header.inc"--->
	<br>
    <!---#include file="../includes/MACLinks.inc"--->
	<br>

	<%	
Dim strLn  'used for finding the line
Dim strFld  'Used for finding the Columnsl
strLn = split(mid(lResponse,2),"$")

if lResult=0 then %>
	<table width="516" border="2" cellpadding="1"  cellspacing="1" align="center" height="31">
	<tr class=tdbgdark height=10 align="middle" >
 		<td width="516" height="25">
		 <font class="WhiteBoldtext" align="center">Market Session Management Details</font>
 		</td>
 	</tr>
	</table>
	<table border=1 width="516" align = center height="26" >
	<TR>
		<th class=tdbgdark width="93" align="left" height="22"><font class="WhiteBoldtext">Event Type</font></th>
		<th class=tdbgdark width="126" align="left" height="22"><font class=WhiteBoldtext>Event Code</font></th>
		<th class=tdbgdark width="126" align="left" height="22"><font class=WhiteBoldtext>Event</font></th>
		<th class=tdbgdark width="143" align="left" height="22"><font class=WhiteBoldtext>Event Time</font></th>
		<th class=tdbgdark width="143" align="left" height="22"><font class=WhiteBoldtext>Next Session</font></th>
		<th class=tdbgdark width="143" align="left" height="22"><font class=WhiteBoldtext>Random Delay</font></th>
		<th class=tdbgdark width="143" align="left" height="22"><font class=WhiteBoldtext>Status</font></th>
	</TR>
	</table>
	

	
<%
for i=0 to ubound(strLn)
	strFld=""
	strFld=split(strLn(i),"|")
%>
    <table align=center width="516" border=1  height="26">
		<tr class=tdbglight>
	        <TD width="93" align="middle" height="22">
	        	<form name="frmStr<%=i%>" method=post action="MSMUpdRes.asp?recno=<%=i%>">
				<input name="hidStr<%=i%>" type=hidden value="<%=strLn(i)%>">
				<input type="hidden" name="hidtimeStampPrev" value="<%=gTimeStampPrev%>" >
				<input type="hidden" name="hidtimeStampNext" value="<%=strFld(3)%>">
				<input type="hidden" name="hidstatus">
				<input type=hidden name="hidTotalRec" value="<%=lNoOfRecords%>">
				<input type=hidden name="hidFullString" value="<%=lResponse%>">
				</form>
		     <font class=blacktext2>
		     <a href="#" onclick="document.frmStr<%=i%>.submit();"><%=StrFld(0)%></a></FONT></TD>	   			
			<TD width="126" align="middle" height="22">
				<font class=blacktext2><%Response.Write  strFld(1)%></FONT>
			</TD>
		    <TD width="126" align="middle" height="22">
		        <font class=blacktext2><%Response.Write  strFld(2)%></FONT>
		    </TD>
			
		    <TD width="143" align="middle" height="22">
			    <font class=blacktext2><%Response.Write strFld(3)%></FONT>
		    </TD>
		    <TD width="143" align="middle" height="22">
			    <font class=blacktext2><%Response.Write strFld(4)%></FONT>
		    </TD>
		    <TD width="143" align="middle" height="22">
			    <font class=blacktext2><%Response.Write strFld(5)%></FONT>
		    </TD>
		   <TD width="143" align="middle" height="22">
			    <font class=blacktext2><%Response.Write strFld(6)%></FONT>
		    </TD>
		</tr>
		</table>
    	
<% 
lRecCount=lRecCount+1
next
end if
%>

	
<br>
<table align="center">
<tr class=tdbglight>
<td align="center">

<input type="submit" name="btnPrevious" value="Previous"
<%if  lRecCount<1 or Bstatus="V" then Response.write "disabled"%>onclick="FunctionPrevious();">
<input type="submit" name="btnNext" value="Next"
<%if  lRecCount>0 and lRecCount<10 then Response.write "disabled"%>	onclick="FunctionNext();">
<input type="submit" name="btnCancel" value="Cancel" action ="MSMMenu.asp">
</td>
</tr>
</table>




<!---#include file="../includes/footer.inc"--->
	
</body>
 </HTML>
	
	
	
	