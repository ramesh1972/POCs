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
   Begin VB.CommandButton Command2 
      Caption         =   "Browse"
      Height          =   495
      Left            =   1680
      TabIndex        =   1
      Top             =   1320
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Add"
      Height          =   495
      Left            =   1680
      TabIndex        =   0
      Top             =   600
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Dim lObj As ProtServer.CoNames

Set lObj = CreateObject("ProtServer.CoNames")

Call lObj.AddName("Ramesh", "Viswanathan")
Set lObj = Nothing
End Sub

Private Sub Command2_Click()
Dim lObj As ProtServer.CoNames

Set lObj = CreateObject("ProtServer.CoNames")

MsgBox lObj.BrowseNames

Set lObj = Nothing
End Sub
