<%@language=vbscript%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<TITLE></TITLE>
<link rel="stylesheet" href="../Includes/Theme.css">
</HEAD>
<BODY>
<!--#include file="../includes/header.inc"-->
		<br>
<!--- #include file="../includes/MAClinks.inc" --->
<br>
<%	
	dim strRow
	dim strRowValue
	Dim lResult 
	Dim lFUserId
	Dim lFDate
	Dim lLUserId
	Dim lLDate
	Dim lRespStr
	Dim lRecCount
	Dim objTrdLog
	Dim strResult
	strRow=split(trim(Request.Form("rdoChoose")),",")
	strRowValue=strRow(2)
	''''''''''Response.Write strRow(0) & "<br>"
	''''''''''Response.Write strRow(1) & "<br>"
	'strRowValue="TMA"
	'''''''''''''Response.Write strRowValue & "<br>"	
	set objTrdLog=server.CreateObject("Mac.AdtLogMgr")
	'strResult = objTrdLog.AdtDetail("MDI0002000", "2001-12-11:17:20:17.613271", "MZE0006000", lRespStr)
	strResult = objTrdLog.AdtDetail(strRow(0), strRow(1), "MZE0006000", lRespStr)
	dim strRowRes
	strRowRes=split(lRespStr,"|")
	''''''''''Response.Write ubound(strRowRes) & "<br>"
	'''''''''Response.Write strResult  & " "  & lRespStr	
	if trim(strResult)="0" then
		select case trim(strRowValue)
			case "MKI":%>
				<center>
				<TABLE border="1"  cellpadding=1 cellspacing=1 width="662" >
					<TR class=tdbgdark>
						<TD colspan="4" align="center" width="652"><font class=whiteboldtext1>Market Details</font></TD>
					</TR>
					<tr class=tdbglight align=left>
						<TD width="145">Contract Code:</TD>
						<TD width="181"><input type="text" name="txtContCode" value="<%=strRowRes(0)%>" disabled size="25"></TD>
						<TD width="134">Contract Base Price:</TD>
						<TD width="174"><input type="text" name="txtContBP" value="<%=CDBL(strRowRes(1))/100 & ".00"%>" disabled size="25"></TD>
					</tr>	
					<tr class=tdbglight align=left>
						<TD width="145">Last Modified Date:</TD>
						<TD width="181"><input type="text" name="txtContLstModDt" value="<%=strRow(1)%>" disabled size="25"></TD>
						<TD width="134">Trade Start Date:</TD>
						<TD width="174"><input type="text" name="txtTrdStDt" value="<%=mid(strRowRes(8),1,10)%>" disabled size="25"></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="145">Trade End Date:</TD>
						<TD width="181"><input type="text" name="txtTrdEndDT" value="<%=mid(strRowRes(9),1,10)%>" disabled size="25"></TD>
						<TD width="134">Delivery Start Date:</TD>
						<TD width="174"><input type="text" name="txtDelStDt" value="<%=mid(strRowRes(15),1,10)%>" disabled size="25"></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="145">Delivery End Date:</TD>
						<TD width="181"><input type="text" name="txtDelEndDT" value="<%=mid(strRowRes(16),1,10)%>" disabled size="25"></TD>
						<TD width="134">Circuit Filter:</TD>
						<TD width="174"><input type="text" name="txtCirFilt"  value="<%=CDBL(strRowRes(3))/100%>" disabled size="25"></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="145">Settlement Circuit Filter:</TD>
						<TD width="181"><input type="text" name="txtSetCirFilt" value="<%=CDBL(strRowRes(4))/100%>" disabled size="25"></TD>
						<TD width="134">Tick Size:</TD>
						<TD width="174"><input type="text" name="txtTickSize" value="<%=CDBL(strRowRes(6))/100%>" disabled size="25"></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="145">Lot Size:</TD>
						<TD width="181"><input type="text" name="txtLotSize" value="<%=strRowRes(7)%>" disabled size="25"></TD>
						<TD width="134">Minimum Volume:</TD>
						<TD width="174"><input type="text" name="txtMinVol" value="<%=strRowRes(10)%>" disabled size="25"></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="145">Drip Quantiy (in %):</TD>
						<TD width="181"><input type="text" name="txtDripQty" value="<%=cdbl(strRowRes(14)/100)%>" disabled size="25"></TD>
						<TD width="134">Trade Count:</TD>
						<TD width="174"><input type="text" name="txtTrdCount" value="<%=strRowRes(12)%>" disabled size="25"></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="145">Trade Duration:</TD>
						<TD width="181"><input type="text" name="txtTrdDur" value="<%=strRowRes(5)%>" disabled size="25"></TD>
						<TD width="134">Status:</TD>
						<TD width="174"><input type="text" name="txtStatus" 
						value="<%
						if trim(strRowRes(13))="N" then
							Response.Write "ACTIVE"
						elseif trim(strRowRes(13))="H" then
							Response.Write "HALTED"
						elseif trim(strRowRes(13))="P" then
							Response.Write "SUSPENDED"
						elseif trim(strRowRes(13))="D" then
							Response.Write "SUSPENDED"
						end if
						%>" disabled 				
						size="25"></TD>
					</tr>			
				</TABLE>
				</center>
			<%case "COY":%>
				<center>
				<TABLE border="1"  cellpadding=1 cellspacing=1 width="635" >
					<TR class=tdbgdark>
						<TD colspan="4" align="center" width="629"><font class=whiteboldtext1>Company Details</font></TD>
					</TR>
					<tr class=tdbglight align=left>
						<TD width="140">Company Code:</TD>
						<TD width="148"><input type="text" name="txtCoyCode" size="25" value="<%=strRowRes(1)%>" disabled></TD>
						<TD width="137">Company Type:</TD>
						<TD width="186"><input type="text" name="txtCoyType" size="25"
						value=
						<%
						IF TRIM(strRowRes(4))="M" THEN
							Response.Write "MAC"
						elseif TRIM(strRowRes(4))="I" THEN
							Response.Write "ICM"
						elseif TRIM(strRowRes(4))="T" THEN
							Response.Write "TCM"
						elseif TRIM(strRowRes(4))="C" THEN
							Response.Write "Client"
						elseif TRIM(strRowRes(4))="J" THEN
							Response.Write "Sub-Broker"
						elseif TRIM(strRowRes(4))="U" THEN
							Response.Write "Surveillance User"
						elseif TRIM(strRowRes(4))="R" THEN
							Response.Write "Surveillance Manager"							
						END IF
						%> disabled></TD>
					</tr>	
					<tr class=tdbglight align=left>
						<TD width="140">Last Modified Date:</TD>
						<TD width="148"><input type="text" name="txtCoyLstModDt" size="25" value="<%=strRowRes(2)%>" disabled></TD>
						<TD width="137">Suspension Start Date:</TD>
						<TD width="186"><input type="text" name="txtCoySusStDt" size="25" value="<%=strRowRes(9)%>" disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="140">Suspension End Date:</TD>
						<TD width="148"><input type="text" name="txtCoySusEndDT" size="25" value="<%=strRowRes(10)%>" disabled></TD>
						<TD width="137">Suspension Status:</TD>
						<TD width="186"><input type="text" name="txtCoySusSts" size="25"
						value=
						<%if trim(strRowRes(3))="N" then
							Response.Write "ACTIVE"
						elseif trim(strRowRes(3))="H" then
							Response.Write "HALTED"
						elseif trim(strRowRes(3))="P" then
							Response.Write "SUSPENDED"
						elseif trim(strRowRes(3))="D" then
							Response.Write "SUSPENDED"
						end if
						%> disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="140">COY Process Name:</TD>
						<TD width="148"><input type="text" name="txtCoyProsName" size="25" value="<%=strRowRes(7)%>" disabled></TD>
						<TD width="137">RMS Process Name:</TD>
						<TD width="186"><input type="text" name="txtCoyRMSProsName" size="25" value="<%=strRowRes(11)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="140">M 2 M Process Name:</TD>
						<TD width="148"><input type="text" name="txtM2MProcName" size="25" value="<%=strRowRes(11)%>" disabled></TD>
						<td width="137">&nbsp;</td>
						<td width="186">&nbsp;</td>
					</tr>			
				</TABLE>
				</center>			
			<%case "INST":%>
				<center>
				<TABLE border="1"  cellpadding=1 cellspacing=1 width="661" >
					<TR class=tdbgdark>
						<TD colspan="4" align="center" width="651"><font class=whiteboldtext1>Contract Details</font></TD>
					</TR>
					<tr class=tdbglight align=left>
						<TD width="142">Contract Code:</TD>
						<TD width="148"><input type="text" name="txtInstContCode" VALUE="<%=strRowRes(0)%>" DISABLED size="25"></TD>
						<TD width="145">Contract Base Price:</TD>
						<TD width="198"><input type="text" name="txtInstContBP" VALUE="<%=cdbl(strRowRes(21)/100)%>" DISABLED size="25"></TD>
					</tr>	
					<tr class=tdbglight align=left>
						<TD width="142">Contract Description:</TD>
						<TD width="148"><input type="text" name="txtInstContDesc" VALUE="<%=strRowRes(3)%>" DISABLED size="25"></TD>
						<TD width="145">Last Modified Date:</TD>
						<TD width="198"><input type="text" name="txtInstLstModDt" value=<%=strRow(1)%> disabled size="25"></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="142">Trade Start Date:</TD>
						<TD width="148"><input type="text" name="txtInstTrdStDt" size="25" VALUE="<%=strRowRes(8)%>" disabled></TD>
						<TD width="145">Trade End Date:</TD>
						<TD width="198"><input type="text" name="txtInstTrdEndDT" size="25" VALUE="<%=strRowRes(9)%>" disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="142">Delivery Start Date:</TD>
						<TD width="148"><input type="text" name="txtInstDelStDt" size="25" VALUE="<%=strRowRes(11)%>" disabled></TD>
						<TD width="145">Delivery End Date:</TD>
						<TD width="198"><input type="text" name="txtInstDelEndDT" size="25" VALUE="<%=strRowRes(12)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="142">Circuit Filter:</TD>
						<TD width="148"><input type="text" name="txtInstCirFilt" size="25" VALUE="<%=cdbl(strRowRes(4))/100%>" disabled></TD>
						<TD width="145">Settlement Circuit Filter:</TD>
						<TD width="198"><input type="text" name="txtInstSetCirFilt" size="25" VALUE="<%=cdbl(strRowRes(17))/100%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="142">Contract Group:</TD>
						<TD width="148"><input type="text" name="txtInstContGrp" size="25"  VALUE="<%=strRowRes(2)%>" disabled></TD>
						<TD width="145">Contract Lot Size:</TD>
						<TD width="198"><input type="text" name="txtInstLotSize" size="25" value=<%=strRowRes(7)%> disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="142">OCP Trade Count:</TD>
						<TD width="148"><input type="text" name="txtInstOCPTrdCnt" size="25" value=<%=strRowRes(14)%> disabled></TD>
						<TD width="145">Contract Type:</TD>
						<TD width="198"><input type="text" name="txtInstContType" size="25" VALUE="<%=strRowRes(1)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="142">Contract Drip Quantity:</TD>
						<TD width="148"><input type="text" name="txtInstDripQty" size="25" value=<%=cdbl(strRowRes(20))/100%> disabled></TD>
						<TD width="145">OCP Trade Duration:</TD>
						<TD width="198"><input type="text" name="txtInstOCPTrdDur" size="25" value=<%=strRowRes(5)%> disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="142">Contract Status:</TD>
						<TD width="148"><input type="text" name="txtInstStatus" size="25" 
						value=
						<%if trim(strRowRes(16))="N" then
							Response.Write "ACTIVE"
						elseif trim(strRowRes(16))="H" then
							Response.Write "HALTED"
						elseif trim(strRowRes(16))="P" then
							Response.Write "SUSPENDED"
						elseif trim(strRowRes(16))="D" then
							Response.Write "SUSPENDED"
						end if
						%> disabled></TD>
						<TD width="145">Tick Size:</TD>
						<TD width="198"><input type="text" name="txtInstTickSize" size="25" value=<%=cdbl(strRowRes(6))/100%> disabled></TD>
					</tr>			
				</TABLE>
				</center>
			<%case "TMA":%>
				<center>
				<TABLE border="1"  cellpadding=1 cellspacing=1 width="585" >
					<TR class=tdbgdark>
						<TD colspan="4" align="center" width="579"><font class=whiteboldtext1>TMA Details</font></TD>
					</TR>
					<tr class=tdbglight align=left>
						<TD width="104">Changed Time:</TD>
						<TD width="148"><input type="text" name="txtTMACTime" size="25" value="<%=strRowRes(1)%>" disabled></TD>
						<TD width="121">Attached Entity:</TD>
						<TD width="188"><input type="text" name="txtTMAAttEnt" size="25" 
						value=
						"<%if trim(strRowRes(5))="B" then
							Response.Write "BASKET"
						elseif trim(strRowRes(5))="M" then
							Response.Write "MARKET"
						elseif trim(strRowRes(5))="I" then
							Response.Write "CONTRACT"
						end if
						%>"disabled></TD>
					</tr>	
					<tr class=tdbglight align=left>
						<TD width="104">Event Code:</TD>
						<TD width="148"><input type="text" name="txtTMAEvntCode" size="25" value=<%=strRowRes(2)%> disabled></TD>
						<TD width="121">Last Modified Date:</TD>
						<TD width="188"><input type="text" name="txtTMALstModDt" size="25" value="<%=strRow(1)%>" disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="104">Market Code:</TD>
						<TD width="148"><input type="text" name="txtTmaMktCode" size="25" value="<%=strRowRes(0)%>" disabled></TD>
						<TD width="121">Basket Code:</TD>
						<TD width="188"><input type="text" name="txtTMABasCode" size="25" value="<%=strRowRes(3)%>" disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="104">Instrument Code:</TD>
						<TD width="148"><input type="text" name="txtTmaInstCode" size="25" value="<%=strRowRes(4)%>" disabled></TD>
						<TD width="121">Next Phase:</TD>
						<TD width="188"><input type="text" name="txtTMANxtPhs" size="25" value="<%=strRowRes(7)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="104">Random Delay:</TD>
						<TD width="148"><input type="text" name="txtTMARndDel" size="25" value="<%=strRowRes(8)%>" disabled></TD>
						<TD width="121">Process Status:</TD>
						<TD width="188"><input type="text" name="txtTMAProsSts" size="25" value="<%=strRowRes(9)%>" disabled></TD>
					</tr>
					<tr class=tdbglight align=left>
						<TD width="104">Comments:</TD>
						<TD width="148"><input type="text" name="txtTMACmts" size="25" value="<%=strRowRes(10)%>" disabled></TD>
						<td width="121">&nbsp;</td>
						<td width="188">&nbsp;</td>
					</tr>			
				</TABLE>
				</center>						
			<%case "USR":%>
				<center>
				<TABLE border="1"  cellpadding=1 cellspacing=1 width="663" >
					<TR class=tdbgdark>
						<TD colspan="4" align="middle" width="673"><font class=whiteboldtext1>User Details</font></TD>
					</TR>
					<tr class=tdbglight align=left>
						<TD width="211">User Id:</TD>
						<TD width="148"><input type="text" name="txtUsrId" value="<%=strRowRes(1)%>" disabled size="25"></TD>
						<TD width="145">User Company Id:</TD>
						<TD width="151"><input type="text" name="txtUsrCompId" value="<%=strRowRes(2)%>" disabled size="25"></TD>
					</tr>	
					<tr class=tdbglight align=left>
						<TD width="211">User Type:</TD>
						<TD width="148"><input type="text" name="txtUsrType"
						value="<%
						IF TRIM(strRowRes(3))="M" THEN
							Response.Write "MAC"
						elseif TRIM(strRowRes(3))="I" THEN
							Response.Write "ICM"
						elseif TRIM(strRowRes(3))="T" THEN
							Response.Write "TCM"
						elseif TRIM(strRowRes(3))="C" THEN
							Response.Write "Client"
						elseif TRIM(strRowRes(3))="J" THEN
							Response.Write "Sub-Broker"
						elseif TRIM(strRowRes(3))="U" THEN
							Response.Write "Surveillance User"
						elseif TRIM(strRowRes(3))="R" THEN
							Response.Write "Surveillance Manager"							
						END IF
						%>" disabled size="25"></TD>
						<TD width="145">Last Modified Date:</TD>
						<TD width="151"><input type="text" name="txtLstModDt" value="<%=strRow(1)%>" disabled size="25"></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="211">Cont Process:</TD>
						<TD width="148"><input type="text" name="txtContProcess" size="25" disabled></TD>
						<TD width="145">Logon Status:</TD>
						<TD width="151"><input type="text" name="txtLgnSts" size="25" disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="211">Password Start Date:</TD>
						<TD width="148"><input type="text" name="txtPwdStDt" size="25" VALUE="<%=MID(strRowRes(10),1,10)%>" disabled></TD>
						<TD width="145">Password End Date:</TD>
						<TD width="151"><input type="text" name="txtPwdEndDt" size="25" value="<%=strRowRes(7)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="211">Password Expiry Period (In Days):</TD>
						<TD width="148"><input type="text" name="txtPwdExpPrd" size="25" value="<%=strRowRes(8)%>" disabled></TD>
						<TD width="145">User Suspension Status:</TD>
						<TD width="151"><input type="text" name="txtUsrSusSts" size="25" VALUE=
						<%if trim(strRowRes(11))="N" then
							Response.Write "ACTIVE"
						elseif trim(strRowRes(11))="H" then
							Response.Write "HALTED"
						elseif trim(strRowRes(11))="P" then
							Response.Write "SUSPENDED"
						elseif trim(strRowRes(11))="D" then
							Response.Write "SUSPENDED"
						END IF
						%> DISABLED></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="211">Company Suspension Status:</TD>
						<TD width="148"><input type="text" name="txtCoySusSts" size="25" VALUE=
						<%if trim(strRowRes(12))="N" then
							Response.Write "ACTIVE"
						elseif trim(strRowRes(12))="H" then
							Response.Write "HALTED"
						elseif trim(strRowRes(12))="P" then
							Response.Write "SUSPENDED"
						elseif trim(strRowRes(12))="D" then
							Response.Write "SUSPENDED"
						END IF
						%> DISABLED></TD>
						<TD width="145">Logon Start Date:</TD>
						<TD width="151"><input type="text" name="txtLgnStDt" size="25" VALUE=<%=strRowRes(14)%> DISABLED></TD>
					</tr>
					<tr class=tdbglight align=left>
						<TD width="211">Logon End Date:</TD>
						<TD width="148"><input type="text" name="txtLgnEndDt" size="25" VALUE=<%=strRowRes(15)%> DISABLED></TD>
						<td width="145">&nbsp;</td>
						<td width="151">&nbsp;</td>
					</tr>			
				</TABLE>
				</center>
			<%case "UPER":%>
				<center>
				<TABLE border="1"  cellpadding=1 cellspacing=1 width="663" >
					<TR class=tdbgdark>
						<TD colspan="4" align="center" width="653"><font class=whiteboldtext1>UPER Details</font></TD>
					</TR>
					<tr class=tdbglight align=left>
						<TD width="164">User Id:</TD>
						<TD width="148"><input type="text" name="txtUperId" value="<%=strRowRes(1)%>" disabled size="25"></TD>
						<TD width="156">User Company Id:</TD>
						<TD width="167"><input type="text" name="txtUperCompId" size="25" value="<%=strRowRes(2)%>" disabled></TD>
					</tr>	
					<tr class=tdbglight align=left>
						<TD width="164">User Type:</TD>
						<TD width="148"><input type="text" name="txtUperType" size="25"
						value="<%
						IF TRIM(strRowRes(3))="M" THEN
							Response.Write "MAC"
						elseif TRIM(strRowRes(3))="I" THEN
							Response.Write "ICM"
						elseif TRIM(strRowRes(3))="T" THEN
							Response.Write "TCM"
						elseif TRIM(strRowRes(3))="C" THEN
							Response.Write "Client"
						elseif TRIM(strRowRes(3))="J" THEN
							Response.Write "Sub-Broker"
						elseif TRIM(strRowRes(3))="U" THEN
							Response.Write "Surveillance User"
						elseif TRIM(strRowRes(3))="R" THEN
							Response.Write "Surveillance Manager"							
						END IF%>" disabled></TD>
						<TD width="156">Sex:</TD>
						<TD width="167"><input type="text" name="txtUperSex" size="25" value="<%=strRowRes(8)%>" disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="164">First Name:</TD>
						<TD width="148"><input type="text" name="txtUperFN" size="25" value="<%=strRowRes(4)%>" disabled></TD>
						<TD width="156">Middle Name:</TD>
						<TD width="167"><input type="text" name="txtUperMN" size="25" value="<%=strRowRes(5)%>" disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="164">Last Name:</TD>
						<TD width="148"><input type="text" name="txtUperLN" size="25" value="<%=strRowRes(6)%>" disabled></TD>
						<TD width="156">Last Modified Date:</TD>
						<TD width="167"><input type="text" name="txtUperLstModDt" size="25" value="<%=strRowRes(37)%>" disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="164">Application Number:</TD>
						<TD width="148"><input type="text" name="txtUperAppNO" size="25" value="<%=strRowRes(20)%>" disabled></TD>
						<TD width="156">Application Date:</TD>
						<TD width="167"><input type="text" name="txtUperAppDate" size="25" value="<%=strRowRes(21)%>" disabled></TD>
					</tr>		
					<tr class=tdbglight align=left>
						<TD width="164">Registration Date:</TD>
						<TD width="148"><input type="text" name="txtUperRegDate" size="25" value="<%=strRowRes(29)%>" disabled></TD>
						<TD width="156">Inserted By (MAC User):</TD>
						<TD width="167"><input type="text" name="txtUperInsBy" size="25" value="<%=strRowRes(30)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="164">Date Of Birth:</TD>
						<TD width="148"><input type="text" name="txtUperDOB" size="25" value="<%=strRowRes(7)%>" disabled></TD>
						<TD width="156">Contact Person Name:</TD>
						<TD width="167"><input type="text" name="txtUperContPerName" size="25" value="<%=strRowRes(19)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="164">Mailing Address:</TD>
						<TD width="148"><input type="text" name="txtUperMailAdd1" size="25" value="<%=strRowRes(13)%>" disabled><br>
						<input type="text" name="txtUperMailAdd2" size="25" value="<%=strRowRes(14)%>" disabled><br>
						<input type="text" name="txtUperMailAdd3" size="25" value="<%=strRowRes(15)%>" disabled></TD>
						<TD width="156">Permanent Address:</TD>
						<TD width="167"><input type="text" name="txtUperPerAdd1" size="25" value="<%=strRowRes(16)%>" disabled><br>
						<input type="text" name="txtUperPerAdd2" size="25" value="<%=strRowRes(17)%>" disabled><br>
						<input type="text" name="txtUperPerAdd3" size="25" value="<%=strRowRes(18)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="164">Phone Number:</TD>
						<TD width="148"><input type="text" name="txtUperPhNo" size="25" value="<%=strRowRes(9)%>" disabled></TD>
						<TD width="156">Email Address:</TD>
						<TD width="167"><input type="text" name="txtUperEmail" size="25" value="<%=strRowRes(11)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="164">Mobile Number:</TD>
						<TD width="148"><input type="text" name="txtUperMobile" size="25" value="<%=strRowRes(10)%>" disabled></TD>
						<TD width="156">Fax Number:</TD>
						<TD width="167"><input type="text" name="txtUperFax" size="25" value="<%=strRowRes(12)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="164">Registration Fee:</TD>
						<TD width="148"><input type="text" name="txtUperRegFee" size="25" value="<%=cdbl(strRowRes(22))/100%>" disabled></TD>
						<TD width="156">Equity Fee:</TD>
						<TD width="167"><input type="text" name="txtUperEqFee" size="25" value="<%=cdbl(strRowRes(23))/100%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="164">Security Deposit:</TD>
						<TD width="148"><input type="text" name="txtUperSecDep" size="25" value="<%=cdbl(strRowRes(24))/100%>" disabled></TD>
						<TD width="156">Margin Money:</TD>
						<TD width="167"><input type="text" name="txtUperMginMon" size="25" value="<%=cdbl(strRowRes(25))/100%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="164">PAN Number:</TD>
						<TD width="148"><input type="text" name="txtUperPAN" size="25" value="<%=strRowRes(32)%>" disabled></TD>
						<TD width="156">Sales Tax Number:</TD>
						<TD width="167"><input type="text" name="txtUperSTNo" size="25" value="<%=strRowRes(34)%>" disabled></TD>
					</tr>			
					<tr class=tdbglight align=left>
						<TD width="164">Central Sales Tax Number:</TD>
						<TD width="148"><input type="text" name="txtUperCenSTNo" size="25" value="<%=strRowRes(35)%>" disabled></TD>
						<TD width="156">&nbsp;</TD>
						<TD width="167">&nbsp;</TD>
					</tr>						
				</TABLE>
				</center>
		<%end select%>
<%else%>		
	<center>
		<table>
			<tr>
				<td>No Details For Your Selection</td>
			</tr>
		</table>
	</center>
<%end if%>
<BR>
<center>Click <a href="http://obulap/mac/audit/auditLog.asp">Here </a>To Go To The Previous Page</center>
<P>&nbsp;</P>
<!---#include file="../includes/footer.inc"--->
</BODY>
</HTML>
