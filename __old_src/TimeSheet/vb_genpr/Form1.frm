VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   1800
      TabIndex        =   0
      Top             =   1320
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    Dim lCreated As Boolean
    
    lCreated = GenPRForUser("c:\Ramesh.doc", 718, 2, "01/07/02")
    MsgBox lCreated
End Sub

Public Function GenPRForUser(ByVal piFileName As String, ByVal piEmpID As Integer, ByVal piProjectID As Integer, ByVal piDate As Date) As Boolean
On Error GoTo GenPRForUser_Err
    Dim lobjTS As TimeSheet.clsTimeSheet
    Dim lRs As ADODB.Recordset
    Dim lSql As String
    Dim lobjWdApp As Word.Application
    Dim lobjWdDoc As Word.Document
    Dim lProjectName As String
    Dim lEmpName As String
    Dim lSunDate As Date
    
    Set lobjTS = CreateObject("TimeSheet.clsTimeSheet")
    Set lobjWdApp = CreateObject("Word.Application")
    Set lRs = CreateObject("ADODB.RecordSet")
    
    ' get project name
    lProjectName = lobjTS.GetProjectName(piProjectID)
    
    ' get employee name
    Set lRs = lobjTS.GetUserProfile(piEmpID)
    lEmpName = Trim(lRs("U_Name"))
    
    ' get sun date
    lSunDate = piDate + 6
    
    ' create an empty doc
    lobjWdApp.Documents.Add DocumentType:=wdNewBlankDocument
    
    ' Heading
    lobjWdApp.Selection.Font.Size = 18
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.TypeText Text:="Progress Report Form"

    lobjWdApp.Selection.Font.Size = 10
    lobjWdApp.Selection.Font.Bold = False

    ' The first table
    lobjWdApp.ActiveDocument.Tables.Add Range:=lobjWdApp.Selection.Range, NumRows:=5, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(1).Split 1, 4
    
    ' First row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(1).Width = 70
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Project"

    ' Fisrt row second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(2).Width = 160
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:=lProjectName
    
    ' Fisrt row third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(3).Width = 70
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Name"
    
    ' Fisrt row fourth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(4).Width = 160
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:=lEmpName
    
    ' 1st row borders
    With lobjWdApp.ActiveDocument.Tables(1).Rows(1)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' 2 row
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(1).Split 1, 4
    
    ' First row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(1).Width = 70
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="From Date"

    ' 2 row second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(2).Width = 160
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:=piDate
    
    ' 2 row third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(3).Width = 70
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="To Date"
    
    ' 2 row fourth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(4).Width = 160
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:=lSunDate

    ' second row borders
    With lobjWdApp.ActiveDocument.Tables(1).Rows(2)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With
    
    ' Third row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 1: Achievements"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' third row borders
    With lobjWdApp.ActiveDocument.Tables(1).Rows(3)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(1).Split 1, 5
    
    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(1).Width = 200
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Task Description"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(2).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base Start"
    
    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(3).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base End"
    
    ' 4th row fourth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(4).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Actual Start"
    
    ' 4th row fifth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(5).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(5).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Actual End"
    
    ' 4th row borders
    With lobjWdApp.ActiveDocument.Tables(1).Rows(4)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' 5th row
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(1).Split 1, 5
    
    ' 5th row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(1).Width = 200

    ' 5th row second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(2).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"
    
    ' 5th row third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(3).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"
    
    ' 5th row fourth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(4).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"
    
    ' 5th row fifth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(5).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(5).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"
    
    ' dynamically generated rows
    Dim lRowCount As Integer
    
    lRowCount = 5
    lobjWdApp.Selection.Font.Bold = False
    
    Set lRs = lobjTS.GetPRSectionDates(piEmpID, piProjectID, piDate)
    If lRs.RecordCount > 0 Then
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 1 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(1).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseStartDate"))
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseEndDate"))
                
                ' nth row fourth col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(4).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActStartDate"))
                
                ' nth row fifth col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(5).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActEndDate"))
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph

    Dim MyRange As Word.Range
    Dim lCount As Integer
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=3, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed

    ' 1st row, first col
    lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 2: Tasks in progress"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent

'    ' third row borders
    With lobjWdApp.ActiveDocument.Tables(2).Rows(1)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(1).Split 1, 5

    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(1).Width = 200

    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Task Description"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(2).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base Start"

    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(3).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base End"

    ' 4th row fourth col
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(4).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
   lobjWdApp.Selection.TypeText Text:="Actual Start"

   ' 4th row fifth col
   lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(5).Width = 65

   lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(5).Select
   lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
   lobjWdApp.Selection.Font.Bold = True
   lobjWdApp.Selection.TypeText Text:="Actual End"

   ' 4th row borders
   With lobjWdApp.ActiveDocument.Tables(2).Rows(2)
       With .Borders(wdBorderLeft)
           .LineStyle = wdLineStyleSingle
           .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' 5th Row
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(1).Split 1, 5

    ' 5th row, first col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(1).Width = 200 ''

    ' 5th row second col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(2).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row third col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(3).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row fourth col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(4).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row fifth col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(5).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(5).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    lobjWdApp.Selection.Font.Bold = False
    
    lRowCount = 3
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 2 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(2).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseStartDate"))
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseEndDate"))
                
                ' nth row fourth col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(4).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActStartDate"))
                
                ' nth row fifth col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(5).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActEndDate"))
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=3, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    
    lobjWdApp.ActiveDocument.Tables(3).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(3).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 3: Objectives For Next Two Reporting Periods"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent

'    ' third row borders
    With lobjWdApp.ActiveDocument.Tables(3).Rows(1)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With
    
    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(1).Split 1, 5

    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(1).Width = 200

    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Task Description"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(2).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base Start"

    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(3).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base End"

    ' 4th row fourth col
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(4).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
   lobjWdApp.Selection.TypeText Text:="Actual Start"

   ' 4th row fifth col
   lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(5).Width = 65

   lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(5).Select
   lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
   lobjWdApp.Selection.Font.Bold = True
   lobjWdApp.Selection.TypeText Text:="Actual End"

   ' 4th row borders
   With lobjWdApp.ActiveDocument.Tables(3).Rows(2)
       With .Borders(wdBorderLeft)
           .LineStyle = wdLineStyleSingle
           .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' 5th Row
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(1).Split 1, 5

    ' 5th row, first col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(1).Width = 200

    ' 5th row second col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(2).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row third col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(3).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row fourth col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(4).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row fifth col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(5).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(5).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    lobjWdApp.Selection.Font.Bold = False
    
    lRowCount = 3
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 3 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(3).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseStartDate"))
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseEndDate"))
                
                ' nth row fourth col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(4).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActStartDate"))
                
                ' nth row fifth col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(5).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActEndDate"))
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=2, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    
    With lobjWdApp.ActiveDocument.Tables(4)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderRight)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderTop)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderBottom)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
     End With
    
    lobjWdApp.ActiveDocument.Tables(4).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(4).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 4: Quality Assurance Issues"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(1).Split 1, 3

    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(1).Width = 195

    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Issues"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(2).Width = 70

    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Status"

    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(3).Width = 195

    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Remarks"

    lobjWdApp.Selection.Font.Bold = False
    
    lRowCount = 2
    Set lRs = lobjTS.GetPRSection45(piEmpID, piProjectID, piDate)
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 4 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(4).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(4).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_SectionTask"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(4).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskStatus"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(4).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskRemarks"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=2, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    
    With lobjWdApp.ActiveDocument.Tables(5)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderRight)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderTop)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderBottom)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
     End With

    lobjWdApp.ActiveDocument.Tables(5).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(5).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 5: Process Improvements"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent

    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(1).Split 1, 3

    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(1).Width = 195

    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Improvements identified for implementation"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(2).Width = 70

    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Status"

    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(3).Width = 195

    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Remarks"
    
    lobjWdApp.Selection.Font.Bold = False
    
    lRowCount = 2
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 5 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(5).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(5).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_SectionTask"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(5).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskStatus"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(5).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskRemarks"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=2, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    
    With lobjWdApp.ActiveDocument.Tables(6)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderRight)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderTop)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderBottom)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
     End With

    lobjWdApp.ActiveDocument.Tables(6).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(6).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 6: Notes"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    lobjWdApp.ActiveDocument.Tables(6).Rows(2).Cells(1).Width = 460
    
    lobjWdApp.Selection.MoveDown wdParagraph, 1, wdMove
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    
    Dim lNoteCount As Integer
    lNoteCount = 0
    Set lRs = lobjTS.GetPRSectionNotes(piEmpID, piProjectID, piDate)
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
              
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 6 Then
                lNoteCount = lNoteCount + 1
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=CStr(lNoteCount) & ". " & Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.TypeParagraph
            End If
            lRs.MoveNext
        Wend
    End If
    
    ' Red flags
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Red Flags"
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeParagraph
    
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
              
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 7 Then
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=". " & Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.TypeParagraph
            End If
            lRs.MoveNext
        Wend
    Else
        lobjWdApp.Selection.Font.Bold = False
        lobjWdApp.Selection.TypeText Text:=". "
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.TypeParagraph
    End If
    
    ' save the document
    'lobjWdApp.ActiveDocument.SaveAs FileName:=piFileName

    lobjWdApp.Visible = True
    
    GenPRForUser = True
    GoTo GenPRForUser_Exit
    
GenPRForUser_Err:
    GenPRForUser = False
    GoTo GenPRForUser_Exit
GenPRForUser_Exit:
    Set lobjTS = Nothing
    Set lobjWdApp = Nothing
    Set lRs = Nothing
End Function


