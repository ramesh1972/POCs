<%@language=vbscript%>
<%
	dim objMacWeb
	dim objRsMac
	set objMacWeb=server.CreateObject("MacWebCon.clsMacWebCon")
	set objRsMac=server.CreateObject("ADODB.Recordset")
	set objRsMac=objMacWeb.GetMacUsers()
	if objRsMac.BOF =false then
		objRsMac.MoveFirst 
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft FrontPage 4.0">
<TITLE></TITLE>
<link rel="stylesheet" href="../Includes/Theme.css">
<script language="javascript">
	var dtmValue;
	function fn_Sel_User()
	{
		document.frmAuditLog.hdnSelUsrId.value=document.frmAuditLog.selUser.options[document.frmAuditLog.selUser.selectedIndex].value;
	}
	function fn_SelOPn()
	{
		document.frmAuditLog.hdnSelAction.value=document.frmAuditLog.selAction.options[document.frmAuditLog.selAction.selectedIndex].value;
	}
	function fn_Sel_Table()
	{
		document.frmAuditLog.hdnSelTable.value=document.frmAuditLog.selTables.options[document.frmAuditLog.selTables.selectedIndex].value;
	}
	function fn_holdDtVal()
	{
		dtmValue=document.frmAuditLog.txtDate.value;
		document.frmAuditLog.hdnDTVal.value=dtmValue;
	}
	
	function fn_Choose()
	{
		var intLen = document.frmAuditLog.rdoChoose.length;
		var intI;
		for (intI=0;intI<intLen;intI++)
		{
			if (document.frmAuditLog.rdoChoose[intI].checked==true)
			{
				document.frmAuditLog.method ="post";
				document.frmAuditLog.action ="adtLogSelScreen.asp"
				document.frmAuditLog.submit();
				return true;
			}
		}
		alert("You Have To Choose Any Particular Item");
		return false;
	}
</script>
</HEAD>
<BODY>
<!--#include file="../includes/header.inc"-->
		<br>
<!--- #include file="../includes/MAClinks.inc" --->
<br>
<FORM NAME ="frmAuditLog" METHOD="POST">
	<table width="347" align="center" border="1"  cellpadding=1 cellspacing=1>
		<tr class=tdbgdark height=30 align=middle>
			<td align=left width="337" colspan=2>
				<font class=whiteboldtext1>Audit Log Search Options</font>
			</td>
		</tr>
		<tr class=tdbglight height=30 align=left>
			<td>User Id:</td>
			<td>
				<select name="selUser" style="HEIGHT: 22px; WIDTH: 130px" onchange="fn_Sel_User()">
					<option value="">---- MAC Users ----</option>
						  <%while not objRsMac.EOF %>
								<%if trim(Request.Form("hdnSelUsrId"))=objRsMac(0) then%>
									<OPTION value=<%=objRsMac(0)%> selected><%=objRsMac(0)%></OPTION>
								<%else%>
									<OPTION value=<%=objRsMac(0)%>><%=objRsMac(0)%></OPTION>
								<%end if%>
							<%objRsMac.MoveNext%>		
							<%wend
							objRsMac.Close
							set objRsMac=nothing
							%>
						<%
						else
							  objRsMac.Close
							  set objRsMac=nothing
						end if
						%>
				</select>
					
			</td>
		</tr>
		<tr class=tdbglight height=30 align=left>
			<td>Action:</td>
			<td>
				<select name="selAction" style="HEIGHT: 22px; WIDTH: 130px" onChange="fn_SelOPn()">
					<option value="">--------  Action  --------</option>
					<%if trim(Request.Form("hdnSelAction"))="INSERT" then%>
						<option value="INSERT" selected>INSERT</option>
					<%else%>
						<option value="INSERT">INSERT</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelAction"))="UPDATE" then%>
						<option value="UPDATE" selected>UPDATE</option>
					<%else%>
						<option value="UPDATE">UPDATE</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelAction"))="DELETE" then%>
						<option value="DELETE" selected>DELETE</option>
					<%else%>
						<option value="DELETE">DELETE</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelAction"))="DEACTIVATE" then%>
						<option value="DEACTIVATE" selected>DEACTIVATE</option>
					<%else%>
						<option value="DEACTIVATE">DEACTIVATE</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelAction"))="REACTIVATE" then%>
						<option value="REACTIVATE" selected>REACTIVATE</option>	
					<%else%>
						<option value="REACTIVATE">REACTIVATE</option>	
					<%end if%>
					<%if trim(Request.Form("hdnSelAction"))="SUSPEND" then%>
						<option value="SUSPEND" selected>SUSPEND</option>
					<%else%>
						<option value="SUSPEND">SUSPEND</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelAction"))="UNSUSPEND" then%>
						<option value="UNSUSPEND" selected>UNSUSPEND</option>
					<%else%>
						<option value="UNSUSPEND">UNSUSPEND</option>
					<%end if%>
				</select>
			</td>
		</tr>
		<tr class=tdbglight height=30 align=left>
			<td>Tables:</td>
			<td>
				<select name="selTables" style="HEIGHT: 22px; WIDTH: 130px" onChange="fn_Sel_Table()">
					<option value="">--------  Tables  --------</option>
					<%if trim(Request.Form("hdnSelTable"))="MKI" then%>
						<option value="MKI" selected>MKI</option>
					<%else%>
						<option value="MKI">MKI</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelTable"))="USR" then%>
						<option value="USR" selected>USR</option>	
					<%else%>
						<option value="USR">USR</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelTable"))="COY" then%>
						<option value="COY" selected>COY</option>
					<%else%>
						<option value="COY">COY</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelTable"))="INST" then%>
						<option value="INST" selected>INST</option>	
					<%else%>
						<option value="INST">INST</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelTable"))="TMA" then%>
						<option value="TMA" selected>TMA</option>	
					<%else%>
						<option value="TMA">TMA</option>
					<%end if%>
					<%if trim(Request.Form("hdnSelTable"))="UPER" then%>
						<option value="UPER" selected>UPER</option>	
					<%else%>
						<option value="UPER">UPER</option>
					<%end if%>
				</select>
			</td>
		</tr>
		<tr class=tdbglight height=30 align=left>
			<td>
			Date:(Eg.YYYY-MM-DD)
			</td>
			<td><INPUT TYPE="TEXT" NAME="txtDate" style="HEIGHT: 22px; WIDTH: 130px" 
			<%if trim(Request.Form("hdnDTVal"))<>"" then%>
			value="<%Response.Write Request.Form("hdnDTVal")%>"
			<%end if%>
			maxlength="10" onBlur="fn_holdDtVal()"></td>
		</tr>
		<tr class=tdbglight height=30 align=left>
			<td ALIGN ="CENTER"	COLSPAN="2"><INPUT TYPE="SUBMIT" VALUE="Submit"></td>
			
		</tr>
	</table><br><br>
<%
	Dim lResult 
	Dim lFUserId
	Dim lFDate
	Dim lLUserId
	Dim lLDate
	Dim lRespStr
	Dim lRecCount
	Dim objTrdLog
	dim dtmTimeStamp
	dim strBotLineUid
	dim strTopLineUid
	dim strTopLineTS
	dim strBotLineTS
	dim strSwapPrevUid
	dim strSwapPrevTS
	dim piNPUsrId
	dim piNPLstTS
	dim intPageCount
	DIM strSelUserId
	dim strSelAction
	dim strSelTables
	if trim(Request.Form("selUser"))="" then
		strSelUserId=" "
	else
		strSelUserId=Request.Form("selUser")
	end if
	if trim(Request.Form("selAction"))="" then
		strSelAction=" "
	else
		strSelAction=Request.Form("selAction")
	end if
	if trim(Request.Form("selTables"))="" then
		strSelTables = "  "
	else
		strSelTables = Request.Form("selTables")
	end if
	if Request.Form("hdnPageCount")="" then
		intPageCount=0
	end if
	if trim(Request.Form("hdnBrowseSts"))="" then
		strStatus=" "
	else
		strStatus = trim(Request.Form("hdnBrowseSts"))
	end if
	if trim(Request.Form("txtDate"))="" and trim(Request.Form("txtTime")) ="" then
		dtmTimeStamp="1900-01-01:01:01:01.000001"
	elseif trim(Request.Form("txtDate")) <> "" then
		dtmTimeStamp=Request.Form("txtDate") & ":01:01:01.000000"
	end if
	if trim(Request.Form("hdnNextUid"))="" and trim(Request.Form("hdnNextTS"))="" then
		piNPUsrId="            "
		piNPLstTS="1900-01-01:01:01:01.000001"
	end if
	IF trim(strStatus)="N" then
		piNPUsrId=trim(Request.Form("hdnNextUid"))
		piNPLstTS=trim(Request.Form("hdnNextTS"))
		intPageCount=cint(Request.form("hdnPageCount"))+1
		strFinalList=Request.Form("hdnFinalUidTS")
		strFinalList= strFinalList &  "|" & Request.Form("hdnPrevUserId") & "," & Request.Form("hdnPrevTS")
	elseif trim(strStatus)="P" then
		intPageCount=cint(Request.form("hdnPageCount"))-1
		strFinalList=Request.Form("hdnFinalUidTS")
		t1=instrrev(strFinalList,"|")
		strPrevUidTS=mid(strFinalList,t1+1,len(strFinalList)-t1)
		t2=instr(strPrevUidTS,",")
		piNPUsrId=mid(strPrevUidTS,1,t2-1)
		piNPLstTS=mid(strPrevUidTS,t2+1,len(strPrevUidTS)-t2)
		strFinalList=mid(strFinalList,1,t1-1)
		if intPageCount = 0 then
			piNPUsrId="            "
			piNPLstTS="1900-01-01:01:01:01.000001"
		end if
	end if
	set objTrdLog=server.CreateObject("Mac.AdtLogMgr")
	Dim strResult
	strResult = objTrdLog.AdtLog(strSelUserId, trim(dtmTimeStamp), strSelTables, strSelAction ,piNPUsrId,piNPLstTS, "MZE0006000", lFUserId, lFDate, lLUserId, lLDate, lRecCount, lRespStr)
	'Response.Write strResult  & " " &  lRecCount & " " & lRespStr 	
	'lResult = obj.AdtLog(" ", "1900-01-01:01:01:01.000001", " ", " ", " ", " ", "MZE0006000", lFUserId, lFDate, lLUserId, lLDate, lRecCount, lRespStr)
	'Response.Write "<br>"& "Selected User Id :" & strSelUserId &"<br>"
	'Response.Write "Date Time Stamp:" & dtmTimeStamp
	'Response.Write "<BR>" & strStatus & "<br>" &"<br>"
	'Response.Write "User Id: " & piNPUsrId & "<br>"
	'Response.Write "User Timestamp: " & piNPLstTS & "<br>"
	'Response.Write "Page Count:" & intPageCount & "<br>"
	'Response.Write "Swap User Id:" & strSwapPrevUid & "<br>"
	'Response.Write "Swap Time Stamp" & strSwapPrevTS & "<br>"
	if strResult = "0" then
%>
		<center>
		<TABLE border="1"  cellpadding=1 cellspacing=1 >
				<TR class=tdbgdark>
					<TD><font class=whiteboldtext1>Select</font></TD>
					<TD><font class=whiteboldtext1>User Id</font></TD>
					<TD><font class=whiteboldtext1>Time stamp</font></TD>
					<TD><font class=whiteboldtext1>Entity</font></TD>
					<TD><font class=whiteboldtext1>Action</font></TD>
				<TR>	
		<%dim strLn
		dim strFld
		dim intLnNO'used for the line nos
		dim intFldNO
		strLn=split(lRespStr,"$")
		for intLnNO= 0 to ubound(strLn) -1
		strFld=split(strLn(intLnNO),"|")
			if intLnNO = 0 then %>
				<tr class=tdbglight>
					<td><input type ="radio" name="rdoChoose" value="<%=strFld(0)%>,<%=strFld(1)%>,<%=strFld(2)%>"></td>	
					<td><%=strFld(0)%></td>
					<td><%=strFld(1)%></td>
					<td><%=strFld(2)%></td>
					<td><%=strFld(3)%></td>
				</tr>
					<%
					strBotLineUid=strFld(0)
					strBotLineTS=strFld(1)
					%>
			<%else%>
				<tr class=tdbglight>
					<td><input type ="radio" name="rdoChoose" value="<%=strFld(0)%>,<%=strFld(1)%>,<%=strFld(2)%>"></td>	
					<td><%=strFld(0)%></td>
					<td><%=strFld(1)%></td>
					<td><%=strFld(2)%></td>
					<td><%=strFld(3)%></td>
				</tr>
				<%
				strBotLineUid=strFld(0)
				strBotLineTS=strFld(1)
				%>
			<%end if%>
		<%next%>	
		</TABLE>
		<center>
<%else%>
	<center>
	<table>
		<tr class=tdbgdark>
			<td><font class=whiteboldtext1>No Records For Your Selection</font></td>
		</tr>
	</table>
	</center>
<%end if%>
<input type="hidden" name="hdnNextUid" value=<%=strBotLineUid%>>
<input type="hidden" name="hdnNextTS" value=<%=strBotLineTS%>>
<input type="hidden" name="hdnBrowseSts"><br>
<input type="hidden" name="hdnPageCount" value=<%=intPageCount%>><br>
<input type="hidden" name ="hdnFinalUidTS" value=<%=strFinalList%>>
<input type="hidden" name="hdnPrevUserID" value=<%=piNPUsrId%>><br>
<input type="hidden" name ="hdnPrevTS" value=<%=piNPLstTS%>>
<input type="hidden" name="hdnSelUsrId">
<input type="hidden" name="hdnSelAction">
<input type="hidden" name="hdnSelTable">
<INPUT TYPE="hidden" NAME="hdnDTVal">
<center>
	<TABLE>
		<tr class=tdbglight height=30 align="center">
		<td>
		   <input type="button" name="btnChose" value="Choose" onClick="fn_Choose();">
		   <input type="button" name="btnPrev" value="Previous"
		   <%if intPageCount = 0 then%>
			disabled
		   <%end if%>
		   onclick="document.frmAuditLog.hdnBrowseSts.value='P'; 
		   document.frmAuditLog.method='post';
		   document.frmAuditLog.action='auditLog.asp';
		   document.frmAuditLog.submit();">
		   <input type="button" name="btnNext" value="    Next    "
		   <%if lRecCount < 14 then%>
			disabled
		   <%end if%>
		   onclick="document.frmAuditLog.hdnBrowseSts.value='N'; 
		   document.frmAuditLog.method='post';
		   document.frmAuditLog.action='auditLog.asp';
		   document.frmAuditLog.submit();">
		</td>
		</tr>   
	</TABLE>
</center>
</FORM>
<!---#include file="../includes/footer.inc"--->
</BODY>
</HTML>
