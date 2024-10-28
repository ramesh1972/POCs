<%@ Language=VBScript %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	MAC													  *
	'* File name	:	PwdMaintRes.asp							      *
	'* Purpose		:	This is used for Password Maintenance.		  		  *
	'* Prepared by	:	V.Christopher Britto								  *
	'* Date			:	27/11/2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* General Notes														  *
	'* This is used for Password Maintenance.								  *
	'* Client Side	:	Javascript											  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	      *
	'*	1		   27/11/2001		V.Christopher Britto  First Baseline	  *
	'*																		  *
	'**************************************************************************		
	option explicit
	
	dim lExchgcode
	dim lUserype
	dim lUserId
	dim lCompanyId
	dim lPwd
	dim lStartMonth
	dim lStartDate
	dim lStartYear
	dim lEndMonth
	dim lEndDate
	dim lEndYear
	dim lAccessType
	dim lObjPwdMain
	dim lResult
	dim lResultVaules
	dim lActionValue
	dim lStartDay
	dim lEndDay
	dim llStartMonth
	dim llEndMonth
	dim lpoResult
	
	
	lExchgcode	= trim(Request.Form("optExchgcode"))
	lUserype	= trim(Request.Form("optUserype"))
	lUserId		= trim(Request.Form("optUserId"))
	lCompanyId	= trim(Request.Form("optCompanyId"))
	lPwd		= trim(Request.Form("txtPwd"))
	lStartMonth	= trim(Request.Form("StartMonth"))
	lStartDate	= trim(Request.Form("StartDate"))
	lStartYear	= trim(Request.Form("StartYear"))
	lEndMonth	= trim(Request.Form("EndMonth"))
	lEndDate	= trim(Request.Form("EndDate"))
	lEndYear	= trim(Request.Form("EndYear"))
	lAccessType	= trim(Request.Form("optAccessType"))
	lActionValue = trim(Request.Form("hidActionValue"))	
	Response.Write "Action Value = " & lActionValue
	if len(lStartMonth) <=1 then
		lStartMonth	=	"0" & lStartMonth
	end if
	if len(lStartDate) <=1 then
		lStartDate	=	"0" & lStartDate
	end if
	if len(lEndMonth) <=1 then
		lEndMonth	=	"0" & lEndMonth
	end if
	if len(lEndDate) <=1 then
		lEndDate	=	"0" & lEndDate
	end if
	lStartDay	= lStartYear & "-" & lStartMonth & "-" & lStartDate
	lEndDay		= lEndYear & "-" & lEndMonth & "-" & lEndDate	
	
	if lActionValue=1 then
		set lObjPwdMain = server.CreateObject("Mac.LogonPasswordMaintenanceMgr")
		lResult = lObjPwdMain.LogonPasswordAdd(lExchgcode,lUserype,lUserId,lCompanyId, _
						lPwd,"","",cstr(trim(lStartDay)),cstr(trim(lEndDay)),lAccessType,"MNA0003000")

'		Response.Write "Result = " & lResult
		%>
		<html>
		<head>
		<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
		<title>Welcome to the Bombay Commodity Exchange Limited</title>
		</head> 
		<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
		<!---#include file="../Includes/header.inc"---><br>
		<!--#include file="../Includes/MACLinks.inc" ----><br>
		<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
			<tr class="tdbgdark"> 
				<td valign=center width="50%"  height="27"><font class="whiteboldtext1"> Logon & Password  </font></td>
			</tr>
			<tr class="tdbglight"> 
		        <td height="27" align=left  width="50%"> <font align="left" class="blacktext">
		<%select case(trim(lResult))
			case 0	: %> Logon & Password information has been added successfully</font></td>
			<%case 1000	: %> User Id is not available</font></td>
			<%case 1400	: %> User Id is already available</font></td>
			<%case 3000	: %> Company Id is not available</font></td>
			<%case 1500	: %> Password is wrong</font></td>
			<%case 1600	: %> This User Type is not available</font></td>
			<%case 2600	: %> Exchange Code is not available</font></td>
		<%end select %>
		</tr>
		<tr class="tdbglight"> 
		    <td height="27" align=left  width="50%"> <font align="left" class="blacktext">
						Click<a href="../User/PwdMaint.asp"> here </a> to see the previous screen.</td>
		</tr>
		</table>	
		<br><br><!---#include file="../includes/footer.inc"--->
		</body>
		</html>
	<%end if%>
	<%if lActionValue=2 then

		lExchgcode	= trim(Request.Form("optExchgcode"))
		lUserype	= trim(Request.Form("optUserype"))
		lUserId		= trim(Request.Form("optUserId"))
		lCompanyId	= trim(Request.Form("optCompanyId"))
		lAccessType	= trim(Request.Form("optAccessType"))	
		lActionValue = trim(Request.Form("hidActionValue"))	
											
		set lObjPwdMain = server.CreateObject("Mac.LogonPasswordMaintenanceMgr")		
		lResult = lObjPwdMain.LogonPasswordView(lExchgcode,lUserId,lCompanyId, _
								lUserype,lUserId,lpoResult)
		
		lResultVaules = split(cstr(trim(lpoResult)),"|")
		
		if trim(lResult) = 0 then%>
			<html>
			<head>
			<link rel=StyleSheet href="../Includes/theme.css" title="Contemporary">
				<title>Welcome to the Bombay Commodity Exchange Limited</title>
			</head>
			<body  marginheight="0" marginwidth="0" topmargin='0' leftmargin='0' class=bodycolor>
			<!---#include file="../Includes/header.inc"---><br>
			<!--#include file="../Includes/MACLinks.inc" ----><br>
			<form name="frmLogPwdMaint" method="post"  action="PwdMaintUpd.asp">
			<table width="50%" border="1"  cellpadding=1 cellspacing=1 align="center">
				<tr class="tdbgdark"> 
					<td valign=center width="50%" colspan=2 height="27"><font class="whiteboldtext1"> Logon and Password Details </font></td>
				</tr>
			    <tr class="tdbglight"> 
					<td height="27" align=left  width="20%"> 
						<font align="left" class="blacktext">Exchange ID</font>
			        </td>
			        <td  align="left" height="16"  width="30%">
						<select name="optExchgcode" style="height: 22px; width: 199px" disabled>
							<option value="<%=trim(lResultVaules(0))%>"><%=trim(lResultVaules(0))%></option>
						</select> 
			        </td>
				</tr>
				<tr class="tdbglight"> 
			        <td height="27" align=left  width="20%"> 
						<font align="left" class="blacktext">User Type</font>
			        </td>
			        <td  align="left" height="16"  width="30%" class="tdbglight">
						<select name="optUserType" style="HEIGHT: 22px; WIDTH: 199px" disabled >
							<option value="<%=trim(lResultVaules(2))%>"><%=trim(lResultVaules(2))%></option>
						</select> 
			        </td>
				</tr>
				<tr class="tdbglight"> 
					<td height="27" align=left  width="20%"> 
						<font align="left" class="blacktext">User ID</font>
			        </td>
			        <td  align="left" height="16"  width="30%" class="tdbglight">
						<select name="optUserId" style="HEIGHT: 22px; WIDTH: 199px" disabled>
							<option value="<%=trim(lResultVaules(1))%>"><%=trim(lResultVaules(1))%></option>
						</select> 
			        </td>
				</tr>
			    <tr class="tdbglight"> 
			        <td height="27" align=left  width="20%"> 
						<font align="left" class="blacktext">Company ID</font>
			        </td>
			        <td  align="left" height="16"  width="30%" class="tdbglight">
						<select name="optCompanyId" style="HEIGHT: 22px; WIDTH: 199px" disabled>
							<option value="<%=trim(lResultVaules(3))%>"><%=trim(lResultVaules(3))%></option>		     </select> 
						</select>
			        </td>
				</tr>
			    <tr class="tdbglight"> 
					<td height="27" align=left  width="20%"> 
						<font align="left" class="blacktext"> Password</font>
			        </td>
			        <td  align="left" height="16"  width="30%" class="tdbglight"> 
						<input type="password" size="26.7"  maxlength="10" value="<%=trim(lResultVaules(4))%>" name="txtPwd" disabled>
			        </td>
				</tr>
				<%llStartMonth = mid(trim(lResultVaules(7)),6,2)
				if left(llStartMonth,1)="0" then
					llStartMonth = right(llStartMonth,1)
				end if %>
				<tr><td class=tdbglight width="230" height="25" width="20%"><font class=blacktext>Password Start Date</font></td>
					<td WIDTH="367" CLASS=tdbglight height="25"> 
					<select size="1" name="StartMonth" style="height: 22px; width: 92px" disabled>
						<option  value="1" <%if llStartMonth=1 then Response.Write "selected"%>>January</option>
						<option value="2" <%if llStartMonth=2 then Response.Write "selected"%>>February</option>
						<option value="3" <%if llStartMonth=3 then Response.Write "selected"%>>March</option>
						<option value="4" <%if llStartMonth=4 then Response.Write "selected"%>>April</option>
						<option value="5" <%if llStartMonth=5 then Response.Write "selected"%>>May</option>
						<option value="6" <%if llStartMonth=6 then Response.Write "selected"%>>June</option>
						<option value="7" <%if llStartMonth=7 then Response.Write "selected"%>>July</option>
						<option value="8" <%if llStartMonth=8 then Response.Write "selected"%>>August</option>
						<option value="9" <%if llStartMonth=9 then Response.Write "selected"%>>September</option>
						<option value="10" <%if llStartMonth=10 then Response.Write "selected"%>>October</option>
						<option value="11" <%if llStartMonth=11 then Response.Write "selected"%>>November</option>
						<option value="12" <%if llStartMonth=12 then Response.Write "selected"%>>December</option>
					</select> 
					<select size="1" name="StartDate" style="HEIGHT: 22px; WIDTH: 40px" disabled>
						<option value="<%=mid(trim(lResultVaules(7)),9,2)%>" ><%=mid(trim(lResultVaules(7)),9,2)%> </option>
					</select>&nbsp;
					<select name="StartYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" disabled>
						<option value="<%=mid(trim(lResultVaules(7)),1,4)%>" ><%=mid(trim(lResultVaules(7)),1,4)%> </option>
					</select>
					</td>
				</tr>
				<%llEndMonth = mid(trim(lResultVaules(8)),6,2)
				if left(llEndMonth,1)="0" then
					llEndMonth = right(llEndMonth,1)
				end if %>
				<tr><td class=tdbglight width="230" height="25" width="20%"><font class=blacktext>PasswordEnd Date</font></td>
					<td WIDTH="367" CLASS=tdbglight height="25"> 
					<select size="1" name="EndMonth" style="HEIGHT: 22px; WIDTH: 92px" disabled>
						<option  value="1" <%if llEndMonth=1 then Response.Write "selected"%>>January</option>
						<option value="2" <%if llEndMonth=2 then Response.Write "selected"%>>February</option>
						<option value="3" <%if llEndMonth=3 then Response.Write "selected"%>>March</option>
						<option value="4" <%if llEndMonth=4 then Response.Write "selected"%>>April</option>
						<option value="5" <%if llEndMonth=5 then Response.Write "selected"%>>May</option>
						<option value="6" <%if llEndMonth=6 then Response.Write "selected"%>>June</option>
						<option value="7" <%if llEndMonth=7 then Response.Write "selected"%>>July</option>
						<option value="8" <%if llEndMonth=8 then Response.Write "selected"%>>August</option>
						<option value="9" <%if llEndMonth=9 then Response.Write "selected"%>>September</option>
						<option value="10" <%if llEndMonth=10 then Response.Write "selected"%>>October</option>
						<option value="11" <%if llEndMonth=11 then Response.Write "selected"%>>November</option>
						<option value="12" <%if llEndMonth=12 then Response.Write "selected"%>>December</option>
					</select> 
					<select size="1" name="EndDate" style="HEIGHT: 22px; WIDTH: 40px" disabled>
						<option value="<%=mid(trim(lResultVaules(8)),9,2)%>" ><%=mid(trim(lResultVaules(8)),9,2)%> </option>
					</select>&nbsp;
					<select name="EndYear"  size="1" style="HEIGHT: 22px; WIDTH: 55px" disabled>
						<option value="<%=left(trim(lResultVaules(8)),4)%>" ><%=left(trim(lResultVaules(8)),4)%> </option>
					</select>
					</td>
				</tr>
			<tr> 
				<td  height="27" align=left width="20%" class="tdbglight"> 
					<font align="left"><font class=blacktext>Type of Access</font></font>
				</td>
				<td align="left" height="27"  width="30%" class="tdbglight"> 
					<select name="optAccessType" style="HEIGHT: 22px; WIDTH: 199px" disabled >
						<option value="T" <%if trim(lResultVaules(9))= "T" then Response.Write "selected"%>>Full Control</option>
						<option value="I" <%if trim(lResultVaules(9))= "I" then Response.Write "selected"%>>Read</option>
					</select> 
				</td>
			</tr>	
			<tr class="tdbglight"> 
					<td align = "center" valign=center width="50%" colspan=2 height="27">
						<input type=submit name="sbtEdit" value="Edit">
					</td>
				</tr>
		</table>
			<input type="hidden" name="hidExchgcode" value="<%=trim(lResultVaules(0))%>">
			<input type="hidden" name="hidUserType" value="<%=trim(lResultVaules(2))%>">
			<input type="hidden" name="hidUserId" value="<%=trim(lResultVaules(1))%>">
			<input type="hidden" name="hidCompanyId" value="<%=trim(lResultVaules(3))%>">
			<input type="hidden" name="hidPwd" value="<%=trim(lResultVaules(4))%>">
			<input type="hidden" name="hidStartMonth" value="<%=mid(trim(lResultVaules(7)),6,2)%>">
			<input type="hidden" name="hidStartDate" value="<%=mid(trim(lResultVaules(7)),6,2)%>">
			<input type="hidden" name="hidStartYear" value="<%=mid(trim(lResultVaules(7)),1,4)%>">
			<input type="hidden" name="hidEndMonth" value="<%=mid(trim(lResultVaules(8)),6,2)%>">
			<input type="hidden" name="hidEndDate" value="<%=mid(trim(lResultVaules(8)),9,2)%>">
			<input type="hidden" name="hidEndYear" value="<%=left(trim(lResultVaules(8)),4)%>">
			<input type="hidden" name="hidAccessType" value="<%=trim(lResultVaules(9))%>">
	</form>
	<br><!---#include file="../includes/footer.inc"--->
	</body>
	</html>
	<%end if%>
	<%end if%>
	
