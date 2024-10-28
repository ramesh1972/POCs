  <%@ Language=VBScript %>
  <%'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	UserCompDetRes.asp									  *
	'* Purpose		:	This is used for							  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	12/12/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'*																		  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   12/12/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************		

	dim lObjUserCompDet
	dim lResult
	dim lUserId
	dim	lUserType
	dim	lCoyCode
	dim	lExchCode
	dim	lAppNo
	dim	lFName
	dim	lMName
	dim	lLName
	dim	lGender
	dim	lDMonth
	dim	lDDate
	dim	lDYear
	dim	lPAdd1
	dim	lPAdd2
	dim	lPAdd3
	dim	lPhone
	dim	lFax
	dim	lEmailId
	dim	lPanNo
	dim	lCAdd1
	dim	lCAdd2
	dim	lCAdd3
	dim	lCPName
	dim	lSTNo
	dim	lCSTNo
	dim	lRegFee
	dim	lEFee
	dim	lDeposit
	dim	lSMonth
	dim	lSDate
	dim	lSYear
	dim lActionValue
	dim lDOB
	dim lStartDate
	dim lEYear 
	dim lEMonth
	dim lEDate
	dim lEndDate
	dim lResultValues
		
	lUserId		= trim(Request.Form("optUserId"))
	lUserType	= trim(Request.Form("optUserType"))
	lCoyCode	= trim(Request.Form("optCoyCode"))
	lExchCode	= trim(Request.Form("optExchCode"))
	lAppNo		= trim(Request.Form("txtAppNo"))
	lFName		= trim(Request.Form("txtFName"))
	lMName		= trim(Request.Form("txtMName"))
	lLName		= trim(Request.Form("txtLName"))
	lGender		= trim(Request.Form("optGender"))
	lDMonth		= trim(Request.Form("optDMonth"))
	lDDate		= trim(Request.Form("optDDate"))
	lDYear		= trim(Request.Form("optDYear"))
	lPAdd1		= trim(Request.Form("txtPAdd1"))
	lPAdd2		= trim(Request.Form("txtPAdd2"))
	lPAdd3		= trim(Request.Form("txtPAdd3"))
	lPhone		= trim(Request.Form("txtPhone"))
	lFax		= trim(Request.Form("txtFax"))
	lEmailId	= trim(Request.Form("txtEmailId"))
	lPanNo		= trim(Request.Form("txtPanNo"))
	lCAdd1		= trim(Request.Form("txtCAdd1"))
	lCAdd2		= trim(Request.Form("txtCAdd2"))
	lCAdd3		= trim(Request.Form("txtCAdd3"))
	lCPName		= trim(Request.Form("txtCPName"))
	lSTNo		= trim(Request.Form("txtSTNo"))
	lCSTNo		= trim(Request.Form("txtCSTNo"))
	lRegFee		= trim(Request.Form("txtRegFee"))
	lEFee		= trim(Request.Form("txtEFee"))
	lDeposit	= trim(Request.Form("txtDeposit"))
	lSMonth		= trim(Request.Form("optSMonth"))
	lSDate		= trim(Request.Form("optSDate"))
	lSYear		= trim(Request.Form("optSYear"))
	lEMonth		= trim(Request.Form("optEMonth"))
	lEDate		= trim(Request.Form("optEDate"))
	lEYear		= trim(Request.Form("optEYear"))
	lDOB		= lDYear & "-" & lDMonth & "-" & lDDate
	lStartDate	= lSYear & "-" & lSMonth & "-" & lSDate
	lEndDate	= lEYear & "-" & lEMonth & "-" & lEDate
	lActionValue	= trim(Request.Form("hidActionValue"))
	
	'Response.Write lActionValue
	
	set lObjUserCompDet	=	server.CreateObject("Mac.UserAndCompanyDetailsMgr")
	
	if lActionValue = "V"  then 
		lResult	= lObjUserCompDet.UserView(lActionValue,lUserId,"MNA0003000",poResult)
		Response.Write "Result = " & lResult & "<br>"
		lResultValues	= split(poResult,"|")
		if lResult <> 0 then
			Response.Write "Error = " & lResult
			select case(lResult)
				case	"100"	:	Response.Write "End of File"
				case	"-100"	:	Response.Write "Minus End of File"
				case	"1000"	:	Response.Write "Invalid User Id"
				case	"2600"	:	Response.Write "Invalid Exchange"
				case	"3000"	:	Response.Write "Invalid Company Id"
				case	"1200"	:	Response.Write "Wrong Choice"
				case	"1600"	:	Response.Write "Invalid User Type"			
				case	"1800"	:	Response.Write "Client MAchine date is not current date"
				case	"8227"	:	Response.Write "Primary key violation"
				case	"-8227"	:	Response.Write "Minus Primary key violation"
			end select
		else%>
		<html>
		<head>
		<title>Bombay Commodity Exchange Limited</title>
		<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		</head>
		<!---#include file="../includes/header.inc"--->
		<br><!--#include file="../Includes/MACLinks.inc" ----><br>
		<body>
		<form name="frmUserCompanyDetails" action="UsrCompDetView.asp" method=post>
		<table border="1" cellspacing="1" cellpadding="1" width="90%" align="center">
			<tr class=tdbglight width="100%">
				<td align="left" height="25" colspan="4"> <font class=blackboldtext>User Company Details</font></td>
			</tr>
			<tr class=tdbglight width="100%">
				<td align="left" height="20" width="15%"> <font class=blacktext>User ID </font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optUserId" style="height: 22px; width: 199px" disabled>
						<option selected value="<%=lResultValues(1)%>"><%=lResultValues(1)%></option>
					</select>
				<td align="left" height="20" width="15%"> <font class=blacktext>User Type *</font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optUserType" style="height: 22px; width: 199px" disabled>
						<option value="<%=lResultValues(2)%>" selected><%=lResultValues(2)%></option>
					</select>
			</tr>
			<tr class=tdbglight width="100%">
				<td align="left" height="20" width="15%"> <font class=blacktext>Company Code </font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optCoyCode" style="height: 22px; width: 199px" disabled>
						<option value="<%=lResultValues(3)%>" selected><%=lResultValues(3)%></option>
					</select>
				<td align="left" height="20" width="15%"> <font class=blacktext>Exchange Code *</font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optExchCode" style="height: 22px; width: 199px" disabled>
						<option value="<%=lResultValues(0)%>" selected><%=lResultValues(0)%></option>
					</select>
			</tr>
			<tr class=tdbglight width="100%">
				<td align="left" height="20" width="15%"> <font class=blacktext>App. NO </font></td>
				<td size="15" maxlength="10" width="25%"><input type=text name="txtAppNo" value="<%=lResultValues(4)%>" style="height: 22px; width: 199px" disabled></td>
				<td align="left" height="20" width="15%"> <font class=blacktext>First Name </font></td>
				<td size="15" maxlength="10" width="25%"><input type=text name="txtFName" value="<%=lResultValues(5)%>" style="height: 22px; width: 199px" disabled></td>
			</tr>
			<tr class=tdbglight width="100%">
				<td align="left" height="20" width="15%"> <font class=blacktext>Middle Name </font></td>
				<td size="15" maxlength="10" width="25%"><input type=text name="txtMName" value="<%=lResultValues(6)%>" style="height: 22px; width: 199px" disabled></td>
				<td align="left" height="20" width="15%"> <font class=blacktext>Last Name *</font></td>
				<td size="15" maxlength="10" width="25%"><input type=text name="txtLName" value="<%=lResultValues(7)%>" style="height: 22px; width: 199px" disabled></td>
			</tr>
			<tr class=tdbglight width="50%">
				<td align="left" height="20" width="15%"> <font class=blacktext>Gender *</font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optGender" style="height: 22px; width: 199px" disabled>
						<option selected value="<%=lResultValues(9)%>" ><%=lResultValues(9)%></option>
				</select>
				<%lDMonth	= mid(trim(lResultValues(8)),6,2)
'				Response.Write "Whole = " & lResultValues(8)
'				Response.Write "Month = " & lDMonth & "<br>"
				if left(lDMonth,1)="0" then
					lDMonth	= mid(lDMonth,2,1)
				end if
'				Response.Write "Month = " & lDMonth & "<br>"
				lDDate	= mid(trim(lResultValues(8)),9,2)
'				Response.Write "Date = " & lDDate & "<br>"
				if left(lDDate,1)="0" then
					lDDate	= mid(lDDate,2,1)
				end if
'				Response.Write "Date = " & lDDate & "<br>"
				lDYear	= left(trim(lResultValues(8)),4)
'				Response.Write "Year = " & lDYear & "<br>"
				%>
				<td class=tdbglight width="15%" height="20"><font class=blacktext>Date of Birth *</font></td>
				<td  class=tdbglight height="20" width="25%"> 
				<select size="1" name="optMonth" disabled>
					<option  value="1" <%if lDMonth=1 then Response.Write "selected"%>>January</option>
					<option value="2" <%if lDMonth=2 then Response.Write "selected"%>>February</option>
					<option value="3" <%if lDMonth=3 then Response.Write "selected"%>>March</option>
					<option value="4" <%if lDMonth=4 then Response.Write "selected"%>>April</option>
					<option value="5" <%if lDMonth=5 then Response.Write "selected"%>>May</option>
					<option value="6" <%if lDMonth=6 then Response.Write "selected"%>>June</option>
					<option value="7" <%if lDMonth=7 then Response.Write "selected"%>>July</option>
					<option value="8" <%if lDMonth=8 then Response.Write "selected"%>>August</option>
					<option value="9" <%if lDMonth=9 then Response.Write "selected"%>>September</option>
					<option value="10" <%if lDMonth=10 then Response.Write "selected"%>>October</option>
					<option value="11" <%if lDMonth=11 then Response.Write "selected"%>>November</option>
					<option value="12" <%if lDMonth=12 then Response.Write "selected"%>>December</option>
				</select> 
				<select size="1" name="optDate" disabled>
					<option  value="1" <%if lDDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lDDate=2 then Response.Write "selected"%>>2</option>
					<option value="3" <%if lDDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lDDate=4 then Response.Write "selected"%>>4</option>
					<option value="5" <%if lDDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lDDate=6 then Response.Write "selected"%>>6</option>
					<option value="7" <%if lDDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lDDate=8 then Response.Write "selected"%>>8</option>
					<option value="9" <%if lDDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lDDate=10 then Response.Write "selected"%>>10</option>
					<option value="11" <%if lDDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lDDate=12 then Response.Write "selected"%>>12</option>
					<option value="13" <%if lDDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lDDate=14 then Response.Write "selected"%>>14</option>
					<option value="15" <%if lDDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lDDate=16 then Response.Write "selected"%>>16</option>
					<option value="17" <%if lDDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lDDate=18 then Response.Write "selected"%>>18</option>
					<option value="19" <%if lDDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lDDate=20 then Response.Write "selected"%>>20</option>
					<option value="21" <%if lDDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lDDate=22 then Response.Write "selected"%>>22</option>
					<option value="23" <%if lDDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lDDate=24 then Response.Write "selected"%>>24</option>
					<option value="25" <%if lDDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lDDate=26 then Response.Write "selected"%>>26</option>
					<option value="27" <%if lDDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lDDate=28 then Response.Write "selected"%>>28</option>
					<option value="29" <%if lDDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lDDate=30 then Response.Write "selected"%>>30</option>
					<option value="31" <%if lDDate=31 then Response.Write "selected"%>>31</option>
				</select>&nbsp;
				<select name="optYear"  size="1" disabled>
					<option value="<%=lDYear%>" selected ><%=lDYear%></option>
					<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
					<option value="<%=lYear%>" ><%=lYear%></option>
				</select>
				</td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan="4"> <font class=blackboldtext>Permanent Address</font></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Per.Address1 * </font></td>
				<td size="15" maxlength="10"><input type=text name="txtPAdd1" value="<%=lResultValues(16)%>" disabled>	</td>
				<td align="left" height="20"> <font class=blacktext>Per.Address2 </font></td>
				<td size="15" maxlength="10"><input type=text name="txtPAdd2" value="<%=lResultValues(17)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Per.Address3 </font></td>
				<td size="15" maxlength="10"><input type=text name="txtPAdd3" value="<%=lResultValues(18)%>" disabled></td>
				<td align="left" height="20"> <font class=blacktext>Phone</font></td>
				<td size="15" maxlength="10"><input type=text name="txtPhone" value="<%=lResultValues(10)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Fax</font></td>
				<td size="15" maxlength="10"><input type=text name="txtFax" value="<%=lResultValues(12)%>" disabled></td>
				<td align="left" height="20"> <font class=blacktext>Email-Id *</font></td>
				<td size="15" maxlength="10"><input type=text name="txtEmailId" value="<%=lResultValues(11)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>PAN No</font></td>
				<td size="15" maxlength="10" colspan=3><input type=text name="txtPanNo" value="<%=lResultValues(28)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan="4"> <font class=blackboldtext>Contact Address</font></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Contact Address1 *</font></td>
				<td size="15" maxlength="10"><input type=text name="txtCAdd1" value="<%=lResultValues(13)%>" disabled></td>
				<td align="left" height="20"> <font class=blacktext>Contact Address2 </font></td>
				<td size="15" maxlength="10"><input type=text name="txtCAdd2" value="<%=lResultValues(14)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Contact Address3 </font></td>
				<td size="15" maxlength="10" colspan="3"><input type=text name="txtCAdd3" value="<%=lResultValues(15)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan="4"> <font class=blackboldtext>Owner Details</font></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Contact Person Name * </font></td>
				<td size="15" maxlength="10"><input type=text name="txtCPName" value="<%=lResultValues(19)%>" disabled></td>
				<td align="left" height="20"> <font class=blacktext>Sales Tax No </font></td>
				<td size="15" maxlength="10"><input type=text name="txtSTNo" value="<%=lResultValues(20)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>CST No </font></td>
				<td size="15" maxlength="10" colspan="3"><input type=text name="txtCSTNo" value="<%=lResultValues(21)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan="4"> <font class=blackboldtext>Fee Details</font></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Reg. Fee * </font></td>
				<td size="15" maxlength="10"><input type=text name="txtRegFee" value="<%=lResultValues(24)%>" disabled></td>
				<td align="left" height="20"> <font class=blacktext>Equity Fee * </font></td>
				<td size="15" maxlength="10"><input type=text name="txtEFee" value="<%=lResultValues(25)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Deposit *</font></td>
				<td size="15" maxlength="10" colspan=3><input type=text name="txtDeposit" value="<%=lResultValues(26)%>" disabled></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan=4> <font class=blackboldtext>Period</font></td>
			</tr>
			<%lSMonth	= mid(trim(lResultValues(22)),6,2)
			lSDate	= mid(trim(lResultValues(22)),9,2)
			lSYear	= left(trim(lResultValues(22)),4)
			if left(lSMonth,1)="0" then
					lSMonth	= mid(lSMonth,2,1)
			end if
			lSDate	= mid(trim(lResultValues(8)),9,2)
			if left(lSDate,1)="0" then
				lSDate	= mid(lSDate,2,1)
			end if
			%>
			<tr class=tdbglight>
				<td align="left" height="20" > <font class=blacktext>Start Date</font></td>
				<td  class=tdbglight height="20" width="25%"> 
				<select size="1" name="optSMonth" disabled>
					<option  value="1" <%if lSMonth=1 then Response.Write "selected"%>>January</option>
					<option value="2" <%if lSMonth=2 then Response.Write "selected"%>>February</option>
					<option value="3" <%if lSMonth=3 then Response.Write "selected"%>>March</option>
					<option value="4" <%if lSMonth=4 then Response.Write "selected"%>>April</option>
					<option value="5" <%if lSMonth=5 then Response.Write "selected"%>>May</option>
					<option value="6" <%if lSMonth=6 then Response.Write "selected"%>>June</option>
					<option value="7" <%if lSMonth=7 then Response.Write "selected"%>>July</option>
					<option value="8" <%if lSMonth=8 then Response.Write "selected"%>>August</option>
					<option value="9" <%if lSMonth=9 then Response.Write "selected"%>>September</option>
					<option value="10" <%if lSMonth=10 then Response.Write "selected"%>>October</option>
					<option value="11" <%if lSMonth=11 then Response.Write "selected"%>>November</option>
					<option value="12" <%if lSMonth=12 then Response.Write "selected"%>>December</option>
				</select> 
				<select size="1" name="optSDate" disabled>
					<option  value="1" <%if lSDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lSDate=2 then Response.Write "selected"%>>2</option>
					<option value="3" <%if lSDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lSDate=4 then Response.Write "selected"%>>4</option>
					<option value="5" <%if lSDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lSDate=6 then Response.Write "selected"%>>6</option>
					<option value="7" <%if lSDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lSDate=8 then Response.Write "selected"%>>8</option>
					<option value="9" <%if lSDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lSDate=10 then Response.Write "selected"%>>10</option>
					<option value="11" <%if lSDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lSDate=12 then Response.Write "selected"%>>12</option>
					<option value="13" <%if lSDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lSDate=14 then Response.Write "selected"%>>14</option>
					<option value="15" <%if lSDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lSDate=16 then Response.Write "selected"%>>16</option>
					<option value="17" <%if lSDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lSDate=18 then Response.Write "selected"%>>18</option>
					<option value="19" <%if lSDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lSDate=20 then Response.Write "selected"%>>20</option>
					<option value="21" <%if lSDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lSDate=22 then Response.Write "selected"%>>22</option>
					<option value="23" <%if lSDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lSDate=24 then Response.Write "selected"%>>24</option>
					<option value="25" <%if lSDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lSDate=26 then Response.Write "selected"%>>26</option>
					<option value="27" <%if lSDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lSDate=28 then Response.Write "selected"%>>28</option>
					<option value="29" <%if lSDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lSDate=30 then Response.Write "selected"%>>30</option>
					<option value="31" <%if lSDate=31 then Response.Write "selected"%>>31</option>
				</select>&nbsp;
				<select name="optSYear"  size="1" disabled>
					<option value="<%=lSYear%>" selected ><%=lSYear%></option>
					<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
					<option value="<%=lYear%>" ><%=lYear%></option>
				</select>
				</td>
				<%lEMonth	= mid(trim(lResultValues(23)),6,2)
				lEDate	= mid(trim(lResultValues(23)),9,2)
				lEYear	= left(trim(lResultValues(23)),4)
				if left(lEMonth,1)="0" then
					lEMonth	= mid(lEMonth,2,1)
				end if
				lEDate	= mid(trim(lResultValues(8)),9,2)
				if left(lEDate,1)="0" then
					lEDate	= mid(lEDate,2,1)
				end if
				%>	
				<td align="left" height="20" > <font class=blacktext>End Date</font></td>
				<td  class=tdbglight height="20" width="25%"> 
				<select size="1" name="optEMonth" disabled>
					<option  value="1" <%if lEMonth=1 then Response.Write "selected"%>>January</option>
					<option value="2" <%if lEMonth=2 then Response.Write "selected"%>>February</option>
					<option value="3" <%if lEMonth=3 then Response.Write "selected"%>>March</option>
					<option value="4" <%if lEMonth=4 then Response.Write "selected"%>>April</option>
					<option value="5" <%if lEMonth=5 then Response.Write "selected"%>>May</option>
					<option value="6" <%if lEMonth=6 then Response.Write "selected"%>>June</option>
					<option value="7" <%if lEMonth=7 then Response.Write "selected"%>>July</option>
					<option value="8" <%if lEMonth=8 then Response.Write "selected"%>>August</option>
					<option value="9" <%if lEMonth=9 then Response.Write "selected"%>>September</option>
					<option value="10" <%if lEMonth=10 then Response.Write "selected"%>>October</option>
					<option value="11" <%if lEMonth=11 then Response.Write "selected"%>>November</option>
					<option value="12" <%if lEMonth=12 then Response.Write "selected"%>>December</option>
				</select> 
				<select size="1" name="optEDate" disabled>
					<option  value="1" <%if lEDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lEDate=2 then Response.Write "selected"%>>2</option>
					<option value="3" <%if lEDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lEDate=4 then Response.Write "selected"%>>4</option>
					<option value="5" <%if lEDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lEDate=6 then Response.Write "selected"%>>6</option>
					<option value="7" <%if lEDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lEDate=8 then Response.Write "selected"%>>8</option>
					<option value="9" <%if lEDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lEDate=10 then Response.Write "selected"%>>10</option>
					<option value="11" <%if lEDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lEDate=12 then Response.Write "selected"%>>12</option>
					<option value="13" <%if lEDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lEDate=14 then Response.Write "selected"%>>14</option>
					<option value="15" <%if lEDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lEDate=16 then Response.Write "selected"%>>16</option>
					<option value="17" <%if lEDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lEDate=18 then Response.Write "selected"%>>18</option>
					<option value="19" <%if lEDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lEDate=20 then Response.Write "selected"%>>20</option>
					<option value="21" <%if lEDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lEDate=22 then Response.Write "selected"%>>22</option>
					<option value="23" <%if lEDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lEDate=24 then Response.Write "selected"%>>24</option>
					<option value="25" <%if lEDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lEDate=26 then Response.Write "selected"%>>26</option>
					<option value="27" <%if lEDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lEDate=28 then Response.Write "selected"%>>28</option>
					<option value="29" <%if lEDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lEDate=30 then Response.Write "selected"%>>30</option>
					<option value="31" <%if lEDate=31 then Response.Write "selected"%>>31</option>
				</select>&nbsp;
				<select name="optEYear"  size="1" disabled>
					<option value="<%=lEYear%>" selected ><%=lEYear%></option>
					<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
					<option value="<%=lYear%>" ><%=lYear%></option>
				</select>
				</td>
			</tr>
			<input type=hidden name="hidActionValue">
			<tr class=tdbglight>
				<td align="center" height="20" colspan=4><font class=blacktext>&nbsp;</font></td>
			</tr>
		</table><br><br>
		</form>
		<br><br><!---#include file="../includes/footer.inc"--->
		</body>
		</html>
		<%end if
	end if
	
	if lActionValue = "A" then
	
		lResult  = lObjUserCompDet.UserAdd(lActionValue,lExchCode,lUserType, lCoyCode, _
				   lAppNo,lFName,lMName,lLName,lDOB,lGender,lPhone,lEmailId,lFax,lCAdd1, _
				   lCAdd2,lCAdd3,lPAdd1,lPAdd2,lPAdd3,lCPName,lSTNo,lCSTNo,lStartDate, _
				   lEndDate,lRegFee,lEFee,lDeposit,10000,lPanNo,lUserId,poUserId)
        %>
        <html>
		<head>
		<title>Bombay Commodity Exchange Limited</title>
		<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		</head>
		<!---#include file="../includes/header.inc"--->
		<br><!--#include file="../Includes/MACLinks.inc" ----><br>
		<body>
		<table border="1" cellspacing="1" cellpadding="1" width="50%" align="center">
			<tr class=tdbgdark width="100%">
				<td align="left" height="25" colspan="2"> <font class=whiteboldtext1>User Company Details</font></td>
			</tr>
			<tr class=tdbglight width="100%">
				<td align="left" height="20" width="25%"> <font class=blacktext>User ID </font></td>
				<td size="15" maxlength="10" width="25%"><font class=blacktext>
				<%if trim(lResult) = 0 then 
					Response.Write trim(poUserId)
				else
					Response.Write "Please try after some time"
				end if%>
				</font></td>
			</tr>
		</table>
		<br><br><!---#include file="../includes/footer.inc"--->
		</body>
		</html>
	<%end if

	if lActionValue = "U" then 
		
'		lResult	= lObjUserCompDet.UserView(lActionValue,lUserId,"MNA0003000",poResult)
		lResult	= lObjUserCompDet.UserView(lActionValue,lUserId,"MNA0003000",poResult)
		Response.Write "Result = " & poResult & "<br>"
		lResultValues	= split(poResult,"|")
'		Response.Write "Values = "& poResult  & "<br>"
'		lResultValues = poResult
		
		if lResult <> 0 then
			Response.Write "Error = " & lResult
			select case(lResult)
				case	"100"	:	Response.Write "End of File"
				case	"-100"	:	Response.Write "Minus End of File"
				case	"1000"	:	Response.Write "Invalid User Id"
				case	"2600"	:	Response.Write "Invalid Exchange"
				case	"3000"	:	Response.Write "Invalid Company Id"
				case	"1200"	:	Response.Write "Wrong Choice"
				case	"1600"	:	Response.Write "Invalid User Type"			
				case	"1800"	:	Response.Write "Client MAchine date is not current date"
				case	"8227"	:	Response.Write "Primary key violation"
				case	"-8227"	:	Response.Write "Minus Primary key violation"
			end select
		else%>
		<html>
		<head>
		<title>Bombay Commodity Exchange Limited</title>
		<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		</head>
		<!---#include file="../includes/header.inc"--->
		<br><!--#include file="../Includes/MACLinks.inc" ----><br>
		<body>
		<form name="frmUserCompanyDetails" action="UsrCompUpd.asp" method=post>
		<table border="1" cellspacing="1" cellpadding="1" width="90%" align="center">
			<tr class=tdbgdark width="100%">
				<td align="left" height="25" colspan="4"> <font class=whiteboldtext1>User Company Details</font></td>
			</tr>
			<tr class=tdbglight width="100%">
				<td align="left" height="20" width="15%"> <font class=blacktext>User ID </font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optUserId" style="height: 22px; width: 199px">
						<option selected value="<%=lResultValues(1)%>"><%=lResultValues(1)%></option>
					</select>
				<td align="left" height="20" width="15%"> <font class=blacktext>User Type *</font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optUserType" style="height: 22px; width: 199px">
						<option value="<%=lResultValues(2)%>" selected><%=lResultValues(2)%></option>
					</select>
			</tr>
			<tr class=tdbglight width="100%">
				<td align="left" height="20" width="15%"> <font class=blacktext>Company Code </font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optCoyCode" style="height: 22px; width: 199px">
						<option value="<%=lResultValues(3)%>" selected><%=lResultValues(3)%></option>
					</select>
				<td align="left" height="20" width="15%"> <font class=blacktext>Exchange Code *</font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optExchCode" style="height: 22px; width: 199px">
						<option value="<%=lResultValues(0)%>" selected><%=lResultValues(0)%></option>
					</select>
			</tr>
			<tr class=tdbglight width="100%">
				<td align="left" height="20" width="15%"> <font class=blacktext>App. NO </font></td>
				<td size="15" maxlength="10" width="25%"><input type=text name="txtAppNo" value="<%=lResultValues(4)%>" style="height: 22px; width: 199px"></td>
				<td align="left" height="20" width="15%"> <font class=blacktext>First Name </font></td>
				<td size="15" maxlength="10" width="25%"><input type=text name="txtFName" value="<%=lResultValues(5)%>" style="height: 22px; width: 199px"></td>
			</tr>
			<tr class=tdbglight width="100%">
				<td align="left" height="20" width="15%"> <font class=blacktext>Middle Name </font></td>
				<td size="15" maxlength="10" width="25%"><input type=text name="txtMName" value="<%=lResultValues(6)%>" style="height: 22px; width: 199px"></td>
				<td align="left" height="20" width="15%"> <font class=blacktext>Last Name *</font></td>
				<td size="15" maxlength="10" width="25%"><input type=text name="txtLName" value="<%=lResultValues(7)%>" style="height: 22px; width: 199px" ></td>
			</tr>
			<tr class=tdbglight width="50%">
				<td align="left" height="20" width="15%"> <font class=blacktext>Gender *</font></td>
				<td size="15" maxlength="10" width="25%">
					<select name="optGender" style="height: 22px; width: 199px">
						<option selected value="<%=lResultValues(9)%>" ><%=lResultValues(9)%></option>
				</select>
				<%lDMonth	= mid(trim(lResultValues(8)),6,2)
				if left(lDMonth,1)="0" then
					lDMonth	= mid(lDMonth,2,1)
				end if
				lDDate	= mid(trim(lResultValues(8)),9,2)
				if left(lDDate,1)="0" then
					lDDate	= mid(lDDate,2,1)
				end if
				lDYear	= left(trim(lResultValues(8)),4)
				%>
				<td class=tdbglight width="15%" height="20"><font class=blacktext>Date of Birth *</font></td>
				<td  class=tdbglight height="20" width="25%"> 
				<select size="1" name="optMonth">
					<option  value="1" <%if lDMonth=1 then Response.Write "selected"%>>January</option>
					<option value="2" <%if lDMonth=2 then Response.Write "selected"%>>February</option>
					<option value="3" <%if lDMonth=3 then Response.Write "selected"%>>March</option>
					<option value="4" <%if lDMonth=4 then Response.Write "selected"%>>April</option>
					<option value="5" <%if lDMonth=5 then Response.Write "selected"%>>May</option>
					<option value="6" <%if lDMonth=6 then Response.Write "selected"%>>June</option>
					<option value="7" <%if lDMonth=7 then Response.Write "selected"%>>July</option>
					<option value="8" <%if lDMonth=8 then Response.Write "selected"%>>August</option>
					<option value="9" <%if lDMonth=9 then Response.Write "selected"%>>September</option>
					<option value="10" <%if lDMonth=10 then Response.Write "selected"%>>October</option>
					<option value="11" <%if lDMonth=11 then Response.Write "selected"%>>November</option>
					<option value="12" <%if lDMonth=12 then Response.Write "selected"%>>December</option>
				</select> 
				<select size="1" name="optDate">
					<option  value="1" <%if lDDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lDDate=2 then Response.Write "selected"%>>2</option>
					<option value="3" <%if lDDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lDDate=4 then Response.Write "selected"%>>4</option>
					<option value="5" <%if lDDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lDDate=6 then Response.Write "selected"%>>6</option>
					<option value="7" <%if lDDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lDDate=8 then Response.Write "selected"%>>8</option>
					<option value="9" <%if lDDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lDDate=10 then Response.Write "selected"%>>10</option>
					<option value="11" <%if lDDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lDDate=12 then Response.Write "selected"%>>12</option>
					<option value="13" <%if lDDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lDDate=14 then Response.Write "selected"%>>14</option>
					<option value="15" <%if lDDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lDDate=16 then Response.Write "selected"%>>16</option>
					<option value="17" <%if lDDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lDDate=18 then Response.Write "selected"%>>18</option>
					<option value="19" <%if lDDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lDDate=20 then Response.Write "selected"%>>20</option>
					<option value="21" <%if lDDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lDDate=22 then Response.Write "selected"%>>22</option>
					<option value="23" <%if lDDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lDDate=24 then Response.Write "selected"%>>24</option>
					<option value="25" <%if lDDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lDDate=26 then Response.Write "selected"%>>26</option>
					<option value="27" <%if lDDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lDDate=28 then Response.Write "selected"%>>28</option>
					<option value="29" <%if lDDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lDDate=30 then Response.Write "selected"%>>30</option>
					<option value="31" <%if lDDate=31 then Response.Write "selected"%>>31</option>
				</select>&nbsp;
				<select name="optYear"  size="1">
					<option value="<%=lDYear%>" selected ><%=lDYear%></option>
					<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
					<option value="<%=lYear%>" ><%=lYear%></option>
				</select>
				</td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan="4"> <font class=blackboldtext>Permanent Address</font></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Per.Address1 * </font></td>
				<td size="15" maxlength="10"><input type=text name="txtPAdd1" value="<%=lResultValues(16)%>">	</td>
				<td align="left" height="20"> <font class=blacktext>Per.Address2 </font></td>
				<td size="15" maxlength="10"><input type=text name="txtPAdd2" value="<%=lResultValues(17)%>"></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Per.Address3 </font></td>
				<td size="15" maxlength="10"><input type=text name="txtPAdd3" value="<%=lResultValues(18)%>"></td>
				<td align="left" height="20"> <font class=blacktext>Phone</font></td>
				<td size="15" maxlength="10"><input type=text name="txtPhone" value="<%=lResultValues(10)%>"></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Fax</font></td>
				<td size="15" maxlength="10"><input type=text name="txtFax" value="<%=lResultValues(12)%>"></td>
				<td align="left" height="20"> <font class=blacktext>Email-Id *</font></td>
				<td size="15" maxlength="10"><input type=text name="txtEmailId" value="<%=lResultValues(11)%>"></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>PAN No</font></td>
				<td size="15" maxlength="10" colspan=3><input type=text name="txtPanNo" value="<%=lResultValues(28)%>"></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan="4"> <font class=blackboldtext>Contact Address</font></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Contact Address1 *</font></td>
				<td size="15" maxlength="10"><input type=text name="txtCAdd1" value="<%=lResultValues(13)%>"></td>
				<td align="left" height="20"> <font class=blacktext>Contact Address2 </font></td>
				<td size="15" maxlength="10"><input type=text name="txtCAdd2" value="<%=lResultValues(14)%>" ></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Contact Address3 </font></td>
				<td size="15" maxlength="10" colspan="3"><input type=text name="txtCAdd3" value="<%=lResultValues(15)%>"></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan="4"> <font class=blackboldtext>Owner Details</font></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Contact Person Name * </font></td>
				<td size="15" maxlength="10"><input type=text name="txtCPName" value="<%=lResultValues(19)%>"></td>
				<td align="left" height="20"> <font class=blacktext>Sales Tax No </font></td>
				<td size="15" maxlength="10"><input type=text name="txtSTNo" value="<%=lResultValues(20)%>"></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>CST No </font></td>
				<td size="15" maxlength="10" colspan="3"><input type=text name="txtCSTNo" value="<%=lResultValues(21)%>" ></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan="4"> <font class=blackboldtext>Fee Details</font></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Reg. Fee * </font></td>
				<td size="15" maxlength="10"><input type=text name="txtRegFee" value="<%=lResultValues(24)%>"></td>
				<td align="left" height="20"> <font class=blacktext>Equity Fee * </font></td>
				<td size="15" maxlength="10"><input type=text name="txtEFee" value="<%=lResultValues(25)%>"></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20"> <font class=blacktext>Deposit *</font></td>
				<td size="15" maxlength="10" colspan=3><input type=text name="txtDeposit" value="<%=lResultValues(26)%>"></td>
			</tr>
			<tr class=tdbglight>
				<td align="left" height="20" colspan=4> <font class=blackboldtext>Period</font></td>
			</tr>
			<%lSMonth	= mid(trim(lResultValues(22)),6,2)
			lSDate	= mid(trim(lResultValues(22)),9,2)
			lSYear	= left(trim(lResultValues(22)),4)
			if left(lSMonth,1)="0" then
					lSMonth	= mid(lSMonth,2,1)
			end if
			lSDate	= mid(trim(lResultValues(8)),9,2)
			if left(lSDate,1)="0" then
				lSDate	= mid(lSDate,2,1)
			end if
			%>
			<tr class=tdbglight>
				<td align="left" height="20" > <font class=blacktext>Start Date</font></td>
				<td  class=tdbglight height="20" width="25%"> 
				<select size="1" name="optSMonth">
					<option  value="1" <%if lSMonth=1 then Response.Write "selected"%>>January</option>
					<option value="2" <%if lSMonth=2 then Response.Write "selected"%>>February</option>
					<option value="3" <%if lSMonth=3 then Response.Write "selected"%>>March</option>
					<option value="4" <%if lSMonth=4 then Response.Write "selected"%>>April</option>
					<option value="5" <%if lSMonth=5 then Response.Write "selected"%>>May</option>
					<option value="6" <%if lSMonth=6 then Response.Write "selected"%>>June</option>
					<option value="7" <%if lSMonth=7 then Response.Write "selected"%>>July</option>
					<option value="8" <%if lSMonth=8 then Response.Write "selected"%>>August</option>
					<option value="9" <%if lSMonth=9 then Response.Write "selected"%>>September</option>
					<option value="10" <%if lSMonth=10 then Response.Write "selected"%>>October</option>
					<option value="11" <%if lSMonth=11 then Response.Write "selected"%>>November</option>
					<option value="12" <%if lSMonth=12 then Response.Write "selected"%>>December</option>
				</select> 
				<select size="1" name="optSDate">
					<option  value="1" <%if lSDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lSDate=2 then Response.Write "selected"%>>2</option>
					<option value="3" <%if lSDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lSDate=4 then Response.Write "selected"%>>4</option>
					<option value="5" <%if lSDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lSDate=6 then Response.Write "selected"%>>6</option>
					<option value="7" <%if lSDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lSDate=8 then Response.Write "selected"%>>8</option>
					<option value="9" <%if lSDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lSDate=10 then Response.Write "selected"%>>10</option>
					<option value="11" <%if lSDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lSDate=12 then Response.Write "selected"%>>12</option>
					<option value="13" <%if lSDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lSDate=14 then Response.Write "selected"%>>14</option>
					<option value="15" <%if lSDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lSDate=16 then Response.Write "selected"%>>16</option>
					<option value="17" <%if lSDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lSDate=18 then Response.Write "selected"%>>18</option>
					<option value="19" <%if lSDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lSDate=20 then Response.Write "selected"%>>20</option>
					<option value="21" <%if lSDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lSDate=22 then Response.Write "selected"%>>22</option>
					<option value="23" <%if lSDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lSDate=24 then Response.Write "selected"%>>24</option>
					<option value="25" <%if lSDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lSDate=26 then Response.Write "selected"%>>26</option>
					<option value="27" <%if lSDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lSDate=28 then Response.Write "selected"%>>28</option>
					<option value="29" <%if lSDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lSDate=30 then Response.Write "selected"%>>30</option>
					<option value="31" <%if lSDate=31 then Response.Write "selected"%>>31</option>
				</select>&nbsp;
				<select name="optSYear"  size="1" >
					<option value="<%=lSYear%>" selected ><%=lSYear%></option>
					<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
					<option value="<%=lYear%>" ><%=lYear%></option>
				</select>
				</td>
				<%lEMonth	= mid(trim(lResultValues(23)),6,2)
				lEDate	= mid(trim(lResultValues(23)),9,2)
				lEYear	= left(trim(lResultValues(23)),4)
			
				if left(lEMonth,1)="0" then
					lEMonth	= mid(lEMonth,2,1)
				end if
				lEDate	= mid(trim(lResultValues(8)),9,2)
				if left(lEDate,1)="0" then
					lEDate	= mid(lEDate,2,1)
				end if
				%>	
				<td align="left" height="20" > <font class=blacktext>End Date</font></td>
				<td  class=tdbglight height="20" width="25%"> 
				<select size="1" name="optEMonth">
					<option  value="1" <%if lEMonth=1 then Response.Write "selected"%>>January</option>
					<option value="2" <%if lEMonth=2 then Response.Write "selected"%>>February</option>
					<option value="3" <%if lEMonth=3 then Response.Write "selected"%>>March</option>
					<option value="4" <%if lEMonth=4 then Response.Write "selected"%>>April</option>
					<option value="5" <%if lEMonth=5 then Response.Write "selected"%>>May</option>
					<option value="6" <%if lEMonth=6 then Response.Write "selected"%>>June</option>
					<option value="7" <%if lEMonth=7 then Response.Write "selected"%>>July</option>
					<option value="8" <%if lEMonth=8 then Response.Write "selected"%>>August</option>
					<option value="9" <%if lEMonth=9 then Response.Write "selected"%>>September</option>
					<option value="10" <%if lEMonth=10 then Response.Write "selected"%>>October</option>
					<option value="11" <%if lEMonth=11 then Response.Write "selected"%>>November</option>
					<option value="12" <%if lEMonth=12 then Response.Write "selected"%>>December</option>
				</select> 
				<select size="1" name="optEDate">
					<option  value="1" <%if lEDate=1 then Response.Write "selected"%>>1</option> <option value="2" <%if lEDate=2 then Response.Write "selected"%>>2</option>
					<option value="3" <%if lEDate=3 then Response.Write "selected"%>>3</option> <option value="4" <%if lEDate=4 then Response.Write "selected"%>>4</option>
					<option value="5" <%if lEDate=5 then Response.Write "selected"%>>5</option> <option value="6" <%if lEDate=6 then Response.Write "selected"%>>6</option>
					<option value="7" <%if lEDate=7 then Response.Write "selected"%>>7</option> <option value="8" <%if lEDate=8 then Response.Write "selected"%>>8</option>
					<option value="9" <%if lEDate=9 then Response.Write "selected"%>>9</option> <option value="10" <%if lEDate=10 then Response.Write "selected"%>>10</option>
					<option value="11" <%if lEDate=11 then Response.Write "selected"%>>11</option> <option value="12" <%if lEDate=12 then Response.Write "selected"%>>12</option>
					<option value="13" <%if lEDate=13 then Response.Write "selected"%>>13</option> <option value="14" <%if lEDate=14 then Response.Write "selected"%>>14</option>
					<option value="15" <%if lEDate=15 then Response.Write "selected"%>>15</option> <option value="16" <%if lEDate=16 then Response.Write "selected"%>>16</option>
					<option value="17" <%if lEDate=17 then Response.Write "selected"%>>17</option> <option value="18" <%if lEDate=18 then Response.Write "selected"%>>18</option>
					<option value="19" <%if lEDate=19 then Response.Write "selected"%>>19</option> <option value="20" <%if lEDate=20 then Response.Write "selected"%>>20</option>
					<option value="21" <%if lEDate=21 then Response.Write "selected"%>>21</option> <option value="22" <%if lEDate=22 then Response.Write "selected"%>>22</option>
					<option value="23" <%if lEDate=23 then Response.Write "selected"%>>23</option> <option value="24" <%if lEDate=24 then Response.Write "selected"%>>24</option>
					<option value="25" <%if lEDate=25 then Response.Write "selected"%>>25</option> <option value="26" <%if lEDate=26 then Response.Write "selected"%>>26</option>
					<option value="27" <%if lEDate=27 then Response.Write "selected"%>>27</option> <option value="28" <%if lEDate=28 then Response.Write "selected"%>>28</option>
					<option value="29" <%if lEDate=29 then Response.Write "selected"%>>29</option> <option value="30" <%if lEDate=30 then Response.Write "selected"%>>30</option>
					<option value="31" <%if lEDate=31 then Response.Write "selected"%>>31</option>
				</select>&nbsp;
				<select name="optEYear"  size="1" >
					<option value="<%=lEYear%>" selected ><%=lEYear%></option>
					<option value="<%=lYearPrev%>" ><%=lYearPrev%></option>
					<option value="<%=lYear%>" ><%=lYear%></option>
				</select>
				</td>
			</tr>
			<input type=hidden name="hidActionValue" value="<%=lActionValue%>">
			<tr class=tdbglight>
				<td align="center" height="20" colspan=4>
				<input type=submit name="btnEdit" value="Edit" >
				</td>
			</tr>
		</table><br><br>
		</form>
		<br><br><!---#include file="../includes/footer.inc"--->
		</body>
		</html>
		<%end if
	end if%>	