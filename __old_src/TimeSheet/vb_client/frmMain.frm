VERSION 5.00
Begin VB.Form frmMain 
   BackColor       =   &H8000000A&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Enter Hours worked for Today"
   ClientHeight    =   3420
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3975
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3420
   ScaleWidth      =   3975
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton bCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2040
      TabIndex        =   12
      Top             =   2880
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0E0FF&
      Height          =   975
      Left            =   120
      TabIndex        =   7
      Top             =   120
      Width           =   3735
      Begin VB.Label Label4 
         BackColor       =   &H00C0E0FF&
         BackStyle       =   0  'Transparent
         Caption         =   "Real Time"
         Height          =   255
         Left            =   840
         TabIndex        =   11
         Top             =   600
         Width           =   2775
      End
      Begin VB.Label Label3 
         BackColor       =   &H00C0E0FF&
         Caption         =   "Date"
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
         Left            =   120
         TabIndex        =   10
         Top             =   600
         Width           =   615
      End
      Begin VB.Label Label2 
         BackColor       =   &H00C0E0FF&
         Caption         =   "Real Name"
         Height          =   255
         Left            =   840
         TabIndex        =   9
         Top             =   240
         Width           =   2775
      End
      Begin VB.Label Label1 
         BackColor       =   &H00C0E0FF&
         Caption         =   "Name"
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
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.CommandButton bSubmit 
      Caption         =   "Submit Hours"
      Height          =   375
      Left            =   720
      TabIndex        =   6
      Top             =   2880
      Width           =   1215
   End
   Begin VB.ComboBox cbProject 
      Height          =   315
      Left            =   120
      TabIndex        =   3
      Text            =   "Combo1"
      Top             =   1440
      Width           =   3735
   End
   Begin VB.TextBox ebHours 
      Height          =   375
      Left            =   720
      TabIndex        =   1
      Top             =   2400
      Width           =   975
   End
   Begin VB.ComboBox cbCode 
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Text            =   "Combo1"
      Top             =   2040
      Width           =   3735
   End
   Begin VB.Label lbCode 
      Caption         =   "Code"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1800
      Width           =   1215
   End
   Begin VB.Label lbProject 
      Caption         =   "Project"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   1200
      Width           =   1095
   End
   Begin VB.Label lbHours 
      Caption         =   "Hours"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   2520
      Width           =   735
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
