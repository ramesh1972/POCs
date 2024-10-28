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
Dim lObj As New MSProjectHTML.MSProjHTML
Dim lHTML() As String

Call lObj.SetProjFile("c:\inetpub\wwwroot\msproj\test\test.mpp")

lHTML = lObj.GetTaskFields
MsgBox UBound(lHTML)
For lIdx = 0 To 10
    MsgBox lHTML(lIdx)
Next
Set lObj = Nothing

End Sub
