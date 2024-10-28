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
	' Row counts
	Dim gSect1RowCount
	Dim gSect2RowCount
	Dim gSect3RowCount
	Dim gSect4RowCount
	Dim gSect5RowCount
	Dim gSect6NotesRowCount
	Dim gSect6FlagsRowCount
	
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
	
	' Intialisations
	gMonDate = Request.Form("hMonDate")
	
	gSect1RowCount = Request.Form("hSect1RowCount")
	gSect2RowCount = Request.Form("hSect2RowCount")
	gSect3RowCount = Request.Form("hSect3RowCount")
	gSect4RowCount = Request.Form("hSect4RowCount")
	gSect5RowCount = Request.Form("hSect5RowCount")
	gSect6NotesRowCount = Request.Form("hSect6NotesRowCount")
	gSect6FlagsRowCount = Request.Form("hSect6FlagsRowCount")	
		
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
	Dim lSect1Inserted
	Dim lSect2Inserted
	Dim lSect3Inserted
	Dim lSect4Inserted
	Dim lSect5Inserted
	Dim lSect6NotesInserted
	Dim lSect6FlagsInserted
	
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
	
	' Get the values from the forms into the arrays
	for lIdx = 1 to gSect1RowCount
		lSect1TaskDesc(lIdx) = Request.Form("ebSect1TaskDesc" & lIdx)
		lSect1TaskBaseStart(lIdx) = Request.Form("ebSect1TaskBaseStart" & lIdx)
		lSect1TaskBaseEnd(lIdx) = Request.Form("ebSect1TaskBaseEnd" & lIdx)
		lSect1TaskActStart(lIdx) = Request.Form("ebSect1TaskActStart" & lIdx)
		lSect1TaskActEnd(lIdx) = Request.Form("ebSect1TaskActEnd" & lIdx)
	
		if Not (lSect1TaskDesc(lIdx) = "Enter Task" Or lSect1TaskDesc(lIdx) = "") Then
			lSect1Inserted = gTSObj.InsertWPRSectDates( 1, eval(lEmpID), eval(lProjectID), gMonDate, lSect1TaskDesc(lIdx), lSect1TaskBaseStart(lIdx), lSect1TaskBaseEnd(lIdx), lSect1TaskActStart(lIdx), lSect1TaskActEnd(lIdx))
			if not lSect1Inserted Then
				exit for
			end if
		end if
	next
	
	for lIdx = 1 to gSect2RowCount
		lSect2TaskDesc(lIdx) = Request.Form("ebSect2TaskDesc" & lIdx)
		lSect2TaskBaseStart(lIdx) = Request.Form("ebSect2TaskBaseStart" & lIdx)
		lSect2TaskBaseEnd(lIdx) = Request.Form("ebSect2TaskBaseEnd" & lIdx)
		lSect2TaskActStart(lIdx) = Request.Form("ebSect2TaskActStart" & lIdx)
		lSect2TaskActEnd(lIdx) = Request.Form("ebSect2TaskActEnd" & lIdx)

		if Not (lSect2TaskDesc(lIdx) = "Enter Task" Or lSect2TaskDesc(lIdx) = "") Then
			lSect2Inserted = gTSObj.InsertWPRSectDates(2, eval(lEmpID), eval(lProjectID), gMonDate, lSect2TaskDesc(lIdx), lSect2TaskBaseStart(lIdx), lSect2TaskBaseEnd(lIdx), lSect2TaskActStart(lIdx), lSect2TaskActEnd(lIdx))
			if not lSect2Inserted Then
				exit for
			end if
		end if
	next
	
	for lIdx = 1 to gSect3RowCount		
		lSect3TaskDesc(lIdx) = Request.Form("ebSect3TaskDesc" & lIdx)
		lSect3TaskBaseStart(lIdx) = Request.Form("ebSect3TaskBaseStart" & lIdx)
		lSect3TaskBaseEnd(lIdx) = Request.Form("ebSect3TaskBaseEnd" & lIdx)
		lSect3TaskActStart(lIdx) = Request.Form("ebSect3TaskActStart" & lIdx)
		lSect3TaskActEnd(lIdx) = Request.Form("ebSect3TaskActEnd" & lIdx)

		if Not (lSect3TaskDesc(lIdx) = "Enter Task" Or lSect3TaskDesc(lIdx) = "") Then
			lSect3Inserted = gTSObj.InsertWPRSectDates (3, eval(lEmpID), eval(lProjectID), gMonDate, lSect3TaskDesc(lIdx), lSect3TaskBaseStart(lIdx), lSect3TaskBaseEnd(lIdx), lSect3TaskActStart(lIdx), lSect3TaskActEnd(lIdx))
			if not lSect3Inserted Then
				exit for
			end if
		end if
	next
	
	for lIdx = 1 to gSect4RowCount		
		lSect4Issue(lIdx) = Request.Form("ebSect4Issue" & lIdx)
		lSect4IssueStatus(lIdx) = Request.Form("sSect4IssueStatus" & lIdx)
		lSect4IssueRemarks(lIdx) = Request.Form("ebSect4IssueRemarks" & lIdx)

		if Not (lSect4Issue(lIdx) = "Enter Issue" Or lSect4Issue(lIdx) = "") Then
			lSect4Inserted = gTSObj.InsertWPRSect45 (4, eval(lEmpID), eval(lProjectID), gMonDate, lSect4Issue(lIdx), lSect4IssueStatus(lIdx), lSect4IssueRemarks(lIdx))
			if not lSect4Inserted Then
				exit for
			end if
		end if
	next
	
	for lIdx = 1 to gSect5RowCount		
		lSect5Issue(lIdx) = Request.Form("ebSect5Issue" & lIdx)
		lSect5IssueStatus(lIdx) = Request.Form("sSect5IssueStatus" & lIdx)
		lSect5IssueRemarks(lIdx) = Request.Form("ebSect5IssueRemarks" & lIdx)

		if Not (lSect5Issue(lIdx) = "Enter Issue" Or lSect5Issue(lIdx) = "") Then
			lSect5Inserted = gTSObj.InsertWPRSect45(5, eval(lEmpID), eval(lProjectID), gMonDate, lSect5Issue(lIdx), lSect5IssueStatus(lIdx), lSect5IssueRemarks(lIdx))
			if not lSect5Inserted Then
				exit for
			end if
		end if
	next
	
	for lIdx = 1 to gSect6NotesRowCount		
		lSect6Notes(lIdx) = Request.Form("ebSect6Notes" & lIdx)

		if Not (lSect6Notes(lIdx) = "Enter Note" Or lSect6Notes(lIdx) = "") Then
			lSect6NotesInserted = gTSObj.InsertWPRNotes(6, eval(lEmpID), eval(lProjectID), gMonDate, lSect6Notes(lIdx))
			if not lSect6NotesInserted Then
				exit for
			end if
		end if
	next
	
	for lIdx = 1 to gSect6FlagsRowCount		
		lSect6Flags(lIdx) = Request.Form("ebSect6Flags" & lIdx)

		if Not (lSect6Flags(lIdx) = "Enter Red Flag" Or lSect6Flags(lIdx) = "") Then
			lSect6FlagsInserted = gTSObj.InsertWPRNotes(7, eval(lEmpID), eval(lProjectID), gMonDate, lSect6Flags(lIdx))
			if not lSect6FlagsInserted Then
				exit for
			end if
		end if
	next
	
	Dim lSectString
	lSectString = ""
	
	If Not lSect1Inserted Then
		lSectString = "Section 1<BR>"
	end if
	If Not lSect2Inserted Then
		lSectString = lSectString & "Section 2<BR>"
	end if
	If Not lSect3Inserted Then
		lSectString = lSectString & "Section 3<BR>"
	end if
	If Not lSect4Inserted Then
		lSectString = lSectString & "Section 4<BR>"
	end if
	If Not lSect5Inserted Then
		lSectString = lSectString & "Section 5<BR>"
	end if
	If Not lSect6NotesInserted Then
		lSectString = lSectString & "Section 6 Notes<BR>"
	end if
	If Not lSect6FlagsInserted Then
		lSectString = lSectString & "Section 6 Flags<BR>"
	end if
	
	If lSect1Inserted Or lSect2Inserted Or lSect3Inserted Or lSect4Inserted Or lSect5Inserted Or lSect6NotesInserted or lSect6FlagsInserted Then
%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Successfully Created The Progress Report</font></TD>
		</TR>
		</TABLE>
		<% if lSectString <> "" Then %>
			<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
			<TR>
				<TD align="center">Following sections were not saved.<BR><%=lSectString%></TD>
			</TR>
			</TABLE>	
		<% end if %>		
		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center"><A href="ts-weekly-progress-start.asp">Click here</A> to go to the Reports start page</TD>
		</TR>
		</TABLE>	
	<%else%>
		<TABLE align="center" width=400 class="tdbgdark" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD><font class="whiteboldtext">Error while creating Progress Report</font></TD>
		</TR>
		</TABLE>
		<TABLE align="center" width=400 border=1 class="tdbglight" STYLE='BORDER-COLLAPSE: collapse'>
		<TR>
			<TD align="center">Following sections were not saved.<BR><%=lSectString%></TD>
		</TR>
		<TR>
			<TD align="center"><A href="ts-weekly-progress-start.asp">Click here</A> to go to the Progress report start page</TD>
		</TR>
		</TABLE>	
	<% end if%>
<%Set gTSObj = Nothing %>	
</BODY>
</HTML>
