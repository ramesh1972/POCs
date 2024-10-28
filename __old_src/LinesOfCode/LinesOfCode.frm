VERSION 5.00
Begin VB.Form frmLinesOfCode 
   Caption         =   "Total Lines Of Code"
   ClientHeight    =   5445
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10035
   LinkTopic       =   "Form1"
   ScaleHeight     =   5445
   ScaleWidth      =   10035
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame1 
      Height          =   5415
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   9855
      Begin VB.CommandButton cmdOpenReport 
         Caption         =   "&Open Report"
         Height          =   375
         Left            =   2760
         TabIndex        =   18
         Top             =   4920
         Visible         =   0   'False
         Width           =   1400
      End
      Begin VB.DirListBox DirName 
         Height          =   1215
         Left            =   240
         TabIndex        =   11
         Top             =   1440
         Width           =   4455
      End
      Begin VB.DriveListBox DrvName 
         Height          =   315
         Left            =   240
         TabIndex        =   10
         Top             =   600
         Width           =   1695
      End
      Begin VB.CommandButton cmdTotals 
         Caption         =   "Calculate"
         Default         =   -1  'True
         Height          =   375
         Left            =   4320
         TabIndex        =   9
         Top             =   4920
         Width           =   1400
      End
      Begin VB.TextBox TxtDestnFile 
         Height          =   405
         Left            =   240
         TabIndex        =   8
         Top             =   3480
         Width           =   4455
      End
      Begin VB.TextBox TxtLoc 
         Height          =   405
         Left            =   240
         TabIndex        =   7
         Top             =   2760
         Width           =   4455
      End
      Begin VB.FileListBox File1 
         Height          =   2430
         Left            =   4800
         TabIndex        =   6
         Top             =   1440
         Width           =   2535
      End
      Begin VB.Frame Frame1 
         Caption         =   "File types to exclude"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2535
         Index           =   1
         Left            =   7440
         TabIndex        =   2
         Top             =   1320
         Width           =   1815
         Begin VB.ListBox lstExclude 
            Height          =   1620
            ItemData        =   "LinesOfCode.frx":0000
            Left            =   120
            List            =   "LinesOfCode.frx":0002
            TabIndex        =   5
            Top             =   840
            Width           =   1575
         End
         Begin VB.CommandButton cmdExclude 
            Caption         =   "ADD"
            Height          =   375
            Left            =   960
            TabIndex        =   4
            Top             =   360
            Width           =   735
         End
         Begin VB.TextBox txtExclude 
            Height          =   405
            Left            =   120
            TabIndex        =   3
            Top             =   360
            Width           =   735
         End
      End
      Begin VB.CommandButton cmdCancel 
         Caption         =   "Ca&ncel"
         Height          =   375
         Left            =   5880
         TabIndex        =   1
         Top             =   4920
         Width           =   1400
      End
      Begin VB.Label lblFilesProcessed 
         AutoSize        =   -1  'True
         Caption         =   "Files:"
         Height          =   195
         Left            =   240
         TabIndex        =   20
         Top             =   4080
         Width           =   360
      End
      Begin VB.Label lblFoldersProcessed 
         AutoSize        =   -1  'True
         Caption         =   "Folders"
         Height          =   195
         Left            =   1200
         TabIndex        =   19
         Top             =   4080
         Width           =   510
      End
      Begin VB.Label Label1 
         Caption         =   "Select the drive"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   17
         Top             =   240
         Width           =   1935
      End
      Begin VB.Label Label1 
         Caption         =   "Select your folder"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   16
         Top             =   1080
         Width           =   1935
      End
      Begin VB.Label Label1 
         Caption         =   "Destination of your report :"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   2
         Left            =   240
         TabIndex        =   15
         Top             =   3240
         Width           =   2895
      End
      Begin VB.Label Label1 
         Caption         =   "Files in the Folder"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   3
         Left            =   4800
         TabIndex        =   14
         Top             =   1080
         Width           =   1935
      End
      Begin VB.Label lblProcessFile 
         Caption         =   "File being processed"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   240
         TabIndex        =   13
         Top             =   4320
         Width           =   9360
      End
      Begin VB.Label lblStatus 
         AutoSize        =   -1  'True
         Caption         =   "Status"
         Height          =   195
         Left            =   240
         TabIndex        =   12
         Top             =   4920
         Width           =   450
      End
   End
End
Attribute VB_Name = "frmLinesOfCode"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

    '*********************************************************************************
    '* Application  :   Quality Related                                              *
    '* Module       :   Check lines of code                                          *
    '* File name    :   frmLinesOfCode.frm                                           *
    '* Purpose      :   To Count the lines of code,comments,blanklines in code       *
    '* Prepared by  :   Roopesh K.P                                                  *
    '* Date         :   19/04/2001                                                   *
    '* Copyright    :   (C) SSI Technologies,India                                   *
    '*                                                                               *
    '*********************************************************************************

    '*********************************************************************************
    '* General Notes                                                                 *
    '* To Produce various types of reports.                                          *
    '*                                                                               *
    '*                                                                               *
    '*********************************************************************************

    '*********************************************************************************
    '* Revision History                                                              *
    '* Version No. Date             By                     Explanation               *
    '*  1          19/04/2001       Roopesh k p            First Baseline            *
    '*                                                                               *
    '*********************************************************************************


Dim strDir As String
Dim objTextstream As TextStream
Dim objFileSys As New FileSystemObject
Dim objTextfile

Dim intOverAllTotal As Long
Dim intOverAllBlanks As Long
Dim intOverAllCom As Long
Dim intOverAllCode As Long
Dim intFilesCount As Long
Dim intFoldersCount As Long
Dim intExclusions As String

Private Sub cmdCancel_Click()
End
End Sub

Private Sub cmdOpenReport_Click()
'to run the shell command
        Dim dblRC As Double
        dblRC = Shell("notepad " & TxtDestnFile.Text, vbNormalFocus)
End Sub

Private Sub cmdTotals_Click()
    Dim intCounter As Integer
    
cmdOpenReport.Visible = False
    
    ' if no directory exists dont proceed
    If strDir <> "" Then
        lblStatus.Caption = "Status: Processing......"
        'collect items from list box and adding it to a string
        intCounter = 0
        While intCounter < lstExclude.ListCount - 1
            intExclusions = intExclusions + lstExclude.List(intCounter) + ":"
            intCounter = intCounter + 1
        Wend
        intExclusions = UCase(intExclusions)
        'creating the file system object
        Set objFileSys = CreateObject("Scripting.FileSystemObject")
        'opening a file for write purpose (the report)
        Set objTextfile = objFileSys.CreateTextFile(TxtDestnFile.Text, True)
        
        objTextfile.WriteBlankLines (2)
        objTextfile.WriteLine "Files in the " & strDir
        objTextfile.WriteLine "~~~~~~~~~~~~"
        objTextfile.WriteBlankLines (2)

        objTextfile.WriteLine " Total Lines = T | Blank Lines = B | Commented = CM | Code Lines= CD"
        objTextfile.WriteLine ("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        'calling the calculate procedure
        intFoldersCount = 1
        intFilesCount = 0
        lblFoldersProcessed = "Folders: " & intFoldersCount
        Calculate strDir
        'Calculate1 strDir
        
        
        If intOverAllTotal > 0 Then
            objTextfile.WriteBlankLines (3)
            objTextfile.WriteLine ("____________________________________")
            objTextfile.WriteLine "Folders Processed: " & intFoldersCount + 1
            objTextfile.WriteLine "Files Processed: " & intFilesCount
            objTextfile.WriteLine ("____________________________________")
            objTextfile.WriteLine "OVER ALL LINES =" & intOverAllTotal
            objTextfile.WriteLine "OVER ALL COMMENTED LINES =" & intOverAllCom
            objTextfile.WriteLine "OVER ALL BLANK LINES =" & intOverAllBlanks
            objTextfile.WriteLine "OVER ALL CODE LINES =" & intOverAllCode
            objTextfile.WriteLine ("____________________________________")
        End If
        
                
        lblStatus.Caption = "Staus: Completed."
        lblProcessFile.Caption = ""
        
        'releasing the resources
        objTextfile.Close
        Set objTextfile = Nothing
        
        cmdOpenReport.Visible = True
    Else
        MsgBox "Pls select the dirve and directory"
    End If
End Sub

Private Sub Calculate(in_StrDir As String)
'Declare variables.
Dim objFolder, objFile, UserFile, objSubfolder, DirInLocation
Dim temp As String
Dim intLineCount As Long
Dim intBlanklines As Long
Dim intComment As Long

Dim intTotalLines As Long
Dim intTotalBlanks As Long
Dim intTotalCom As Long
Dim intTotalCode As Long

Dim strTemp As String
Dim intTmp As Integer
        ' open folder object  and file object
        Set objFolder = objFileSys.GetFolder(in_StrDir)
        Set objFile = objFolder.Files
        
        objTextfile.WriteBlankLines (2)
        ' looping throught the files in the file list
        For Each UserFile In objFile
            intFilesCount = intFilesCount + 1
            lblFilesProcessed.Caption = "Files: " & intFilesCount
            lblProcessFile.Caption = UserFile
            'excluding the files we dont want to check.
            intTmp = InStr(UserFile, ".")
            If intTmp <> 0 Then
               strTemp = Mid(UserFile, InStr(UserFile, "."), Len(UserFile))
            Else
                strTemp = UserFile
            End If
            If InStr(intExclusions, UCase(strTemp) + ":") = 0 Then           'UserFile.Name & ": " & UserFile.Type &
                'intTotalLines = 0
                intBlanklines = 0
                intLineCount = 0
                intComment = 0
                intcodes = 0
                ' opening the a file in the file list for reading
                Set objTextstream = objFileSys.OpenTextFile(UserFile, ForReading)
                ' reading the file and then checking for the comments, blank lines and codes
                Do While Not objTextstream.AtEndOfStream
                  temp = objTextstream.ReadLine
                  CheckForComment temp, intLineCount, intBlanklines, intComment
                  DoEvents
                Loop
                
                intcodes = intLineCount - intBlanklines - intComment
                strTemp = UserFile & " ::- T=" & intLineCount & " : B=" & intBlanklines
                strTemp = strTemp & " : CM=" & intComment & " : CD=" & intcodes
                'writing into the report file
                objTextfile.WriteLine strTemp
                
                'Close the file that was opended for reading.
                objTextstream.Close
                
                intTotalLines = intTotalLines + intLineCount
                intTotalBlanks = intTotalBlanks + intBlanklines
                intTotalCode = intTotalCode + intcodes
                intTotalCom = intTotalCom + intComment
            End If
        Next
        
        If intTotalLines > 0 Then
            objTextfile.WriteBlankLines (3)
            objTextfile.WriteLine "TOTAL LINES =" & intTotalLines
            objTextfile.WriteLine "TOTAL COMMENTED LINES =" & intTotalCom
            objTextfile.WriteLine "TOTAL BLANK LINES =" & intTotalBlanks
            objTextfile.WriteLine "TOTAL CODE LINES =" & intTotalCode
            objTextfile.WriteLine ("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        End If
           
        intOverAllBlanks = intOverAllBlanks + intTotalBlanks
        intOverAllCode = intOverAllCode + intTotalCode
        intOverAllCom = intOverAllCom + intTotalCom
        intOverAllTotal = intOverAllTotal + intTotalLines
        intTotalBlanks = 0
        intTotalCode = 0
        intTotalCom = 0
        
        'checking throught the subfolders in the user root directory.
        Set objSubfolder = objFolder.SubFolders
        For Each DirInLocation In objSubfolder
           intFoldersCount = intFoldersCount + 1
           lblFoldersProcessed = "Folders: " & intFoldersCount
           Calculate (DirInLocation)
        Next
       ' releasing the resources
       Set objFolder = Nothing
       Set objFile = Nothing
       Set objSubfolder = Nothing
End Sub
Private Sub CheckForComment(strString As String, intLineCount As Long, intBlanklines As Long, intComment As Long)
' Checking for Commented lines
    
    If Len(strString) > 1 And strString <> "" Then
        strString = Trim(strString)
        
        If strString = "" Then
            intLineCount = intLineCount + 1
            intBlanklines = intBlanklines + 1
        Exit Sub
        End If
        
        'Checking for the Tab in the begin of line and ommiting it.
        If InStr(1, strString, "'", 1) Or InStr(1, strString, "/*", 1) Then
        Do While Asc(Left(strString, 1)) = 9
            strlen = Len(strString)
            strString = Mid(strString, 2, strlen)
        Loop
        End If
        
        If Left(strString, 1) = "'" Then intComment = intComment + 1
        
        Select Case Left(strString, 2)
            Case "//"
                 intComment = intComment + 1
            Case "/*"
                 intComment = intComment + 1
               Do Until (InStr(1, strString, "*/", 1))
                   If strString = "" Then
                     intBlanklines = intBlanklines + 1
                   Else
                 intComment = intComment + 1
                   End If
                   If Not objTextstream.AtEndOfStream Then
                     strString = objTextstream.ReadLine
                   Else
                     Exit Do
                   End If
                   intLineCount = intLineCount + 1
               Loop
             Case Else
        End Select
        
        'Count the Total lines
        intLineCount = intLineCount + 1
   
   Else
        'Count the blank Lines
        If strString = "" Or strString = " " Then intBlanklines = intBlanklines + 1
        'Count the Total lines
        intLineCount = intLineCount + 1
   End If
End Sub

' Adding items into the exclusion file list
Private Sub cmdExclude_Click()
If Trim(txtExclude.Text) <> "" Then
lstExclude.AddItem txtExclude.Text, lstExclude.ListCount - 1
End If
'Text1.Text = ""
End Sub

'Directory change
Private Sub DirName_Change()
    strDir = DirName.Path
    TxtDestnFile.Text = strDir + "Report.txt"
    If Len(DirName.List(-1)) = 0 Then MsgBox "no items"
    File1.Path = DirName.Path
End Sub

'Directory click
Private Sub DirName_Click()
    strDir = DirName.List(DirName.ListIndex)
    TxtLoc.Text = strDir
    TxtDestnFile.Text = strDir + "Report.txt"
    File1.Path = DirName.Path
End Sub

'Drive Change
Private Sub DrvName_Change()
    If DrvName.Drive = "a:" Then
     MsgBox "Does not check for Floppy Drive"
     Exit Sub
    End If
    DirName.Path = DrvName.Drive
    TxtLoc.Text = DirName.List(-1)
   
End Sub

Private Sub Form_Load()
' adding items into exclusion list

lblStatus.Caption = ""
lblProcessFile.Caption = ""
lblFilesProcessed.Caption = ""
lblFoldersProcessed.Caption = ""

lstExclude.AddItem ".scc", 0
lstExclude.AddItem ".exe", 1
lstExclude.AddItem ".dll", 2
lstExclude.AddItem ".jpg", 3
lstExclude.AddItem ".bmp", 4
lstExclude.AddItem ".doc", 4
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
End
End Sub

Private Sub Form_Unload(Cancel As Integer)
       Set objTextstream = Nothing
       Set objFileSys = Nothing
End Sub


Private Sub Calculate1(in_StrDir As String)

End Sub

