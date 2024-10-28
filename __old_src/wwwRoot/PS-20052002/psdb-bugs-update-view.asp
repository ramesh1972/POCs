<% Response.Buffer = True %>
<%
	'**************************************************************************
	'* Application	:	BOOE												  *
	'* Module		:	Production Support									  *
	'* File name	:	psdb-system-view.asp								  *
	'* Purpose		:	This is system view of bugs							  *
	'* Prepared by	:	Ramesh Viswanathan								      *	
	'* Date			:	20.10.2001											  *
	'* Copyright	:	(C) SSI Technologies,India							  *
	'*																		  *
	'**************************************************************************

	'**************************************************************************
	'* Revision History														  *
	'* Version No. Date				By					  Explanation	   	  *
	'*	1		   20.10.2001		Ramesh Viswanathan    First Baseline	  *
	'*																		  *
	'**************************************************************************
%>
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("../timesheet/ts-logon-start.asp")
	end if
%>
<%
	Dim lBugsGroupID
	
	lBugsGroupID = Request.Cookies ("BugsGroupID")
	if lBugsGroupID = "" Then
		Response.Redirect("psdb-bugs-group-select.asp")
	end if
%>
<% 
	Dim rst
	Dim lRs	
	Dim lSBObj
	Dim lTSObj	
	
	Dim lmodule1
	Dim lstatus1
	Dim lpriority1
	Dim lrepby1
	Dim lresp1
	Dim lfixedby1
	Dim lverby1
	Dim lserverity1

	dim lstartDate
	dim lEndDate
	dim lStartDay
	dim lStartMonth
	dim lStartYear
	dim lEndDay	
	dim lEndMonth
	dim lEndYear

	dim lShowPage
	dim lShowNextTen
	dim lPageSize
	dim lTotalPage
	dim lCount	
	dim lCheckFlag
	dim lCheckRecord
	dim lRecordsShown
	dim lShowPageCount
	dim lStart
	dim lEnd

	Dim lIdentifier
	Dim lShortDescription
	Dim lReportedBy
	Dim lReportedDate
	Dim lStatus
	Dim lModule
	Dim lPriority
	Dim lSeverity
	Dim lResponsibility
	Dim lEstimatedTime
	Dim lFixedBy
	Dim lFixedDate
	Dim lVerifiedBy
	Dim lVerifiedDate
	
	lIdentifier = Request.Form("hIdentifier1")
	lShortDescription = Request.Form("hShortDescription1")
	lReportedBy = Request.Form("hReportedBy1")
	lReportedDate = Request.Form("hReportedDate1")
	lStatus = Request.Form("hStatus1")
	lModule = Request.Form("hModule1")
	lPriority = Request.Form("hPriority1")
	lSeverity = Request.Form("hSeverity1")
	lResponsibility = Request.Form("hResponsibility1")
	lEstimatedTime = Request.Form("hEstimatedTime1")
	lFixedBy = Request.Form("hFixedBy1")
	lFixedDate = Request.Form("hFixedDate1")
	lVerifiedBy = Request.Form("hVerifiedBy1")
	lVerifiedDate = Request.Form("hVerifiedDate1")
%>
	
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="../timesheet/theme.css">
</HEAD>
<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<!-- #include file="psdb-header.htm" -->
<script language="javascript">
document.all.oDivUpdateSel.style.background = "lightblue";
</script>
<BR>
<%
	If Request.Form("sModules") = "" Then
		lmodule1 = Request.Form("hModule")
	Else
		lmodule1 = Request.Form("sModules")
	End If

	lstatus1 = Request.Form("sBugsStatus")
	if (lstatus1 = "") Then
		lstatus1 = Request.Form("hStatus")
	End If

	lpriority1 = Request.Form("sBugsPriority")
	if (lpriority1 = "") Then
		lpriority1 = Request.Form("hPriority")
	End If

	lrepby1 = Request.Form("sBugsReportedBy")
	if (lrepby1 = "") Then
		lrepby1 = Request.Form("hRepBy")
	End If

	lresp1 = Request.Form("sBugsResponsibility")
	if (lresp1 = "") Then
		lresp1 = Request.Form("hResp")
	End If

	lfixedby1 = Request.Form("sBugsFixedBy")
	if (lfixedby1 = "") Then
		lfixedby1 = Request.Form("hFixedBy")
	End If

	lverby1 = Request.Form("sBugsVerifiedBy")
	if (lverby1 = "") Then
		lverby1 = Request.Form("hVerBy")
	End If

	lseverity1 = Request.Form("sBugsSeverity")
	if (lseverity1 = "") Then
		lseverity1 = Request.Form("hSeverity")
	End If

	if Request.Form("StartDate")="" then
		lStartDate = Request.Form("hStartDate")
	else
		lStartDay	=	cstr(Request.Form("StartDate"))
		if len(lStartDay) <=1  then
			lStartDay	=	0	&	lStartDay
		end if
		lStartMonth	=	cstr(Request.Form("StartMonth")) 
		if len(lStartMonth)<=1 then
			lStartMonth	=	0 & lStartMonth
		end if
		lStartYear	=	cstr(Request.Form("StartYear"))
		lStartDate	=	lStartMonth & "/" & lStartDay & "/" & lStartYear
		lStartDate	=	cstr(lStartDate)
	End If
	
	if Request.Form("EndDate")="" then
		lEndDate = Request.Form("hEndDate")
	else
		lEndDay		=	cstr(Request.Form("EndDate"))
		if len(lEndDay) <=1 then
			lEndDay	=	0	&	lEndDay
		end if
		lEndMonth	=	cstr(Request.Form("EndMonth")) 
		if len(lEndMonth) <=1 then
			lEndMonth	= 0 & lEndMonth
		end if
		lEndYear	=	cstr(Request.Form("EndYear"))
		lEndDate	=	lEndMonth & "/" & lEndDay & "/" & lEndYear
		lEndDate	=	cstr(lEndDate)
	End If
	
	Set rst = Server.CreateObject("ADODB.Recordset")
	Set lRs = Server.CreateObject("ADODB.Recordset")
	Set lTSObj = Server.CreateObject ("TimeSheet.clsTimeSheet")	
	Set lSBObj = Server.CreateObject ("Bugs.clsSoftwareBugs")
	
	Set rst = lSBObj.Display  (eval(lBugsGroupID), eval(lmodule1), eval(lstatus1), eval(lpriority1), eval(lseverity1), eval(lrepby1), eval(lresp1), eval(lfixedby1), eval(lverby1), Cdate(lStartDate), Cdate(lEndDate))
		
	lShowPage		=	Request.form("lShowPage")
	lShowNextTen	=	Request.form("lShowNextTen")
	if lShowNextTen	=	"" then 
		lShowNextTen=	0
	else
		lShowNextTen=	lShowNextTen-1
	end if
	if lShowPage	=	"" then 
		lShowPage	=	0
	else
		lShowPage	=	lShowPage-1
	end if

	lPageSize	= 10
	rst.PageSize	=	lPageSize
	lTotalPage	=	rst.PageCount
	lCount		=	0
	lCheckFlag	=	0
	lCheckRecord=	True
%>

<TABLE width=75% align="center">
<TR>
	<TD align=right><font class=colortext3 color=red>Page: <%=(lShowNextTen*10) + (lShowPage)+1%> of <%=lTotalPage%></font></TD>
</TR>
</TABLE>
<TABLE border=1 width=75% align="center" class="tdbgdark" STYLE="BORDER-COLLAPSE: collapse">
<TR>
	<TD bgcolor= "lightblue" width="10%" align="left"><B>Step</B> 3</TD>
	<TD width="90%" align="left"><font class="whiteboldtext">Select the Identifier Links to Update Bugs</font></TD>
</TR>
</TABLE>
<%
	Response.Write("<TABLE width=75% align=center border=1 class=tdbgdark style='border-collapse:collapse'>")
	Response.Write("<TR>")
	Response.Write("<TD align=center><font class=whiteboldtext>Identifier</TD>")
	If lModule = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Module</font></TD>")		
	End if
	If lShortDescription = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Short Description</font></TD>")
	End if
	If lStatus = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Status</font></TD>")
	End if
	If lPriority = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Priority</font></TD>")
	End if
	If lSeverity = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Severity</font></TD>")		
	End if
	If lReportedBy = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Reported By</font></TD>")
	End if
	If lReportedDate = "on" Then
		Response.Write("<TD width=50 align=center><font class=whiteboldtext>Reported Date</font></TD>")
	End if
	If lResponsibility = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Responsibility</font></TD>")														
	End if
	If lEstimatedTime = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Estimated Time</font></TD>")														
	End if
	if lFixedBy = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Fixed By</font></TD>")
	End if
	If lFixedDate = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Fixed Date</font></TD>")						
	End if
	If lVerifiedBy = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Verified By</font></TD>")
	End if
	If lVerifiedDate = "on" Then
		Response.Write("<TD align=center><font class=whiteboldtext>Verified Date</font></TD>")						
	End if
	Response.Write("</TR>")		
		
	If rst.RecordCount > 0 Then
		rst.AbsolutePage	=	(lShowNextTen*10)+(lShowPage)+1
		lShowPageCount	=	((lShowNextTen*10)+(lShowPage))*lPageSize
		do while lRecordsShown < cint(lPageSize) and not rst.EOF
			lRecordsShown=lRecordsShown+1
	
 			Response.Write("<TR class=tdbglight> ")
			Response.Write("<TD >")
			If rst("BR_Identifier") <> "" Then
				Response.Write("<A href=psdb-bugs-update-change.asp?Identifier=" & rst("BR_Identifier") & ">" & rst("BR_Identifier") & "</A>")
			Else
				Response.Write("&nbsp")
			End If
			Response.Write("</TD>")

			If lModule = "on" Then
				lName = lSBObj.GetModuleName(eval(trim(rst("M_ModuleID"))))
				Response.Write("<TD>")
				If lName <> "" Then
					Response.Write(lName)
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if
			
			If lShortDescription = "on" Then
				Response.Write("<TD>")
				If rst("BR_ShortDescription") <> "" Then
					Response.Write(rst("BR_ShortDescription"))
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if

			If lStatus = "on" Then
				lName = lSBObj.GetStatusName(eval(trim(rst("S_StatusID"))))
 				Response.Write("<TD>")
				If lName <> "" Then
					Response.Write(lName)
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if

			If lPriority = "on" Then		
				lName = lSBObj.GetPriority (eval(trim(rst("P_PriorityID"))))
 				Response.Write("<TD>")
				If lName <> "" Then
					Response.Write(lName)
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if

			If lSeverity = "on" Then
				lName = lSBObj.GetSeverity (eval(trim(rst("S_SeverityID"))))			
 				Response.Write("<TD>")
				If lName <> "" Then
					Response.Write(lName)
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if

			If lReportedBy = "on" Then			
				Set lRs = lTSObj.GetUserProfile (eval(trim(rst("BR_ReportedBy"))))
				lName = ""
				If (lRs.RecordCount > 0 ) Then
					lName = trim(lRs("U_Name"))
				End if
				Response.Write("<TD>")
				If lName <> "" Then
					Response.Write(lName)
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if
			
			If lReportedDate = "on" Then			
				Response.Write("<TD>")
				If rst("BR_ReportedDate") <> "" Then
					Response.Write(rst("BR_ReportedDate"))
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if
			
			If lResponsibility = "on" Then			
				Set lRs = lTSObj.GetUserProfile (eval(trim(rst("BR_Responsibility"))))						
				lName = ""
				If (lRs.RecordCount > 0 ) Then
					lName = trim(lRs("U_Name"))
				End if

				Response.Write("<TD>")
				If lName <> "" Then
					Response.Write(lName)
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			end if

			If lEstimatedTime = "on" Then			
				Response.Write("<TD>")
				If rst("BR_EstimatedTime") <> "" Then
					Response.Write(rst("BR_EstimatedTime"))
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if

			if lFixedBy = "on" Then			
				Set lRs = lTSObj.GetUserProfile (rst("BR_FixedBy"))									
				lName = ""
				If (lRs.RecordCount > 0 ) Then
					lName = trim(lRs("U_Name"))
				End if

				Response.Write("<TD>")
				If lName <> "" Then
					Response.Write(lName)
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if

			If lFixedDate = "on" Then			
				Response.Write("<TD>")
				If rst("BR_FixedDate") <> "" Then
					Response.Write(rst("BR_FixedDate"))
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if
			
			If lVerifiedBy = "on" Then			
				Set lRs = lTSObj.GetUserProfile (eval(trim(rst("BR_VerifiedBy"))))
				lName = ""
				If (lRs.RecordCount > 0 ) Then
					lName = trim(lRs("U_Name"))
				End if

				Response.Write("<TD>")
				If lName <> "" Then
					Response.Write(lName)
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if

			If lVerifiedDate = "on" Then
				Response.Write("<TD>")
				If rst("BR_VerifiedDate") <> "" Then
					Response.Write(rst("BR_VerifiedDate"))
				Else
					Response.Write("&nbsp")
				End If
				Response.Write("</TD>")
			End if
			Response.Write("</TR>")
			rst.MoveNext
		Loop
		Response.Write("</TABLE>")
	Else
		Response.Write("No data in the database")
		lCheckRecord	= false 
	End If
%>
	<table border=0 align=center width=75%>	 
	<tr>
<%	
	if lShowNextTen <>0 then 
		Response.Write "<td width=100% align=right><font class=colortext3>&nbsp;<a href='Javascript:document.frmHid.lShowPage.value=1;document.frmHid.lShowNextTen.value=" & lShowNextTen & ";document.frmHid.submit();'>Previous 10 pages</a>&nbsp;</td>"	
	end if
	if lShowPage > 0 then 
		Response.Write("<td width=100% align=right><font class=colortext3><a href='Javascript:document.frmHid.lShowPage.value=" & lShowPage & ";document.frmHid.lShowNextTen.value=" & lShowNextTen + 1 & ";document.frmHid.submit();'>Back </a>&nbsp;</td>")
	end if
	lCheckFlag	=	0
	lStart		=	lShowNextTen *10 + 1
	if (lTotalPage - lStart) >= 10 then
		lEnd	=	lShowNextTen *10 +10
		lCheckFlag	=	1
	else
		lEnd	=	lTotalPage
	end if
	lShowPageCount	=	0
	Response.Write "<td width=100% align=right><font class=colortext3>"
	if lTotalPage > 1 then
		for lCount	=	lStart to lEnd
			lShowPageCount	=	lShowPageCount + 1
			if lShowPageCount	=	lShowPage + 1 then
				Response.Write(lCount & "&nbsp;&nbsp;")
			else
				Response.Write("<a href='Javascript:document.frmHid.lShowPage.value=" & lShowPageCount & ";document.frmHid.lShowNextTen.value=" & lShowNextTen+1 & ";document.frmHid.submit();'>" & lCount & "</a>&nbsp;")
			end if
		next
	end if
	Response.Write "</font></td>"
	if lShowPage < (lEnd-lStart) then 
		Response.Write("<td width=100% align=right><font class=colortext3>&nbsp;<a href='Javascript:document.frmHid.lShowPage.value=" & lShowPage+2 & ";document.frmHid.lShowNextTen.value=" & lShowNextTen+1 & ";document.frmHid.submit();'>Next</a>&nbsp;</td>")
	end if
	if lCheckFlag	=	1 then 
		Response.Write "<td width=100% align=right><font class=colortext3><a href='Javascript:document.frmHid.lShowPage.value=1;document.frmHid.lShowNextTen.value=" & lShowNextTen+2 & ";document.frmHid.submit();'>Next 10 pages</a></td>"
	end if
%>
</TR>
</TABLE>
<FORM method=post action="psdb-bugs-update-view.asp" name=frmHid>
<INPUT type=hidden name=lShowNextTen>
<INPUT type=hidden name=lShowPage>

<INPUT type=hidden name=hModule value="<%=lmodule1%>">
<INPUT type=hidden name=hStatus value="<%=lstatus1%>">
<INPUT type=hidden name=hPriority value="<%=lpriority1%>">
<INPUT type=hidden name=hSeverity value="<%=lseverity1%>">
<INPUT type=hidden name=hRepBy value="<%=lrepby1%>">
<INPUT type=hidden name=hResp value="<%=lresp1%>">
<INPUT type=hidden name=hFixedBy value="<%=lfixedby1%>">
<INPUT type=hidden name=hVerBy value="<%=lverby1%>">

<INPUT type=hidden name=hStartDate value="<%=lStartDate%>">
<INPUT type=hidden name=hEndDate value="<%=lEndDate%>">

<INPUT type="hidden" name="hIdentifier1" value="<%=lIdentifier%>">
<INPUT type="hidden" name="hShortDescription1" value="<%=lShortDescription%>">
<INPUT type="hidden" name="hReportedBy1" value="<%=lReportedBy%>">
<INPUT type="hidden" name="hReportedDate1" value="<%=lReportedDate%>">
<INPUT type="hidden" name="hStatus1" value="<%=lStatus%>">
<INPUT type="hidden" name="hModule1" value="<%=lModule%>">
<INPUT type="hidden" name="hPriority1" value="<%=lPriority%>">
<INPUT type="hidden" name="hSeverity1" value="<%=lSeverity%>">
<INPUT type="hidden" name="hResponsibility1" value="<%=lResponsibility%>">
<INPUT type="hidden" name="hEstimatedTime1" value="<%=lEstimatedTime%>">
<INPUT type="hidden" name="hFixedBy1" value="<%=lFixedBy%>">
<INPUT type="hidden" name="hFixedDate1" value="<%=lFixedDate%>">
<INPUT type="hidden" name="hVerifiedBy1" value="<%=lVerifiedBy%>">
<INPUT type="hidden" name="hVerifiedDate1" value="<%=lVerifiedDate%>">
</FORM>
</BODY>
</HTML>
