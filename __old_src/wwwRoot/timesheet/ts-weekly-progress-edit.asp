<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<LINK rel="stylesheet" href="theme.css">
<%  ' Check if the user is logged in
	Dim lEmpID
	
	lEmpID = Request.Cookies("EmployeeID")
	if lEmpID = "" Then
		Response.Redirect("ts-logon-start.asp")
	end if
%>
<% ' Global varables
	Dim gSect1RowCount
	Dim gSect2RowCount
	Dim gSect3RowCount
	Dim gSect4RowCount
	Dim gSect5RowCount
	Dim gSect6NotesRowCount
	Dim gSect6FlagsRowCount

	Dim gSect1OrgCount
	Dim gSect2OrgRowCount
	Dim gSect3OrgRowCount
	Dim gSect4OrgRowCount
	Dim gSect5OrgRowCount
	Dim gSect6NotesOrgRowCount
	Dim gSect6FlagsOrgRowCount

	Dim gTSObj
	Dim gMonDate
	
	' Section arrays
	Dim lSect1TaskDesc()
	Dim lSect1TaskBaseStart()
	Dim lSect1TaskBaseEnd()
	Dim lSect1TaskActStart()
	Dim lSect1TaskActEnd()
	
	Dim lSect2TaskDesc()
	Dim lSect2TaskBaseStart()
	Dim lSect2TaskBaseEnd()
	Dim lSect2TaskActStart()
	Dim lSect2TaskActEnd()

	Dim lSect3TaskDesc()
	Dim lSect3TaskBaseStart()
	Dim lSect3TaskBaseEnd()
	Dim lSect3TaskActStart()
	Dim lSect3TaskActEnd()
	
	Dim lSect4Issue()
	Dim lSect4IssueStatus()
	Dim lSect4IssueRemarks()
	
	Dim lSect5Issue()
	Dim lSect5IssueStatus()
	Dim lSect5IssueRemarks()

	Dim lSect6Notes()
	Dim lSect6Flags()

	' Original arrays
	Dim lSect1OrgTaskDesc()
	Dim lSect2OrgTaskDesc()
	Dim lSect3OrgTaskDesc()
	Dim lSect4OrgIssue()
	Dim lSect5OrgIssue()
	Dim lSect6OrgNotes()
	Dim lSect6OrgFlags()

	' Intialisations
	gSect1RowCount = Request.Form("hSect1RowCount")
	gSect2RowCount = Request.Form("hSect2RowCount")
	gSect3RowCount = Request.Form("hSect3RowCount")
	gSect4RowCount = Request.Form("hSect4RowCount")
	gSect5RowCount = Request.Form("hSect5RowCount")
	gSect6NotesRowCount = Request.Form("hSect6NotesRowCount")
	gSect6FlagsRowCount = Request.Form("hSect6FlagsRowCount")	

	gSect1OrgRowCount = Request.Form("hOriginalSect1RowCount")
	if gSect1OrgRowCount = "" Then
		gSect1OrgRowCount = 0
	end if
	gSect2OrgRowCount = Request.Form("hOriginalSect2RowCount")
	if gSect2OrgRowCount = "" Then
		gSect2OrgRowCount = 0
	end if
	gSect3OrgRowCount = Request.Form("hOriginalSect3RowCount")
	if gSect3OrgRowCount = "" Then
		gSect3OrgRowCount = 0
	end if
	gSect4OrgRowCount = Request.Form("hOriginalSect4RowCount")
	if gSect4OrgRowCount = "" Then
		gSect4OrgRowCount = 0
	end if
	gSect5OrgRowCount = Request.Form("hOriginalSect5RowCount")
	if gSect5OrgRowCount = "" Then
		gSect5OrgRowCount = 0
	end if
	gSect6NotesOrgRowCount = Request.Form("hOriginalSect6NotesRowCount")
	if gSect6NotesOrgRowCount = "" Then
		gSect6NotesOrgRowCount = 0
	end if
	gSect6FlagsOrgRowCount = Request.Form("hOriginalSect6FlagsRowCount")	
	if gSect6FlagsOrgRowCount = "" Then
		gSect6FlagsOrgRowCount = 0
	end if

	gMonDate = Request.Form("hMonDate")
	Set gTSObj = Server.CreateObject ("TimeSheet.clsTimesheet")
%>
</HEAD>
<BODY topmargin="0" marginwidth="0" marginheight="0" leftmargin="0">
<!-- #include file="ts-header.htm" -->
<script language="javascript">
document.all.oDivPR.style.background = "lightblue";
</script>
<BR>
<%
	Dim lProjectID
	
	lProjectID = Request.Form("hProjectID")
%>
<% 
	Dim lIdx
	Dim lSect1Updated
	Dim lSect2Updated
	Dim lSect3Updated
	Dim lSect4Updated
	Dim lSect5Updated
	Dim lSect6NotesUpdated
	Dim lSect6FlagsUpdated
	
	' Redefine the size of arrays
	ReDim lSect1TaskDesc(gSect1RowCount)
	ReDim lSect1TaskBaseStart(gSect1RowCount)
	ReDim lSect1TaskBaseEnd(gSect1RowCount)
	ReDim lSect1TaskActStart(gSect1RowCount)
	ReDim lSect1TaskActEnd(gSect1RowCount)
	
	ReDim lSect2TaskDesc(gSect2RowCount)
	ReDim lSect2TaskBaseStart(gSect2RowCount)
	ReDim lSect2TaskBaseEnd(gSect2RowCount)
	ReDim lSect2TaskActStart(gSect2RowCount)
	ReDim lSect2TaskActEnd(gSect2RowCount)

	ReDim lSect3TaskDesc(gSect3RowCount)
	ReDim lSect3TaskBaseStart(gSect3RowCount)
	ReDim lSect3TaskBaseEnd(gSect3RowCount)
	ReDim lSect3TaskActStart(gSect3RowCount)
	ReDim lSect3TaskActEnd(gSect3RowCount)
	
	ReDim lSect4Issue(gSect4RowCount)
	ReDim lSect4IssueStatus(gSect4RowCount)
	ReDim lSect4IssueRemarks(gSect4RowCount)
	
	ReDim lSect5Issue(gSect5RowCount)
	ReDim lSect5IssueStatus(gSect5RowCount)
	ReDim lSect5IssueRemarks(gSect5RowCount)

	ReDim lSect6Notes(gSect6NotesRowCount)
	ReDim lSect6Flags(gSect6FlagsRowCount)
	
	ReDim lSect1OrgTaskDesc(gSect1OrgRowCount)
	ReDim lSect2OrgTaskDesc(gSect2OrgRowCount)
	ReDim lSect3OrgTaskDesc(gSect3OrgRowCount)
	ReDim lSect4OrgIssue(gSect4OrgRowCount)
	ReDim lSect5OrgIssue(gSect5OrgRowCount)
	ReDim lSect6OrgNotes(gSect6NotesOrgRowCount)
	ReDim lSect6OrgFlags(gSect6FlagsOrgRowCount)

	' Get the original values
	for lIdx = 0 to gSect1OrgRowCount
		lSect1OrgTaskDesc(lIdx) = Request.Form("hSect1Task" & lIdx)
	next
	
	for lIdx = 0 to gSect2OrgRowCount
		lSect2OrgTaskDesc(lIdx) = Request.Form("hSect2Task" & lIdx)
	next

	for lIdx = 0 to gSect3OrgRowCount
		lSect3OrgTaskDesc(lIdx) = Request.Form("hSect3Task" & lIdx)
	next

	for lIdx = 0 to gSect4OrgRowCount
		lSect4OrgIssue(lIdx) = Request.Form("hSect4Task" & lIdx)
	next

	for lIdx = 0 to gSect5OrgRowCount
		lSect5OrgIssue(lIdx) = Request.Form("hSect5Task" & lIdx)
	next

	for lIdx = 0 to gSect6NotesOrgRowCount
		lSect6OrgNotes(lIdx) = Request.Form("hSect6NotesTask" & lIdx)
	next

	for lIdx = 0 to gSect6FlagsOrgRowCount
		lSect6OrgFlags(lIdx) = Request.Form("hSect6FlagsTask" & lIdx)
	next

	' Get the values from the forms into the arrays
	for lIdx = 1 to gSect1RowCount
		lSect1TaskDesc(lIdx) = Request.Form("ebSect1TaskDesc" & lIdx)
		lSect1TaskBaseStart(lIdx) = Request.Form("ebSect1TaskBaseStart" & lIdx)
		lSect1TaskBaseEnd(lIdx) = Request.Form("ebSect1TaskBaseEnd" & lIdx)
		lSect1TaskActStart(lIdx) = Request.Form("ebSect1TaskActStart" & lIdx)
		lSect1TaskActEnd(lIdx) = Request.Form("ebSect1TaskActEnd" & lIdx)
	
		if (lSect1TaskDesc(lIdx) = "Enter Task") Then
			lSect1TaskDesc(lIdx) = "" 
		end if
		
		if lIdx <= eval(gSect1OrgRowCount) Then
			lSect1Updated = gTSObj.UpdateWPRSectDates( 1, eval(lEmpID), eval(lProjectID), gMonDate, lSect1TaskDesc(lIdx), lSect1TaskBaseStart(lIdx), lSect1TaskBaseEnd(lIdx), lSect1TaskActStart(lIdx), lSect1TaskActEnd(lIdx), lSect1OrgTaskDesc(lIdx))
		else
			lSect1Updated = gTSObj.UpdateWPRSectDates( 1, eval(lEmpID), eval(lProjectID), gMonDate, lSect1TaskDesc(lIdx), lSect1TaskBaseStart(lIdx), lSect1TaskBaseEnd(lIdx), lSect1TaskActStart(lIdx), lSect1TaskActEnd(lIdx), "")			
		end if
		
		if not lSect1Updated Then
			exit for
		end if
	next
	
	for lIdx = 1 to gSect2RowCount
		lSect2TaskDesc(lIdx) = Request.Form("ebSect2TaskDesc" & lIdx)
		lSect2TaskBaseStart(lIdx) = Request.Form("ebSect2TaskBaseStart" & lIdx)
		lSect2TaskBaseEnd(lIdx) = Request.Form("ebSect2TaskBaseEnd" & lIdx)
		lSect2TaskActStart(lIdx) = Request.Form("ebSect2TaskActStart" & lIdx)
		lSect2TaskActEnd(lIdx) = Request.Form("ebSect2TaskActEnd" & lIdx)

		if (lSect2TaskDesc(lIdx) = "Enter Task") Then
			lSect2TaskDesc(lIdx) = "" 
		end if

		if lIdx <= eval(gSect2OrgRowCount) Then
			lSect2Updated = gTSObj.UpdateWPRSectDates( 2, eval(lEmpID), eval(lProjectID), gMonDate, lSect2TaskDesc(lIdx), lSect2TaskBaseStart(lIdx), lSect2TaskBaseEnd(lIdx), lSect2TaskActStart(lIdx), lSect2TaskActEnd(lIdx), lSect2OrgTaskDesc(lIdx))
		else
			lSect2Updated = gTSObj.UpdateWPRSectDates( 2, eval(lEmpID), eval(lProjectID), gMonDate, lSect2TaskDesc(lIdx), lSect2TaskBaseStart(lIdx), lSect2TaskBaseEnd(lIdx), lSect2TaskActStart(lIdx), lSect2TaskActEnd(lIdx), "")
		end if
		
		if not lSect1Updated Then
			exit for
		end if
	next
	
	for lIdx = 1 to gSect3RowCount		
		lSect3TaskDesc(lIdx) = Request.Form("ebSect3TaskDesc" & lIdx)
		lSect3TaskBaseStart(lIdx) = Request.Form("ebSect3TaskBaseStart" & lIdx)
		lSect3TaskBaseEnd(lIdx) = Request.Form("ebSect3TaskBaseEnd" & lIdx)
		lSect3TaskActStart(lIdx) = Request.Form("ebSect3TaskActStart" & lIdx)
		lSect3TaskActEnd(lIdx) = Request.Form("ebSect3TaskActEnd" & lIdx)

		if (lSect3TaskDesc(lIdx) = "Enter Task") Then
			lSect3TaskDesc(lIdx) = "" 
		end if

		if lIdx <= eval(gSect3OrgRowCount) Then
			lSect3Updated = gTSObj.UpdateWPRSectDates( 3, eval(lEmpID), eval(lProjectID), gMonDate, lSect3TaskDesc(lIdx), lSect3TaskBaseStart(lIdx), lSect3TaskBaseEnd(lIdx), lSect3TaskActStart(lIdx), lSect3TaskActEnd(lIdx), lSect3OrgTaskDesc(lIdx))
		else
			lSect3Updated = gTSObj.UpdateWPRSectDates( 3, eval(lEmpID), eval(lProjectID), gMonDate, lSect3TaskDesc(lIdx), lSect3TaskBaseStart(lIdx), lSect3TaskBaseEnd(lIdx), lSect3TaskActStart(lIdx), lSect3TaskActEnd(lIdx), "")
		end if
		
		if not lSect1Updated Then
			exit for
		end if
	next
	
	for lIdx = 1 to gSect4RowCount		
		lSect4Issue(lIdx) = Request.Form("ebSect4Issue" & lIdx)
		lSect4IssueStatus(lIdx) = Request.Form("sSect4IssueStatus" & lIdx)
		lSect4IssueRemarks(lIdx) = Request.Form("ebSect4IssueRemarks" & lIdx)

		if (lSect4Issue(lIdx) = "Enter Issue") Then
			lSect4Issue(lIdx) = "" 
		end if

		if lIdx <= eval(gSect4OrgRowCount) Then
			lSect4Updated = gTSObj.UpdateWPRSect45 (4, eval(lEmpID), eval(lProjectID), gMonDate, lSect4Issue(lIdx), lSect4IssueStatus(lIdx), lSect4IssueRemarks(lIdx), lSect4OrgIssue(lIdx))
		else
			lSect4Updated = gTSObj.UpdateWPRSect45 (4, eval(lEmpID), eval(lProjectID), gMonDate, lSect4Issue(lIdx), lSect4IssueStatus(lIdx), lSect4IssueRemarks(lIdx), "")
		end if

		if not lSect4Updated Then
			exit for
		end if
	next
	
	for lIdx = 1 to gSect5RowCount		
		lSect5Issue(lIdx) = Request.Form("ebSect5Issue" & lIdx)
		lSect5IssueStatus(lIdx) = Request.Form("sSect5IssueStatus" & lIdx)
		lSect5IssueRemarks(lIdx) = Request.Form("ebSect5IssueRemarks" & lIdx)

		if (lSect5Issue(lIdx) = "Enter Issue") Then
			lSect5Issue(lIdx) = "" 
		end if

		if lIdx <= eval(gSect5OrgRowCount) Then
			lSect5Updated = gTSObj.UpdateWPRSect45 (5, eval(lEmpID), eval(lProjectID), gMonDate, lSect5Issue(lIdx), lSect5IssueStatus(lIdx), lSect5IssueRemarks(lIdx), lSect5OrgIssue(lIdx))
		else
			lSect5Updated = gTSObj.UpdateWPRSect45 (5, eval(lEmpID), eval(lProjectID), gMonDate, lSect5Issue(lIdx), lSect5IssueStatus(lIdx), lSect5IssueRemarks(lIdx), "")
		end if

		if not lSect5Updated Then
			exit for
		end if
	next
	
	for lIdx = 1 to gSect6NotesRowCount		
		lSect6Notes(lIdx) = Request.Form("ebSect6Notes" & lIdx)

		if (lSect6Notes(lIdx) = "Enter Note") Then
			lSect6Notes(lIdx) = "" 
		end if

		if lIdx <= eval(gSect6NotesOrgRowCount) Then
			lSect6NotesUpdated = gTSObj.UpdateWPRSectNotes (6, eval(lEmpID), eval(lProjectID), gMonDate, lSect6Notes(lIdx), lSect6OrgNotes(lIdx))
		else
			lSect6NotesUpdated = gTSObj.UpdateWPRSectNotes (6, eval(lEmpID), eval(lProjectID), gMonDate, lSect6Notes(lIdx), "")
		end if

		if not lSect6NotesUpdated Then
			exit for
		end if
	next
	
	for lIdx = 1 to gSect6FlagsRowCount		
		lSect6Flags(lIdx) = Request.Form("ebSect6Flags" & lIdx)
	
		if (lSect6Flags(lIdx) = "Enter Red Flag") Then
			lSect6Flags(lIdx) = "" 
		end if

		if lIdx <= eval(gSect6FlagsOrgRowCount) Then
			lSect6FlagsUpdated = gTSObj.UpdateWPRSectNotes (7, eval(lEmpID), eval(lProjectID), gMonDate, lSect6Flags(lIdx), lSect6OrgFlags(lIdx))
		else
			lSect6FlagsUpdated = gTSObj.UpdateWPRSectNotes (7, eval(lEmpID), eval(lProjectID), gMonDate, lSect6Flags(lIdx), "")
		end if

		if not lSect6FlagsUpdated Then
			exit for
		end if
	next
	
	Dim lSectString
	lSectString = ""
	
	If Not lSect1Updated Then
		lSectString = "Section 1<BR>"
	end if
	If Not lSect2Updated Then
		lSectString = lSectString & "Section 2<BR>"
	end if
	If Not lSect3Updated Then
		lSectString = lSectString & "Section 3<BR>"
	end if
	If Not lSect4Updated Then
		lSectString = lSectString & "Section 4<BR>"
	end if
	If Not lSect5Updated Then
		lSectString = lSectString & "Section 5<BR>"
	end if
	If Not lSect6NotesUpdated Then
		lSectString = lSectString & "Section 6 Notes<BR>"
	end if
	If Not lSect6FlagsUpdated Then
		lSectString = lSectString & "Section 6 Flags<BR>"
	end if
	
	If lSect1Updated Or lSect2Updated Or lSect3Updated Or lSect4Updated Or lSect5Updated Or lSect6NotesUpdated or lSect6FlagsUpdated Then
%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Successfully Updated Progress Report</font></TD>
		</TR>
		</TABLE>
		<% if lSectString <> "" Then %>
			<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
			<TR>
				<TD align="center">Following sections were not updated.<BR><%=lSectString%></TD>
			</TR>
			</TABLE>	
		<% end if %>		

		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-weekly-progress-start.asp">Click here</A> to go to the Progress Report start page</TD>
		</TR>
		</TABLE>		
	<%else%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Error while updating Progress Report</font></TD>
		</TR>
		</TABLE>
		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center">Following sections were not updated.<BR><%=lSectString%></TD>
		</TR>
		<TR>
			<TD align="center"><A href="ts-weekly-progress-start.asp">Click here</A> to go to the Progress report start page</TD>
		</TR>
		</TABLE>	
<%
	end if

	Set gTSObj = Nothing
%>	
</BODY>
</HTML>
