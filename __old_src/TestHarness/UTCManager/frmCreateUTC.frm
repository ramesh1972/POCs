VERSION 5.00
Begin VB.Form frmCreateUTC 
   Caption         =   "Create Unit Case Suite"
   ClientHeight    =   4080
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6150
   LinkTopic       =   "Form1"
   ScaleHeight     =   4080
   ScaleWidth      =   6150
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2160
      TabIndex        =   10
      Top             =   3480
      Width           =   975
   End
   Begin VB.CommandButton cmdCreateTestCases 
      Caption         =   "Create Test Cases"
      Height          =   375
      Left            =   240
      TabIndex        =   9
      Top             =   3480
      Width           =   1695
   End
   Begin VB.CommandButton cmdAddFiles 
      Caption         =   "Add to List"
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   1200
      Width           =   1935
   End
   Begin VB.ListBox lstFileList 
      Height          =   1035
      ItemData        =   "frmCreateUTC.frx":0000
      Left            =   240
      List            =   "frmCreateUTC.frx":0002
      TabIndex        =   7
      Top             =   1560
      Width           =   5415
   End
   Begin VB.TextBox txtSourceFileName 
      Height          =   285
      Left            =   3000
      TabIndex        =   6
      Text            =   "Text1"
      Top             =   840
      Width           =   2655
   End
   Begin VB.TextBox txtTestCaseName 
      Height          =   285
      Left            =   3120
      TabIndex        =   4
      Text            =   "Text1"
      Top             =   2760
      Width           =   2535
   End
   Begin VB.TextBox txtExeName 
      Height          =   285
      Left            =   3000
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   240
      Width           =   2655
   End
   Begin VB.Image cmdBrowseSourceFile 
      Height          =   240
      Left            =   5760
      Picture         =   "frmCreateUTC.frx":0004
      Top             =   840
      Width           =   240
   End
   Begin VB.Label Label4 
      Caption         =   "Enter Program Source Files"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   840
      Width           =   2655
   End
   Begin VB.Label Label3 
      Caption         =   "Enter a Name for the Test Suite"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   2760
      Width           =   2655
   End
   Begin VB.Image cmdBrowseExe 
      Height          =   240
      Left            =   5760
      Picture         =   "frmCreateUTC.frx":0586
      Top             =   240
      Width           =   240
   End
   Begin VB.Label Label2 
      Caption         =   "(Only non-event based exes)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   480
      Width           =   2535
   End
   Begin VB.Label Label1 
      Caption         =   "Enter Program To Be Tested "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   2655
   End
End
Attribute VB_Name = "frmCreateUTC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Image1_Click()

End Sub
