<%@language="vbscript"%>
<%
%>
<HTML>
	<HEAD>
	<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
	<TITLE>Market Price Statistics</TITLE>
	<link rel="stylesheet" href="../Includes/Theme.css">
	</HEAD>
<BODY>
<Center>
	<!--#include file="../includes/header.inc"-->
	<br>
	<!--- #include file="../includes/MAClinks.inc" --->
	<br>

<form name="frmMpsview" method="post" action="MpsView.asp">
<script language="JavaScript">
		function FunctionPrevious()
	    {
		   document.frmMpsview.hidStatus.value='P';
		   document.frmMpsview.method='post';
		   document.frmMpsview.action="MpsView.asp";
		   document.frmMpsview.submit();
		}   
		function FunctionNext()
		{   
		   document.frmMpsview.hidStatus.value='N'; 
		   document.frmMpsview.method='post';
		   document.frmMpsview.action="MpsView.asp";
		   document.frmMpsview.submit();
		}
		
		function FunctionCancel()
		{   
		   document.frmMpsview.action="MPSSelection.asp";
		   document.frmMpsview.submit();
		}  
		  
		 
	</script>	  
<%
dim objMPS
Dim lRecordCount
Dim lRespStr
Dim lResult
dim strContCode
dim Bstatus
dim gTimeStampPrev
dim gTimeStampNext
dim gTimeStamp

	strContCode=Request.Form("selContract")
	if strContCode="ALL" then
	   strContCode=""
    end if
    
  
    if Request.Form("hidstatus") ="" then
	   Bstatus = "B"
	else
		Bstatus = Request.Form("hidstatus")
		lContCode=Request.Form("hidContCode")
	end if 
	
	if Bstatus="B" then
	   gTimeStamp="1900-01-01:00:00:00.000000"
	else
		gTimeStampNext=trim(Request.Form("hidtimeStampNext"))
		gTimeStampPrev=trim(Request.Form("hidtimeStampPrev"))
	end if
	
    if trim(Request.Form("hidResCode")) ="100" then
	   gTimeStamp="  1900-01-01:00:00:00.000000"
	   Bstatus = "B"
    end if
    
    select case Bstatus
		   case "N":
			     butAction= mid(gTimeStampNext,1,26)
		   case "P":
			     butAction=MID(gTimeStampPrev,1,26)
	       case "B":
		         butAction=gTimeStamp
		   case else:
			    butAction=gTimeStamp
	end select
	
	set objMPS=server.CreateObject("Mac.MarketPriceStatsMgr")

	if Bstatus="B" THEN
	   lResult = objMPS.DoBrowse(strContCode, butAction, Bstatus,"MAS0001000",lRespStr, lRecordCount)
	end if 
	
	if Bstatus ="N"  or Bstatus ="P" THEN 
	   lResult = objMPS.DoBrowse(hidContCode, butAction, Bstatus,"MAS0001000",lRespStr, lRecordCount)
    end if  
	
	Dim strLn  'used for finding the line
	Dim strFld  'Used for finding the Columns
	strLn = Split(lRespStr,"$")  'here EOL is used to find the End Of File(VbCrlf)
	if trim(lResult)=0 then%>
	
	<TABLE border="1"  cellpadding=1 cellspacing=1 >
	<TR class=tdbgdark>
			<TD><font class=whiteboldtext1>Contract Code</font></TD>
			<TD><font class=whiteboldtext1>Last Traded Price</font></TD>
			<TD><font class=whiteboldtext1>Last Traded Date</font></TD>
			<TD><font class=whiteboldtext1>Last Traded Volume</font></TD>
			<TD><font class=whiteboldtext1>Opening Price</font></TD>
			<TD><font class=whiteboldtext1>Closing Price</font></TD>
			<TD><font class=whiteboldtext1>Previous Closing Price</font></TD>
			<TD><font class=whiteboldtext1>High Price</font></TD>
			<TD><font class=whiteboldtext1>Low Price</font></TD>
			<TD><font class=whiteboldtext1>Cummulative Trade Volume</font></TD>
			<TD><font class=whiteboldtext1>Cummulative Trade Value</font></TD>
			<TD><font class=whiteboldtext1>No.Of Trades</font></TD>
	</TR>
	<%
	for intLnNO= 0 to ubound(strLn) -1
	    strFld=""
		strFld=split(strLn(intLnNO),"|")
	%>
		<tr class=tdbglight>
				<td><%=strFld(0)%></td>
				<td><%=cdbl(strFld(1))/100 &".00"%></td>
				<td><%=mid(strFld(2),1,10)%></td>
				<td><%=strFld(3)%></td>
				<td><%=CDBL(strFld(4))/100 & ".00"%></td>			
				<td><%=cdbl(strFld(5))/100 & ".00"%></td>			
				<td><%=CDBL(strFld(6))/100 & ".00"%></td>			
				<td><%=cdbl(strFld(7))/100 & ".00"%></td>			
				<td><%=cdbl(strFld(9))/100 & ".00"%></td>
				<td><%=strFld(11)%></td>			
				<td><%=cdbl(strFld(12))/100 & ".00"%></td>			
				<td><%=strFld(13)%></td>						
		</tr>
				
		<%
		 IF intLnNO=0  then 
	        gTimeStampPrev=strFld(14)
	       end if 
	
		 IF intLnNO=9  then 
		    gTimeStampNext=strFld(14)
		 end if 
		 lRecordCount=lRecordCount+1
	  	next%>			
	<%end if%>
	</TABLE>
	
	<TABLE>
		<tr class=tdbglight height=30 align="center">
		 <td>
		  <input name="btnPrevious" type="Submit" value = "Previous" 
		   <%if  lRecordCount<1 or Bstatus="B" then Response.write "disabled"%>
   			onclick ="FunctionPrevious();">
		  <input name="btnNext"     type="Submit" value = "Next    " 
		  <%if  lRecordCount>0 and lRecordCount<10 then Response.write "disabled"%>
		    onclick ="FunctionNext();">
		  <input name="btnCancel"   type="Reset"  value = "Cancel"   onclick ="FunctionCancel();">
		
	  	</td>
		</tr>
	</TABLE>
	<input type="hidden" name="hidStatus">
	<input type="hidden" name="hidtimeStampPrev" value="<%=gTimeStampPrev%>" >
	<input type="hidden" name="hidtimeStampNext" value="<%=gTimeStampNext%>">
	<input type ="hidden" name="hidContCode" value=<%= strContCode%>>
	</CENTER>
</form>
<br>
<!---#include file="../includes/footer.inc"--->

</BODY>
</HTML>
	