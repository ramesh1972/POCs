VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4680
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   4680
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command15 
      Caption         =   "Add Users to group"
      Height          =   495
      Left            =   3120
      TabIndex        =   14
      Top             =   2760
      Width           =   1215
   End
   Begin VB.CommandButton Command14 
      Caption         =   "Get group users"
      Height          =   495
      Left            =   1800
      TabIndex        =   13
      Top             =   2760
      Width           =   1215
   End
   Begin VB.CommandButton Command13 
      Caption         =   "Delete Group"
      Height          =   495
      Left            =   240
      TabIndex        =   12
      Top             =   2760
      Width           =   1215
   End
   Begin VB.CommandButton Command12 
      Caption         =   "Update Group"
      Height          =   495
      Left            =   3120
      TabIndex        =   11
      Top             =   2040
      Width           =   1215
   End
   Begin VB.CommandButton Command11 
      Caption         =   "Insert Group"
      Height          =   495
      Left            =   1680
      TabIndex        =   10
      Top             =   2040
      Width           =   1215
   End
   Begin VB.CommandButton Command10 
      Caption         =   "Group Details"
      Height          =   495
      Left            =   240
      TabIndex        =   9
      Top             =   2040
      Width           =   1215
   End
   Begin VB.CommandButton Command9 
      Caption         =   "Update User"
      Height          =   495
      Left            =   3120
      TabIndex        =   8
      Top             =   1440
      Width           =   1215
   End
   Begin VB.CommandButton Command8 
      Caption         =   "User Details"
      Height          =   495
      Left            =   1680
      TabIndex        =   7
      Top             =   1440
      Width           =   1215
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Register"
      Height          =   495
      Left            =   240
      TabIndex        =   6
      Top             =   1440
      Width           =   1215
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Gen User TS"
      Height          =   495
      Left            =   1680
      TabIndex        =   5
      Top             =   840
      Width           =   1215
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Login"
      Height          =   495
      Left            =   3120
      TabIndex        =   4
      Top             =   840
      Width           =   1215
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Check TS"
      Height          =   495
      Left            =   240
      TabIndex        =   3
      Top             =   840
      Width           =   1215
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Update"
      Height          =   495
      Left            =   3120
      TabIndex        =   2
      Top             =   240
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "View"
      Height          =   495
      Left            =   1680
      TabIndex        =   1
      Top             =   240
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "INsert"
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Dim lDate As Date
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean

lDate = CDate("11/3/2001")

lresp = lObj.InsertWTSDay(1, CDate("12/20/2001"), "BOOE", "Implementation", 1, 2, 3, 4, 5, 6, 7)
MsgBox lresp
Set lObj = Nothing
End Sub

Private Sub Command10_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lrs As ADODB.Recordset

Set lrs = CreateObject("ADODB.Recordset")
Set lrs = lObj.GetGroupDetails("RamGroup")
While Not lrs.EOF
    MsgBox lrs("G_GroupID")
    lrs.MoveNext
Wend

End Sub

Private Sub Command11_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean

lresp = lObj.InsertGroup("TestGroup", "TOday the weather is horrible", 1)
MsgBox lresp

End Sub

Private Sub Command12_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean

lresp = lObj.UpdateGroupProfile(1, "ChangedName", "Changed description", 5)
MsgBox lresp

End Sub

Private Sub Command13_Click()
Dim lObj As New TimeSheet.clsTimeSheet
lresp = lObj.DeleteGroup(4)
MsgBox lresp
End Sub
 
Private Sub Command14_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lrs As ADODB.Recordset

Set lrs = CreateObject("ADODB.Recordset")
Set lrs = lObj.GetGroupUsers(2)
While Not lrs.EOF
    MsgBox lrs("U_Employee_ID")
    lrs.MoveNext
Wend
End Sub

Private Sub Command15_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean

lresp = lObj.InsertGroupUsers(2, "6,3")
MsgBox lresp

End Sub

Private Sub Command2_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lrs As ADODB.Recordset

Set lrs = CreateObject("ADODB.Recordset")
Set lrs = lObj.GetTS(1, CDate("07/09/2001"))
While Not lrs.EOF
    MsgBox lrs("P_ProjectName")
    MsgBox lrs("AC_Description")
    MsgBox lrs("WTS_StartDate")
    MsgBox lrs("WTS_MonHrs")
    lrs.MoveNext
Wend
End Sub

Private Sub Command3_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean

lresp = lObj.UpdateWTSDay(1, CDate("01/01/2001"), "BOOE", "Design", 25, 12, 13, 14, 15, 16, 17, "Design", "BOOE")
MsgBox lresp
Set lObj = Nothing
End Sub

Private Sub Command4_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean

lresp = lObj.CheckIfTSExists(1, CDate("01/01/2001"))
MsgBox lresp
End Sub

Private Sub Command5_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean
lresp = lObj.CheckIfValidLogin(1, "ramesh")
MsgBox lresp
End Sub

Private Sub Command6_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean
Dim lFileName As String

lFileName = lObj.GetReportsFileName(1, "01/01/01")
lresp = lObj.GenTSForUser("C:\inetpub\wwwroot\timesheet\reports\" & lFileName, 1, "01/01/01")
MsgBox lresp
End Sub

Private Sub Command7_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean

lresp = lObj.RegisterUser(5, "venkat", "venkat")
MsgBox lresp
End Sub

Private Sub Command8_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lrs As ADODB.Recordset

Set lrs = CreateObject("ADODB.Recordset")
Set lrs = lObj.GetUserDetails("Ramesh")
While Not lrs.EOF
    MsgBox lrs("U_Employee_ID")
    lrs.MoveNext
Wend
End Sub

Private Sub Command9_Click()
Dim lObj As New TimeSheet.clsTimeSheet
Dim lresp As Boolean

lresp = lObj.UpdateUserProfile(7, "RameshV", "Y")
MsgBox lresp
End Sub
