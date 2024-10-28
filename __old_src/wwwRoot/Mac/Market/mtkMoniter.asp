<%@language="vbscript"%>
<%
dim objMktMon
set objMktMon=server.CreateObject("Mac.MarketMonitorMgr")
dim strResponse
if trim(Request.Form("subView"))="View" then
	strResponse = objMktMon.DoBrowse("BOOE", lcode, ldesc, lmax, lmin, ldrip, lcir, lseet, lmaop, lgex, lgey, lgez, lgeed, lgesd, lmx, lmy, lmz, lmed, lmes, lsmm, lpas, locpc, locpd, lmlot, ltic)
	''''''''''''''''Response.Write strResponse & lcode & ldesc
	If Trim(strResponse) = 0 Then
		'Response.Write "correct"
		Dim strXMLStart 
		Dim strXMLEnd 
		strXMLStart = "<xml id='dsoData'>" & vbCrLf
		strXMLStart = strXMLStart & "<span>" & vbCrLf
		strXMLStart = strXMLStart & "<MktMonitor>" & vbCrLf
		strXMLStart = strXMLStart & "<rsRow>" & vbCrLf
		Response.Write strXMLStart
		Dim strXMLBody 
		strXMLBody = "<ZRow>" & vbCrLf
		strXMLBody = strXMLBody & "<marketcode>" & lcode & "</marketcode>" & vbCrLf
		strXMLBody = strXMLBody & "<marketdesc>" & ldesc & "</marketdesc>" & vbCrLf
		strXMLBody = strXMLBody & "<maxordersize>" & lmax & "</maxordersize>" & vbCrLf
		strXMLBody = strXMLBody & "<minordersize>" & lmin & "</minordersize>" & vbCrLf
		strXMLBody = strXMLBody & "<mindripprcnt>" & ldrip & "</mindripprcnt>" & vbCrLf
		strXMLBody = strXMLBody & "<circfilter>" & lcir & "</circfilter>" & vbCrLf
		strXMLBody = strXMLBody & "<settcircfilter>" & lseet & "</settcircfilter>" & vbCrLf
		strXMLBody = strXMLBody & "<ticksize>" & ltic & "</ticksize>" & vbCrLf
		strXMLBody = strXMLBody & "<marketlot>" & lmlot & "</marketlot>" & vbCrLf
		strXMLBody = strXMLBody & "<maop>" & lmaop & "</maop>" & vbCrLf
		strXMLBody = strXMLBody & "<lstmoddate>" & lmed & "</lstmoddate>" & vbCrLf
		strXMLBody = strXMLBody & "<ocpduration>" & locpd & "</ocpduration>" & vbCrLf
		strXMLBody = strXMLBody & "<ocpnooftrades>" & locpc & "</ocpnooftrades>" & vbCrLf
		strXMLBody = strXMLBody & "<pwdvalidperiod>" & lpas & "</pwdvalidperiod>" & vbCrLf
		strXMLBody = strXMLBody & "<gelwarnx>" & lgex & "</gelwarnx>" & vbCrLf
		strXMLBody = strXMLBody & "<gelwarny>" & lgey & "</gelwarny>" & vbCrLf
		strXMLBody = strXMLBody & "<gelwarnz>" & lgez & "</gelwarnz>" & vbCrLf
		strXMLBody = strXMLBody & "<gelfactored>" & lgeed & "</gelfactored>" & vbCrLf
		strXMLBody = strXMLBody & "<gelfactorsd>" & lgesd & "</gelfactorsd>" & vbCrLf
		strXMLBody = strXMLBody & "<mtmwarnx>" & lmx & "</mtmwarnx>" & vbCrLf
		strXMLBody = strXMLBody & "<mtmwarny>" & lmy & "</mtmwarny>" & vbCrLf
		strXMLBody = strXMLBody & "<mtmwarnz>" & lmz & "</mtmwarnz>" & vbCrLf
		strXMLBody = strXMLBody & "<mtmfactored>" & lmed & "</mtmfactored>" & vbCrLf
		strXMLBody = strXMLBody & "<mtmfactorsd>" & lmes & "</mtmfactorsd>" & vbCrLf
		strXMLBody = strXMLBody & "<smmpercent>" & lsmm & "</smmpercent>" & vbCrLf
		strXMLBody = strXMLBody & "</ZRow>" & vbCrLf
		Response.Write strXMLBody
	else
		Response.Write "Error Occurred"
	end if
	strXMLEnd = strXMLEnd & "</rsRow>" & vbCrLf
	strXMLEnd = strXMLEnd & "</MktMonitor>" & vbCrLf
	strXMLEnd = strXMLEnd & "</span>" & vbCrLf
	strXMLEnd = strXMLEnd & "</xml>"
	Response.write strXMLEnd
	set objMktMon=nothing
elseif trim(Request.Form("subUpdate"))="Update" then
	'Response.Write "U hve pressed Update button" &"<br>"
	'objmktMon.MktMonUpdate "BOOE",trim(Request.Form("txtMktDesc")),trim(Request.Form("txtMaxOrdSize")),trim(Request.Form("txtMinOrdSize")),trim(Request.Form("txtMinDrip")),trim(Request.Form("txtDlyCktFil")),trim(Request.Form("txtSetCktFil")),trim(Request.Form("txtTickSize")),trim(Request.Form("txtMktLot")),trim(Request.Form("txtMAOP")),"2001-11-07:12:40:46.606979",trim(Request.Form("txtOCPDur")),trim(Request.Form("txtOCPNoOfTrd")),trim(Request.Form("txtPwdValPd")),trim(Request.Form("txtGELwlX")),trim(Request.Form("txtGELwlY")),trim(Request.Form("txtGELwlZ")),trim(Request.Form("txtFctGELed")),trim(Request.Form("txtFctGELsd")),trim(Request.Form("txtM2MwlX")),trim(Request.Form("txtM2MwlY")),trim(Request.Form("txtM2MwlZ")),trim(Request.Form("txtFctM2Med")),trim(Request.Form("txtFctM2Msd")),trim(Request.form("txtSMM"))
	'objmktMon.MktMonUpdate ,,"2001-11-07:12:40:46.606979",,,,,,,
	dim strRetVal
	strRetVal=objmktMon.DoUpdate("","BOOE",trim(Request.Form("txtMktDesc")),trim(Request.Form("txtMaxOrdSize")),trim(Request.Form("txtMinOrdSize")),trim(Request.Form("txtMinDrip")),trim(Request.Form("txtDlyCktFil")),trim(Request.Form("txtSetCktFil")),trim(Request.Form("txtMAOP")),trim(Request.Form("txtGELwlX")),trim(Request.Form("txtGELwlY")),trim(Request.Form("txtGELwlZ")),trim(Request.Form("txtFctGELed")),trim(Request.Form("txtFctGELsd")),trim(Request.Form("txtM2MwlX")),trim(Request.Form("txtM2MwlY")),trim(Request.Form("txtM2MwlZ")),trim(Request.Form("txtFctM2Med")),trim(Request.Form("txtFctM2Msd")),trim(Request.form("txtSMM")),trim(Request.Form("txtPwdValPd")),trim(Request.Form("txtOCPNoOfTrd")),trim(Request.Form("txtOCPDur")),trim(Request.Form("txtMktLot")),trim(Request.Form("txtTickSize")))
	'Response.Write strRetVal
	IF strRetVal=0 then
		dim strUpVal
		strUpVal="S"
	%>
	<script language="javascript">
		function upMsg()
		{
			alert("Updated Sucessfully");
		}
		upMsg()
	</script>
	<%else%>
	<script language="javascript">
		function upMsgFail()
		{
			alert("Not Updated");
		}
		upMsgFail()
	</script>
	<%end if%>
	<%set objmktmon=nothing
end if
%>
<HTML>
<HEAD>
<style>
	a {text-decoration:none}
	a:hover { color:#3333FF}
	</style>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<TITLE>Market Moniter Screen</TITLE>
<link rel="stylesheet" href="../Includes/Theme.css">
<script language="Javascript">
var strValMarkDes="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxys. ";
	var strOnlyNos="0123456789.";
	var intOnly="0123456789";
	var previousText="";
	function isValid(textobject,strCharSent,ErrMsg)
	{
		if (strCharSent=="MD")
			{
				var ValidChars=strValMarkDes;
			}		
		else if (strCharSent=="ON")
			{
				var ValidChars=strOnlyNos;	
			}
		else if (strCharSent=="IN")
			{
				var ValidChars=intOnly;	
			}
		else
			{
				return false;
			}
		var newText=textobject.value;
		var intI;
		var intJ;
		var strValid=false;
		var intLength;
		var replaceText="";
		var newTextLength=newText.length;
		intLength=ValidChars.length;
		for (intI=0;intI < newTextLength;intI++)
		{
			strValid=false;
			for (intJ=0;intJ < intLength;intJ++)
			{
				if (newText.charAt(intI)==ValidChars.charAt(intJ))
				{
					replaceText=replaceText + newText.charAt(intI);
					strValid=true;
					intJ=intLength;
				}
			}
				if (!strValid)
				{
					alert("Error  " + "\n\n" +newText.charAt(intI) + "    is Not Allowed In This Context");
					textobject.focus();
					textobject.value=replaceText;
					previousText=newText;
					return false;
				}
		}
		return strValid;	
	}
</script>
</HEAD>
<BODY onload="document.frmMktMoniter.txtMktCode.disabled=true;">
<br>
<!---#include file="../includes/header.inc"--->
<br>
<!---#include file="../includes/MACLinks.inc"--->
<br>
<form name="frmMktMoniter" method="post" action ="mtkMoniter.asp" >
<table align="center" DATASRC="#dsoData" datafld="rsRow" width="639"><tr><td width="631">
<table align="center" datasrc="#dsoData" datafld="ZRow" id="tblData" width="692" border="1" cellpadding=1  cellspacing=1 style="left: 1px; top: 3px" height="572">
	<tr class=tdbgdark height=20 align=middle><td align=left colspan=4 height="19" width="473">
        <p align="center"><font class=whiteboldtext1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        Market Moniter</font></p>
    </td></tr>
	<tr class=tdbglight height=20 align=left>
		<td width ="259" height=1>Market Code:</td>
		<TD width ="205" height="1"><INPUT name="txtMktCode" maxLength="4" DATAFLD="marketcode" size="27"></TD>
		<td height="1" width="401">Market Description:</td>
		<td height="1" width="243"><INPUT name="txtMktDesc" DATAFLD="marketdesc" size="27" onblur="isValid(this,'MD')"></td>
    </tr>
    <tr class=tdbglight height=30 align=left>
		<td height="1" width="259">Min Order Size:</td>
		<td height="1" width="205"><INPUT name="txtMinOrdSize" DATAFLD="minordersize" size="27" maxlength="5" onblur="isValid(this,'IN')"></td>
		<td height="1" width="401">Max Order Size:</td>
		<td height="1" width="243"><INPUT name="txtMaxOrdSize" DATAFLD="maxordersize" size="27" maxlength="5" onblur="isValid(this,'IN')"></td>
    </tr>
    <tr class=tdbglight height=30 align=left>
		<td height="1" width="259">Tick Size:</td>
		<td height="1" width="205"><INPUT name="txtTickSize" DATAFLD="ticksize" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
		<td height="1" width="401">Market Lot:</td>
		<td height="1" width="243"><INPUT name="txtMktLot" DATAFLD="marketlot" size="27" maxlength="5" onblur="isValid(this,'IN')"></td>
    </tr>
    <tr class=tdbglight height=30 align=left>
		<td height="1" width="259">Daily Circuit Filter:</td>
		<td height="1" width="205"><INPUT name="txtDlyCktFil" DATAFLD="circfilter" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
		<td height="1" width="401">Settlement Circuit Filter:</td>
		<td height="1" width="243"><INPUT name="txtSetCktFil" DATAFLD="settcircfilter" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
    </tr>
       <tr class=tdbglight height=30 align=left>
			<td height="1" width="259">Minimum Drip:</td>
			<td height="1" width="205"><INPUT name="txtMinDrip" datafld="mindripprcnt" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
			<td height="1" width="401">OCP Duration:<BR><FONT size=2><STRONG>(OCP-Official 
			Closing Price)</STRONG></FONT></td><td height="1" width="243"><INPUT name="txtOCPDur" DATAFLD="ocpduration" size="27" onblur="isValid(this,'IN')"></td>
       </tr>
       <tr class=tdbglight height=30 align=left>
			<td height="1" width="259">Password Validation Period:<BR> 
			<FONT size=2><STRONG>(In Days)</STRONG></FONT></td>
			<td height="1" width="205"><INPUT name="txtPwdValPd" DATAFLD="pwdvalidperiod" size="27" maxlength="4" onblur="isValid(this,'IN')"></td>
			<td height="1" width="401">SMM Percentage:<BR><FONT size=2><STRONG>(Special Margin Money)</STRONG></FONT></td>
			<td height="1" width="243"><INPUT name="txtSMM" DATAFLD="smmpercent" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
       </tr>
      <tr class=tdbglight height=30 align=left>
			<td height="1" width="259">OCP No.Of Trades:</td>
			<td height="1" width="205"><INPUT name="txtOCPNoOfTrd" DATAFLD="ocpnooftrades" size="27" maxlength="5" onblur="isValid(this,'IN')"></td>
			<td height="1" width="401">MAOP:<BR><FONT size=2><STRONG>(Maximum Allowable Open Position)</STRONG></FONT></td>
			<td height="1" width="243"><INPUT name="txtMAOP" DATAFLD="maop" size="27" maxlength="5" onblur="isValid(this,'IN')"></td>
      </tr>
      <tr class="tdbgdark" height=20 align="middle" width="40%">
		<td colspan=2 height="14" width="438"><font class=whiteboldtext1>Gross Exposure Limit</font></td>
		<td colspan=2 height="14" width="473"><font class=whiteboldtext1>Mark To Market Loss</font></td>
	  </tr>
	  <tr class=tdbglight height=30 align="left">
		<td height="1" width="259">Warning Level X:</td>
		<td height="1" width="205"><INPUT name="txtGELwlX" DATAFLD="gelwarnx" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
		<td height="1" width="401">Warning Level X:</td>
		<td height="1" width="243"><INPUT name="txtM2MwlX" DATAFLD="mtmwarnx" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
	  </tr>
      <tr class=tdbglight height=30 align="left">
		<td height="1" width="259">Warning Level Y:</td>
		<td height="1" width="205"><INPUT name="txtGELwlY" DATAFLD="gelwarny" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>      
		<td height="1" width="401">Warning Level Y:</td>
		<td height="1" width="243"><INPUT name="txtM2MwlY" DATAFLD="mtmwarny" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
      </tr>
      <tr class=tdbglight height=30 align="left">
		<td height="1" width="259">Warning Level Z:</td>
		<td height="1" width="205"><INPUT name="txtGELwlZ" DATAFLD="gelwarnz" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
		<td height="1" width="401">Warning Level Z:</td>
		<td height="1" width="243"><INPUT name="txtM2MwlZ" DATAFLD="mtmwarnz" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
      </tr>
      <tr class=tdbglight height=30 align="left">
		<td height="1" width="259">Factor ED:</td>
		<td height="1" width="205"><INPUT name="txtFctGELed" DATAFLD="gelfactored" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
		<td height="1" width="401">Factor ED:</td>
		<td height="1" width="243"><INPUT name="txtFctM2Med" DATAFLD="mtmfactored" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
      </tr>
      <tr class=tdbglight height=30 align="left">
		<td height="1" width="259">Factor SD:<BR><FONT size=2><STRONG>( ED-Equity 
		Deposit SD-Security Deposit)</STRONG></FONT></td>
		<td height="1" width="205"><INPUT name="txtFctGELsd" DATAFLD="gelfactorsd" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
		<td height="1" width="401">Factor SD:<BR><FONT size=2><STRONG>( ED-Equity 
		Deposit SD-Security Deposit)</STRONG></FONT></td>
		<td height="1" width="243"><INPUT name="txtFctM2Msd" DATAFLD="mtmfactorsd" size="27" maxlength="5" onblur="isValid(this,'ON')"></td>
      </tr>
      <tr class=tdbglight height=30 align=left width="40%">
		<td colspan=4 height="1" width="473">
			<center>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="submit" name="subView" Value="View">
				<input type="submit" name="subUpdate" Value="Update" <%if trim(strUpVal)="S" then%> disabled <%end if%>>
				<input type="reset" value="Clear">
            </center>
		</td>
      </tr>
</table>
</td></tr>
</table>
</form>
<!---#include file="../includes/footer.inc"--->
</BODY>
</HTML>
