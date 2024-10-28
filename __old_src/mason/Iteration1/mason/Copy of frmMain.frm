VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMain 
   BackColor       =   &H80000004&
   Caption         =   "Project1"
   ClientHeight    =   8175
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   14220
   FillStyle       =   0  'Solid
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   Picture         =   "frmMain.frx":0000
   ScaleHeight     =   8175
   ScaleWidth      =   14220
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox TextBoxDocument 
      Height          =   375
      Left            =   6360
      TabIndex        =   21
      Text            =   "Text1"
      Top             =   600
      Width           =   2655
   End
   Begin VB.ComboBox ComboDocument 
      Height          =   315
      Left            =   6240
      TabIndex        =   20
      Text            =   "Combo1"
      Top             =   600
      Width           =   3015
   End
   Begin VB.TextBox TextBoxProtocol 
      Height          =   285
      Left            =   960
      TabIndex        =   18
      Text            =   "Text1"
      Top             =   600
      Width           =   615
   End
   Begin VB.ComboBox ComboProtocol 
      Height          =   315
      Left            =   840
      TabIndex        =   17
      Text            =   "Combo1"
      Top             =   600
      Width           =   975
   End
   Begin VB.TextBox TextBoxAddress 
      Height          =   285
      Left            =   2520
      TabIndex        =   15
      Text            =   "Text1"
      Top             =   600
      Width           =   2535
   End
   Begin VB.CommandButton ButtonGo 
      Height          =   315
      Left            =   9480
      Picture         =   "frmMain.frx":00EA
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   600
      Width           =   975
   End
   Begin VB.ComboBox ComboAddress 
      Height          =   315
      ItemData        =   "frmMain.frx":192C
      Left            =   2520
      List            =   "frmMain.frx":1939
      Style           =   2  'Dropdown List
      TabIndex        =   13
      Top             =   600
      Width           =   2775
   End
   Begin MSComctlLib.ImageList ImageListMain 
      Left            =   9720
      Top             =   3000
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   22
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":1947
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":1D99
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":29AB
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":2AB5
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":2BBF
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":3011
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":3463
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":3575
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":388F
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":3CE1
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":4133
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":444D
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":489F
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":4A1E
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":4E70
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":51B9
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":560B
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":5925
            Key             =   ""
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":5D77
            Key             =   ""
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":61C9
            Key             =   ""
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":6323
            Key             =   ""
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":6775
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar ToolbarTree 
      Height          =   360
      Left            =   480
      TabIndex        =   11
      Top             =   1080
      Visible         =   0   'False
      Width           =   3375
      _ExtentX        =   5953
      _ExtentY        =   635
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   11
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Hide"
            Object.ToolTipText     =   "Hide Window"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Max"
            Object.ToolTipText     =   "Maximize Window"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Close"
            Object.ToolTipText     =   "Close Window"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   14
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   12
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   7
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.Toolbar ToolbarHWW 
      Height          =   360
      Left            =   6720
      TabIndex        =   9
      Top             =   4320
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   635
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   14
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   13
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   12
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   16
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   9
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   7
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.Toolbar tbToolBar 
      Align           =   1  'Align Top
      Height          =   600
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   14220
      _ExtentX        =   25083
      _ExtentY        =   1058
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageListMain"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   26
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Back"
            Object.ToolTipText     =   "Back"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Forward"
            Object.ToolTipText     =   "Forward"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cut"
            Object.ToolTipText     =   "Cut"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Copy"
            Object.ToolTipText     =   "Copy"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Paste"
            Object.ToolTipText     =   "Paste"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Delete"
            Object.ToolTipText     =   "Delete"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   10
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Properties"
            Object.ToolTipText     =   "Properties"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   12
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   13
         EndProperty
         BeginProperty Button16 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "View Small Icons"
            Object.ToolTipText     =   "View Small Icons"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button17 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "View List"
            Object.ToolTipText     =   "View List"
            ImageIndex      =   15
         EndProperty
         BeginProperty Button18 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button19 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "View Details"
            Object.ToolTipText     =   "View Details"
            ImageIndex      =   16
         EndProperty
         BeginProperty Button20 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   17
         EndProperty
         BeginProperty Button21 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button22 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   18
         EndProperty
         BeginProperty Button23 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   19
         EndProperty
         BeginProperty Button24 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   20
         EndProperty
         BeginProperty Button25 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   21
         EndProperty
         BeginProperty Button26 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   22
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9840
      Top             =   3600
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   16744576
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   16
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":6C78
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":70CA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":751C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":762E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":7A80
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":7ED2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":8324
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":863E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":8A90
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":8FD2
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":9424
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":95BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":96D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":9B22
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":9F74
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmMain.frx":A28E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar ToolbarWWW 
      Height          =   360
      Left            =   6960
      TabIndex        =   6
      Top             =   1080
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   635
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   14
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "MoveLeft"
            Object.ToolTipText     =   "Show Left Tab"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "MoveRight"
            Object.ToolTipText     =   "Show Right Tab"
            ImageIndex      =   15
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   8
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Hide Window"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Max"
            Object.ToolTipText     =   "Maximize Window"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Close"
            Object.ToolTipText     =   "Close Window"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   7
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.TabStrip HWW_Tab 
      Height          =   3135
      Left            =   4200
      TabIndex        =   5
      Top             =   4680
      Width           =   6735
      _ExtentX        =   11880
      _ExtentY        =   5530
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   1
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox picSplitter2 
      BackColor       =   &H00808080&
      BorderStyle     =   0  'None
      FillColor       =   &H00808080&
      FillStyle       =   6  'Cross
      ForeColor       =   &H80000014&
      Height          =   135
      Left            =   4440
      ScaleHeight     =   135
      ScaleWidth      =   5415
      TabIndex        =   4
      Top             =   4080
      Width           =   5415
   End
   Begin MSComctlLib.TabStrip WWW_Tab 
      Height          =   2415
      Left            =   4200
      TabIndex        =   3
      Top             =   1440
      Width           =   6735
      _ExtentX        =   11880
      _ExtentY        =   4260
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   1
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox picSplitter 
      BackColor       =   &H00808080&
      BorderStyle     =   0  'None
      FillColor       =   &H00808080&
      Height          =   4800
      Left            =   3720
      ScaleHeight     =   2090.126
      ScaleMode       =   0  'User
      ScaleWidth      =   780
      TabIndex        =   2
      Top             =   2040
      Visible         =   0   'False
      Width           =   72
   End
   Begin MSComctlLib.TreeView tvTreeView 
      Height          =   6240
      Left            =   0
      TabIndex        =   1
      Top             =   1560
      Width           =   3570
      _ExtentX        =   6297
      _ExtentY        =   11007
      _Version        =   393217
      Style           =   7
      Appearance      =   1
   End
   Begin VB.Label LabelDocument 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000004&
      Caption         =   "Document"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   5370
      TabIndex        =   19
      Top             =   600
      Width           =   765
   End
   Begin VB.Label LabelProtocol 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000004&
      Caption         =   "Protocol"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   105
      TabIndex        =   16
      Top             =   600
      Width           =   600
   End
   Begin VB.Label LabelAddress 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000004&
      Caption         =   "Address"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   1920
      TabIndex        =   12
      Top             =   600
      Width           =   570
   End
   Begin VB.Label LabelTree 
      BackColor       =   &H00FF8080&
      Caption         =   "Label1"
      ForeColor       =   &H80000009&
      Height          =   255
      Left            =   0
      TabIndex        =   10
      Top             =   1200
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Label LabelHWW 
      BackColor       =   &H00FF8080&
      Caption         =   "Label1"
      ForeColor       =   &H80000009&
      Height          =   375
      Left            =   4200
      TabIndex        =   8
      Top             =   4320
      Width           =   3855
   End
   Begin VB.Label LabelWWW 
      BackColor       =   &H00FF8080&
      Caption         =   "Label1"
      ForeColor       =   &H80000009&
      Height          =   375
      Left            =   4200
      TabIndex        =   7
      Top             =   1080
      Width           =   3495
   End
   Begin VB.Image ImgSplitter2 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Height          =   225
      Left            =   4200
      MousePointer    =   7  'Size N S
      Picture         =   "frmMain.frx":A3A0
      Stretch         =   -1  'True
      Top             =   3960
      Width           =   225
   End
   Begin VB.Image imgSplitter 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Height          =   225
      Left            =   3720
      MousePointer    =   9  'Size W E
      Picture         =   "frmMain.frx":A48A
      Stretch         =   -1  'True
      Top             =   1800
      Width           =   225
   End
   Begin VB.Menu mnuMain 
      Caption         =   "&Main"
      Begin VB.Menu mnuLogin 
         Caption         =   "&Login"
      End
      Begin VB.Menu mnuSep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuWWW 
         Caption         =   "&World Wide Web"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuHWW 
         Caption         =   "&Home Wide Web"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuShowLibraryMain 
         Caption         =   "Home &Library"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuSep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuConnect 
         Caption         =   "&Connect"
      End
      Begin VB.Menu mnuDisconnect 
         Caption         =   "&Disconnect"
      End
      Begin VB.Menu mnuConnectionDetails 
         Caption         =   "&Connection Details"
      End
      Begin VB.Menu mnuSep3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSSO 
         Caption         =   "&Single Sign On"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuMSO 
         Caption         =   "&Manual Sign On"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuUserDetails 
         Caption         =   "&User Details"
      End
      Begin VB.Menu mnuUsers 
         Caption         =   "Users"
         Begin VB.Menu mnuViewUsers 
            Caption         =   "&View Users"
         End
         Begin VB.Menu mnuNewUser 
            Caption         =   "&New User"
         End
         Begin VB.Menu mnuEditUser 
            Caption         =   "&Edit User"
         End
         Begin VB.Menu mnuDeleteUser 
            Caption         =   "&Delete User"
         End
      End
      Begin VB.Menu mnu14 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPrintSetup 
         Caption         =   "Print &Setup"
      End
      Begin VB.Menu mnuPrintPreview 
         Caption         =   "Print Pre&view"
      End
      Begin VB.Menu mnuPrint 
         Caption         =   "&Print"
      End
      Begin VB.Menu mnuSep11 
         Caption         =   "-"
      End
      Begin VB.Menu mnuStatus 
         Caption         =   "&Status Window"
         Begin VB.Menu mnuShowAll 
            Caption         =   "Show &All"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuSep9 
            Caption         =   "-"
         End
         Begin VB.Menu mnuUserInformation 
            Caption         =   "&User Information"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuConnectionStatus 
            Caption         =   "&Connection Status"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuProgressBar 
            Caption         =   "&Progress Bar"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuMessages 
            Caption         =   "&Messages"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuTimeInfo 
            Caption         =   "&Time"
            Checked         =   -1  'True
         End
      End
      Begin VB.Menu mnuSep10 
         Caption         =   "-"
      End
      Begin VB.Menu mnuHelp 
         Caption         =   "&Help"
      End
      Begin VB.Menu mnuDynamicHelp 
         Caption         =   "&Dynamic Help"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuSep12 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSetup 
         Caption         =   "Setup"
         Begin VB.Menu mnuUpdates 
            Caption         =   "Updates"
         End
         Begin VB.Menu mnuUpgrade 
            Caption         =   "Upgrade"
         End
         Begin VB.Menu mnuLicense 
            Caption         =   "License"
         End
         Begin VB.Menu mnuUninstall 
            Caption         =   "Uninstall"
         End
         Begin VB.Menu mnuSep36 
            Caption         =   "-"
         End
         Begin VB.Menu mnuSetupHistory 
            Caption         =   "History"
         End
         Begin VB.Menu mnuAbout 
            Caption         =   "About"
         End
      End
      Begin VB.Menu mnuSep35 
         Caption         =   "-"
      End
      Begin VB.Menu mnuLogout 
         Caption         =   "Log&out"
      End
      Begin VB.Menu mnuSep13 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "&Exit Application"
      End
   End
   Begin VB.Menu mnuWorldWeb 
      Caption         =   "&World Web"
      Begin VB.Menu mnuOpenWebPage 
         Caption         =   "Open Web &Page"
      End
      Begin VB.Menu mnuCloseWebPage 
         Caption         =   "&Close Web Page"
      End
      Begin VB.Menu mnuSep25 
         Caption         =   "-"
      End
      Begin VB.Menu mnuStartDesign 
         Caption         =   "Start &Design"
      End
      Begin VB.Menu mnuMoveAllContents 
         Caption         =   "Move &All Contents"
      End
      Begin VB.Menu mnuMoveContents 
         Caption         =   "&Move Selected Contents"
      End
      Begin VB.Menu mnuEndWebDesign 
         Caption         =   "&End Design"
      End
      Begin VB.Menu mnuSep15 
         Caption         =   "-"
      End
      Begin VB.Menu mnuWebTabs 
         Caption         =   "&Tabs"
         Begin VB.Menu mnuNewWebTab 
            Caption         =   "New Tab"
         End
         Begin VB.Menu mnuCloseWebTab 
            Caption         =   "Close Tab"
         End
         Begin VB.Menu mnuSep18 
            Caption         =   "-"
         End
         Begin VB.Menu mnuNextWebTab 
            Caption         =   "&Next Tab"
         End
         Begin VB.Menu mnuPreviousWebTab 
            Caption         =   "&Previous Tab"
         End
         Begin VB.Menu mnuFirstWebTab 
            Caption         =   "&First Tab"
         End
         Begin VB.Menu mnuLastWebTab 
            Caption         =   "&Last Tab"
         End
         Begin VB.Menu mnuSep7 
            Caption         =   "-"
         End
         Begin VB.Menu mnuOpenSiteInNewTab 
            Caption         =   "Open Site In New Tab"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuOpenPageInNewTab 
            Caption         =   "Open Page In New Tab"
            Checked         =   -1  'True
         End
      End
      Begin VB.Menu mnuSep19 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDefaultPage 
         Caption         =   "&Default Page"
      End
      Begin VB.Menu mnuPreviousWebPage 
         Caption         =   "&Previous Page"
      End
      Begin VB.Menu mnuNextWebPage 
         Caption         =   "&Next Page"
      End
      Begin VB.Menu mnuRefreshWebPage 
         Caption         =   "Refresh Page"
      End
      Begin VB.Menu mnuStopWebPage 
         Caption         =   "Stop"
      End
      Begin VB.Menu mnuSep5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSetAsDefaultPage 
         Caption         =   "Set As Default"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuSaveWebSite 
         Caption         =   "Save Web &Site"
      End
      Begin VB.Menu mnuSavePage 
         Caption         =   "&Save Web Page"
      End
      Begin VB.Menu mnuExpandWebPageLinks 
         Caption         =   "Expand Links"
      End
      Begin VB.Menu mnuHistory 
         Caption         =   "&History"
      End
      Begin VB.Menu mnuSep6 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFindOnWebPage 
         Caption         =   "&Find In Open Pages"
      End
      Begin VB.Menu mnuSep20 
         Caption         =   "-"
      End
      Begin VB.Menu mnuWebPageProperties 
         Caption         =   "Page Properties"
      End
   End
   Begin VB.Menu mnuHomeWeb 
      Caption         =   "&Home Web"
      Begin VB.Menu mnuHomeSite 
         Caption         =   "Home Site"
         Begin VB.Menu mnuViewHomeSites 
            Caption         =   "View Home Sites"
         End
         Begin VB.Menu mnuSep38 
            Caption         =   "-"
         End
         Begin VB.Menu mnuNewSite 
            Caption         =   "New &Site"
         End
         Begin VB.Menu mnuOpenSite 
            Caption         =   "&Open Site"
         End
         Begin VB.Menu mnuSaveHomeSite 
            Caption         =   "Save Site"
         End
         Begin VB.Menu mnuCloseHomeSite 
            Caption         =   "Close Site"
         End
         Begin VB.Menu mnuSep46 
            Caption         =   "-"
         End
         Begin VB.Menu mnuRenameSite 
            Caption         =   "Rename Site"
         End
         Begin VB.Menu mnuMoveSite 
            Caption         =   "Move Site"
         End
         Begin VB.Menu mnuDeleteHomeSite 
            Caption         =   "Delete Site"
         End
         Begin VB.Menu mnuSep29 
            Caption         =   "-"
         End
         Begin VB.Menu mnuHomeSiteOptions 
            Caption         =   "Site Options"
         End
         Begin VB.Menu mnuSep51 
            Caption         =   "-"
         End
         Begin VB.Menu mnuSetasDefaultHomeSite 
            Caption         =   "Set As Default"
            Checked         =   -1  'True
         End
      End
      Begin VB.Menu mnuDesignHomeSite 
         Caption         =   "Design Site"
      End
      Begin VB.Menu mnuReloadHomeSite 
         Caption         =   "Reload Site"
      End
      Begin VB.Menu mnuScheduleSiteUpdate 
         Caption         =   "Schedule Site Reload"
      End
      Begin VB.Menu mnuHomeSiteProperties 
         Caption         =   "Site Properties"
      End
      Begin VB.Menu mnuSep24 
         Caption         =   "-"
      End
      Begin VB.Menu mnuHomeSitePages 
         Caption         =   "Site Pages"
         Begin VB.Menu mnuViewHomeSitePages 
            Caption         =   "View Site Pages"
         End
         Begin VB.Menu mnuSep39 
            Caption         =   "-"
         End
         Begin VB.Menu mnuNewPage 
            Caption         =   "New &Page"
         End
         Begin VB.Menu mnuOpenPage 
            Caption         =   "Open &Page"
         End
         Begin VB.Menu mnuSaveHomeSitePage 
            Caption         =   "Save Page"
         End
         Begin VB.Menu mnuCloseHomeSitePage 
            Caption         =   "Close Page"
         End
         Begin VB.Menu mnuSep49 
            Caption         =   "-"
         End
         Begin VB.Menu mnuRenameHomePage 
            Caption         =   "Rename Page"
         End
         Begin VB.Menu mnuMoveHomePage 
            Caption         =   "Move Page"
         End
         Begin VB.Menu mnuDeleteHomeSitePage 
            Caption         =   "Delete Page"
         End
         Begin VB.Menu mnuSep28 
            Caption         =   "-"
         End
         Begin VB.Menu mnuHomePageOptions 
            Caption         =   "Page Options"
         End
         Begin VB.Menu mnuSep50 
            Caption         =   "-"
         End
         Begin VB.Menu mnuSetAsDefaultHomePage 
            Caption         =   "Set As Default"
            Checked         =   -1  'True
         End
      End
      Begin VB.Menu mnuDesignHomeSitePage 
         Caption         =   "Design Page"
      End
      Begin VB.Menu mnuReloadHomeSitePage 
         Caption         =   "Reload Page"
      End
      Begin VB.Menu mnuSchedulePageUpdate 
         Caption         =   "Schedule Page Reload"
      End
      Begin VB.Menu mnuHomeSitePageProperties 
         Caption         =   "Page Properties"
      End
      Begin VB.Menu mnuSep27 
         Caption         =   "-"
      End
      Begin VB.Menu mnuHomeSchedular 
         Caption         =   "Schedular"
      End
      Begin VB.Menu mnuReloadStatus 
         Caption         =   "Reload Status"
      End
      Begin VB.Menu mnuSep45 
         Caption         =   "-"
      End
      Begin VB.Menu mnuHomeTabs 
         Caption         =   "Tabs"
         Begin VB.Menu mnuNewTab 
            Caption         =   "New Tab"
         End
         Begin VB.Menu mnuCloseTab 
            Caption         =   "Close Tab"
         End
         Begin VB.Menu mnuSep16 
            Caption         =   "-"
         End
         Begin VB.Menu mnuHomePreviousTab 
            Caption         =   "Previous Tab"
         End
         Begin VB.Menu mnuHomeNextTab 
            Caption         =   "Next Tab"
         End
         Begin VB.Menu mnuHomeFirstTab 
            Caption         =   "First Tab"
         End
         Begin VB.Menu mnuHomeLastTab 
            Caption         =   "Last Tab"
         End
         Begin VB.Menu mnuSep30 
            Caption         =   "-"
         End
         Begin VB.Menu mnuOpenHomeSiteInNewTab 
            Caption         =   "Open Site In Tab"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuOpenHomePageInTab 
            Caption         =   "Open Page in New Tab"
            Checked         =   -1  'True
         End
      End
      Begin VB.Menu mnuSep31 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDefaultHomeSite 
         Caption         =   "Default Site"
      End
      Begin VB.Menu mnuDefaultHomePage 
         Caption         =   "Default Page"
      End
      Begin VB.Menu mnuPreviousHomePage 
         Caption         =   "Previous Page"
      End
      Begin VB.Menu mnuNextHomePage 
         Caption         =   "Next Page"
      End
      Begin VB.Menu mnuStopHomePageRefresh 
         Caption         =   "Stop"
      End
      Begin VB.Menu mnuSep33 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFindInHomeSites 
         Caption         =   "Find In Site"
      End
      Begin VB.Menu mnuFindInHomePages 
         Caption         =   "Find In Open Pages"
      End
   End
   Begin VB.Menu mnuLibrary 
      Caption         =   "&Library"
      Begin VB.Menu mnuShowLibrary 
         Caption         =   "&Show"
      End
      Begin VB.Menu mnuHideLibrary 
         Caption         =   "&Hide"
      End
      Begin VB.Menu mnuSep41 
         Caption         =   "-"
      End
      Begin VB.Menu mnuLibraryContents 
         Caption         =   "Library Contents"
         Begin VB.Menu mnuViewLibraryContents 
            Caption         =   "View Contents"
         End
         Begin VB.Menu mnuLibraryAdd 
            Caption         =   "Add Content"
         End
         Begin VB.Menu mnuLibraryEdit 
            Caption         =   "Edit Content"
         End
         Begin VB.Menu mnuLibrarySave 
            Caption         =   "Save Content"
         End
         Begin VB.Menu mnuRenameLibraryContent 
            Caption         =   "Rename Content"
         End
         Begin VB.Menu mnuLibraryClose 
            Caption         =   "Close Content"
         End
         Begin VB.Menu mnuLibraryDelete 
            Caption         =   "Delete Content"
         End
         Begin VB.Menu mnuMoveLibraryContent 
            Caption         =   "Move Content"
         End
      End
      Begin VB.Menu mnuSep40 
         Caption         =   "-"
      End
      Begin VB.Menu mnuDesignLibrary 
         Caption         =   "Design Library"
         Begin VB.Menu mnuNewLibraryHomePage 
            Caption         =   "New Home Page"
         End
         Begin VB.Menu mnuEditLibraryHomePage 
            Caption         =   "Edit Home Page"
         End
         Begin VB.Menu mnuSaveLibraryHomePage 
            Caption         =   "Save Home Page"
         End
         Begin VB.Menu mnuCloseLibraryHomePage 
            Caption         =   "Close Home Page"
         End
         Begin VB.Menu mnuDeleteLibraryHomePage 
            Caption         =   "Delete Home Page"
         End
         Begin VB.Menu mnuSep42 
            Caption         =   "-"
         End
         Begin VB.Menu mnuDesignDefaultLibraryHomePage 
            Caption         =   "Default Home Page"
         End
      End
      Begin VB.Menu mnuSep43 
         Caption         =   "-"
      End
      Begin VB.Menu mnuPublishLibrary 
         Caption         =   "Publish Library"
      End
      Begin VB.Menu mnuPublishContent 
         Caption         =   "Publish Content"
      End
      Begin VB.Menu mnuLibraryPublishOptions 
         Caption         =   "Publish Options"
      End
      Begin VB.Menu mnuInternetPublishSites 
         Caption         =   "Internet Publish Sites"
      End
      Begin VB.Menu mnuSchedulePublish 
         Caption         =   "Schedule Publish"
      End
      Begin VB.Menu mnuSep44 
         Caption         =   "-"
      End
      Begin VB.Menu mnuShowLibOptions 
         Caption         =   "&Show Options"
         Begin VB.Menu mnuShowWebSites 
            Caption         =   "Web Sites"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowHomeSites 
            Caption         =   "Home Sites"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowLoginSignatures 
            Caption         =   "Login Signatures"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowEmails 
            Caption         =   "Emails"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowMediaAlbums 
            Caption         =   "Media Albums"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowNewsGroups 
            Caption         =   "News Groups"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowEDocuments 
            Caption         =   "e-Documents"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowDownloadedFiles 
            Caption         =   "Downloaded Files"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowContacts 
            Caption         =   "Contacts"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowChats 
            Caption         =   "Chats"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowCalendarTasks 
            Caption         =   "Calendar Tasks"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowSearches 
            Caption         =   "Searches"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowSchedules 
            Caption         =   "Schedules"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowLocalDrives 
            Caption         =   "Local Drives"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowHistory 
            Caption         =   "History"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowSystemUsers 
            Caption         =   "System Users"
            Checked         =   -1  'True
         End
      End
   End
   Begin VB.Menu mnuEmail 
      Caption         =   "&EMail"
      Begin VB.Menu mnuEmailOpen 
         Caption         =   "&Open"
      End
      Begin VB.Menu mnuEMailClose 
         Caption         =   "&Close"
      End
      Begin VB.Menu mnuSep52 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSendAndReceive 
         Caption         =   "&Send And Receive"
         Begin VB.Menu mnuSendAndReceiveAllMail 
            Caption         =   "&All"
         End
         Begin VB.Menu mnuReceiveAllEmail 
            Caption         =   "&Receive All"
         End
         Begin VB.Menu mnuSendAllEMail 
            Caption         =   "&Send All"
         End
         Begin VB.Menu mnuSep58 
            Caption         =   "-"
         End
         Begin VB.Menu mnuEmailAccount1 
            Caption         =   "Account1"
         End
         Begin VB.Menu mnuEmailAccount2 
            Caption         =   "Account2"
         End
      End
      Begin VB.Menu mnuMailSchedular 
         Caption         =   "Mail Schedular"
      End
      Begin VB.Menu mnuSep55 
         Caption         =   "-"
      End
      Begin VB.Menu mnuWebMail 
         Caption         =   "Web Mail"
         Begin VB.Menu mnuSetAccount 
            Caption         =   "Setup Account"
         End
         Begin VB.Menu mnuSep56 
            Caption         =   "-"
         End
         Begin VB.Menu mnuSetupWebMailAccount1 
            Caption         =   "Setup Account1"
         End
      End
      Begin VB.Menu mnuNetMail 
         Caption         =   "Net Mail"
         Begin VB.Menu mnuSetupNetMailAccount 
            Caption         =   "Setup Account"
         End
         Begin VB.Menu mnuSep57 
            Caption         =   "-"
         End
         Begin VB.Menu mnuSetupMailAccount2 
            Caption         =   "Setup Account1"
         End
      End
      Begin VB.Menu mnuSep59 
         Caption         =   "-"
      End
      Begin VB.Menu mnuEmailOptions 
         Caption         =   "Email Options"
      End
      Begin VB.Menu mnuGroupAllEmailAccounts 
         Caption         =   "Group All Accounts"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuSep60 
         Caption         =   "-"
      End
      Begin VB.Menu mnuEMailSignature 
         Caption         =   "Signature"
      End
   End
   Begin VB.Menu mnuMessenger 
      Caption         =   "&Messenger"
   End
   Begin VB.Menu mnuEDocuments 
      Caption         =   "E&Documents"
   End
   Begin VB.Menu mnuMedia 
      Caption         =   "Me&dia"
   End
   Begin VB.Menu mnuFileTransfer 
      Caption         =   "&File Transfer"
   End
   Begin VB.Menu mnuNewsGroups 
      Caption         =   "&News Groups"
   End
   Begin VB.Menu mnuSearch 
      Caption         =   "&Search"
   End
   Begin VB.Menu mnuCalendar 
      Caption         =   "&Calendar"
   End
   Begin VB.Menu mnuMainOptions 
      Caption         =   "&Options"
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function OSWinHelp% Lib "user32" Alias "WinHelpA" (ByVal hwnd&, ByVal HelpFile$, ByVal wCommand%, dwData As Any)
Dim gBorderWidth As Long
Dim gLabelLeft As Long
Dim gMoving As Boolean
Dim gClientTop As Long
Dim gWebTreeMinWidth As Long
Dim gDocumentComboMinWidth As Long

Private Sub Form_Load()
    Me.Left = GetSetting(App.Title, "Settings", "MainLeft", 1000)
    Me.Top = GetSetting(App.Title, "Settings", "MainTop", 1000)
    Me.Width = GetSetting(App.Title, "Settings", "MainWidth", 6500)
    Me.Height = GetSetting(App.Title, "Settings", "MainHeight", 6500)
    

    HideAllWindows
    SetStandardWindowProperties
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Dim i As Integer

    'close all sub forms
    For i = Forms.Count - 1 To 1 Step -1
        Unload Forms(i)
    Next
    If Me.WindowState <> vbMinimized Then
        SaveSetting App.Title, "Settings", "MainLeft", Me.Left
        SaveSetting App.Title, "Settings", "MainTop", Me.Top
        SaveSetting App.Title, "Settings", "MainWidth", Me.Width
        SaveSetting App.Title, "Settings", "MainHeight", Me.Height
    End If
End Sub


Sub HideAllWindows()
    tvTreeView.Visible = False
    LabelTree.Visible = False
    ToolbarTree.Visible = False
    
    LabelWWW.Visible = False
    ToolbarWWW.Visible = False
    WWW_Tab.Visible = False
    
    LabelHWW.Visible = False
    ToolbarHWW.Visible = False
    HWW_Tab.Visible = False
    
    imgSplitter.Visible = False
    ImgSplitter2.Visible = False
    
    picSplitter.Visible = False
    picSplitter2.Visible = False
End Sub

Sub SetStandardWindowProperties()
    gBorderWidth = 40
    gLabelLeft = 20
    
    If tbToolBar.Visible Then
        ImgSplitter2.Top = (Me.ScaleHeight - tbToolBar.Height) / 2
    Else
        ImgSplitter2.Top = Me.ScaleHeight / 2
    End If
    
    imgSplitter.Width = 100
    ImgSplitter2.Height = 100
    picSplitter.Width = 100
    picSplitter2.Width = 100
    
    picSplitter.BackColor = &H808080
    picSplitter.FillColor = &H808080
    picSplitter.ForeColor = &H80000012
    
    picSplitter2.BackColor = &H808080
    picSplitter2.FillColor = &H808080
    picSplitter2.ForeColor = &H80000012
    
    picSplitter.Visible = False
    picSplitter2.Visible = False
    
    ToolbarTree.Width = 3375
    gWebTreeMinWidth = 4425
    ' 13 15 8 11 9  3 1 2 6 7 5
    ToolbarWWW.Width = 4215
    
    '13 4 12  16 9 3 1 2 6 7 5
    ToolbarHWW.Width = 4215
    
    imgSplitter.Left = gWebTreeMinWidth
    
    gDocumentComboMinWidth = 1000
End Sub

Private Sub SetAddressBar()
    LabelProtocol.Height = 275
    LabelProtocol.Width = 620
    LabelProtocol.Alignment = vbAlignCenter
    
    LabelAddress.Height = 275
    LabelAddress.Width = 570
    LabelAddress.Alignment = vbAlignCenter
    
    LabelDocument.Height = 275
    LabelDocument.Width = 765
    LabelDocument.Alignment = vbAlignCenter
    
    ButtonGo.Height = 315
    ButtonGo.Width = 975
        
    TextBoxProtocol.Height = 295
    TextBoxAddress.Height = 295
    TextBoxDocument.Height = 295
    
    URLLabelLeft = gLabelLeft * 2
    If tbToolBar.Visible Then
        gClientTop = tbToolBar.Height + 335
        
        LabelProtocol.Top = tbToolBar.Height + URLLabelLeft
        LabelAddress.Top = tbToolBar.Height + URLLabelLeft
        LabelDocument.Top = tbToolBar.Height + URLLabelLeft
        
        ComboProtocol.Top = tbToolBar.Height
        TextBoxProtocol.Top = tbToolBar.Height + 20
        
        ComboAddress.Top = tbToolBar.Height
        TextBoxAddress.Top = tbToolBar.Height + 20
        
        ComboDocument.Top = tbToolBar.Height
        TextBoxDocument.Top = tbToolBar.Height + 20
        
        ButtonGo.Top = tbToolBar.Height
    Else
        gClientTop = 335
        
        LabelProtocol.Top = URLLabelLeft
        ComboProtocol.Top = 0
        TextBoxProtocol.Top = 20
        
        LabelAddress.Top = URLLabelLeft
        ComboAddress.Top = 0
        TextBoxAddress.Top = 20
        
        LabelDocument.Top = URLLabelLeft
        ComboDocument.Top = 0
        TextBoxDocument.Top = 20

        ButtonGo.Top = 0
    End If
    
    LabelProtocol.Left = URLLabelLeft
    ComboProtocol.Left = URLLabelLeft + LabelProtocol.Width
    TextBoxProtocol.Left = URLLabelLeft + LabelProtocol.Width
    
    ComboProtocol.Width = 975
    TextBoxProtocol.Width = 690
    
    LabelAddress.Left = ComboProtocol.Left + ComboProtocol.Width + URLLabelLeft
    ComboAddress.Left = LabelAddress.Left + LabelAddress.Width
    TextBoxAddress.Left = LabelAddress.Left + LabelAddress.Width
    
    ComboAddress.Width = 3200
    TextBoxAddress.Width = 2910
    
    LabelDocument.Left = ComboAddress.Left + ComboAddress.Width + URLLabelLeft
    ComboDocument.Left = LabelDocument.Left + LabelDocument.Width
    TextBoxDocument.Left = LabelDocument.Left + LabelDocument.Width
    
    ComboWidth = Me.ScaleWidth - (URLLabelLeft + LabelProtocol.Width + ComboProtocol.Width) - _
                                          (URLLabelLeft + LabelAddress.Width + ComboAddress.Width) - _
                                          (URLLabelLeft + LabelDocument.Width) - (URLLabelLeft + ButtonGo.Width)
                                          
    If ComboWidth < gDocumentComboMinWidth Then
        ComboDocument.Width = gDocumentComboMinWidth
    Else
        ComboDocument.Width = ComboWidth
    End If
    
    TextBoxDocument.Width = ComboDocument.Width - 290
    
    ButtonGo.Left = ComboDocument.Left + ComboDocument.Width + URLLabelLeft
End Sub

Private Sub SetWebTreeWindow()
    LabelWWW.Height = 360
    ToolbarWWW.Height = 360
    LabelHWW.Height = 360
    ToolbarHWW.Height = 360
    LabelTree.Height = 360
    ToolbarTree.Height = 360
    
    ToolbarTree.Visible = True
    LabelTree.Visible = True
    
    tvTreeView.Left = 0
    LabelTree.Left = gLabelLeft

    LabelTree.Top = gClientTop
    ToolbarTree.Top = gClientTop
    tvTreeView.Top = gClientTop + LabelTree.Height
    
    tvTreeView.Height = Me.ScaleHeight - (LabelTree.Top + LabelTree.Height)
    
    If WWW_Tab.Visible Or HWW_Tab.Visible Then
        imgSplitter.Visible = True
        imgSplitter.Top = gClientTop
        imgSplitter.Height = Me.ScaleHeight - gClientTop
        picSplitter.Height = Me.ScaleHeight - gClientTop
        If imgSplitter.Left < gWebTreeMinWidth Then
            treeright = gWebTreeMinWidth
        Else
            treeright = imgSplitter.Left
        End If
        
        imgSplitter.Left = treeright
        picSplitter.Left = treeright
    Else
        treeright = gWebTreeMinWidth
    End If
    
    tvTreeView.Width = treeright
    LabelTree.Width = gWebTreeMinWidth - ToolbarTree.Width - gLabelLeft
    ToolbarTree.Left = LabelTree.Left + LabelTree.Width
    
    If WWW_Tab.Visible And HWW_Tab.Visible Then
        ImgSplitter2.Width = Me.ScaleWidth - tvTreeView.Width - imgSplitter.Width
        ImgSplitter2.Left = tvTreeView.Width + imgSplitter.Width
    End If
    
    If WWW_Tab.Visible = True Then
        tvTreeView.Width = treeright
        
        LabelWWW.Left = tvTreeView.Width + imgSplitter.Width + gLabelLeft
        LabelWWW.Caption = "Hello World Wide Web"
        LabelWWW.Width = Me.ScaleWidth - ToolbarWWW.Width - tvTreeView.Width - imgSplitter.Width - gLabelLeft
        ToolbarWWW.Left = LabelWWW.Left + LabelWWW.Width
        
        WWW_Tab.Left = tvTreeView.Width + imgSplitter.Width
        WWW_Tab.Width = Me.ScaleWidth - tvTreeView.Width - imgSplitter.Width
    End If
    
    If HWW_Tab.Visible = True Then
        tvTreeView.Width = imgSplitter.Left
        
        LabelHWW.Left = tvTreeView.Width + imgSplitter.Width + gLabelLeft
        LabelHWW.Caption = "Hello Home Wide Web"
        LabelHWW.Width = Me.ScaleWidth - ToolbarHWW.Width - tvTreeView.Width - imgSplitter.Width - gLabelLeft
        ToolbarHWW.Left = LabelHWW.Left + LabelHWW.Width
        
        HWW_Tab.Left = tvTreeView.Width + imgSplitter.Width
        HWW_Tab.Width = Me.ScaleWidth - tvTreeView.Width - imgSplitter.Width
    End If
    
    ToolbarTree.Refresh
End Sub

Private Sub SetWWWTabWindow()
    Dim ImgSplitter2Width As Long
    Dim ClientTop As Long
    
    LabelWWW.Height = 360
    ToolbarWWW.Height = 360
    
    LabelWWW.Top = gClientTop
    ToolbarWWW.Top = gClientTop
    WWW_Tab.Top = gClientTop + LabelWWW.Height
    
    If tvTreeView.Visible Then
        ImgSplitter2Width = Me.ScaleWidth - (imgSplitter.Width + tvTreeView.Width)
        
        imgSplitter.Visible = True
        
        picSplitter.Left = tvTreeView.Width
        imgSplitter.Left = tvTreeView.Width

        imgSplitter.Top = gClientTop
        picSplitter.Top = gClientTop
        
        imgSplitter.Height = Me.ScaleHeight - gClientTop
        picSplitter.Height = Me.ScaleHeight - gClientTop
        
        LabelWWW.Left = tvTreeView.Width + imgSplitter.Width + gLabelLeft
        LabelWWW.Width = Me.ScaleWidth - (ToolbarWWW.Width + tvTreeView.Width + imgSplitter.Width + gLabelLeft)
        LabelWWW.Caption = "Hello World Wide Web"
        ToolbarWWW.Left = LabelWWW.Left + LabelWWW.Width
            
        WWW_Tab.Left = tvTreeView.Width + imgSplitter.Width
        WWW_Tab.Width = Me.ScaleWidth - (tvTreeView.Width + imgSplitter.Width)
    Else
        ImgSplitter2Width = Me.ScaleWidth
        
        imgSplitter.Visible = False
        picSplitter.Visible = False
        
        LabelWWW.Left = gLabelLeft
        LabelWWW.Width = Me.ScaleWidth - ToolbarWWW.Width
        ToolbarWWW.Left = LabelWWW.Width
        
        WWW_Tab.Left = 0
        WWW_Tab.Width = Me.ScaleWidth
    End If
    
    If HWW_Tab.Visible Then
        ImgSplitter2.Visible = True
        ImgSplitter2.Width = ImgSplitter2Width
        ImgSplitter2.Left = WWW_Tab.Left
        
        LabelHWW.Top = ImgSplitter2.Top + ImgSplitter2.Height
        ToolbarHWW.Top = ImgSplitter2.Top + ImgSplitter2.Height
        
        WWW_Tab.Height = ImgSplitter2.Top - WWW_Tab.Top
        HWW_Tab.Top = WWW_Tab.Height + WWW_Tab.Top + ImgSplitter2.Height + LabelHWW.Height
        HWW_Tab.Height = Me.ScaleHeight - gClientTop - WWW_Tab.Height - LabelWWW.Height - ImgSplitter2.Height - LabelHWW.Height
    Else
        ImgSplitter2.Visible = False
        WWW_Tab.Height = Me.ScaleHeight - WWW_Tab.Top
    End If
End Sub

Private Sub SetHWWTabWindow()
    Dim ImgSplitter2Width As Long
    Dim ClientTop As Long
    
    LabelHWW.Height = 360
    ToolbarHWW.Height = 360
    
    LabelHWW.Top = gClientTop
    ToolbarHWW.Top = gClientTop
    HWW_Tab.Top = gClientTop + LabelHWW.Height

    
    If tvTreeView.Visible Then
        ImgSplitter2Width = Me.ScaleWidth - imgSplitter.Width - tvTreeView.Width
        
        imgSplitter.Visible = True
        picSplitter.Left = tvTreeView.Width
        imgSplitter.Left = tvTreeView.Width

        imgSplitter.Top = gClientTop
        picSplitter.Top = gClientTop
        
        imgSplitter.Height = Me.ScaleHeight - gClientTop
        picSplitter.Height = Me.ScaleHeight - gClientTop
        
        LabelHWW.Left = tvTreeView.Width + imgSplitter.Width + gLabelLeft
        LabelHWW.Caption = "Hello Home Wide Web"
        LabelHWW.Width = Me.ScaleWidth - (ToolbarHWW.Width + tvTreeView.Width + imgSplitter.Width + gLabelLeft)
        ToolbarHWW.Left = LabelHWW.Left + LabelHWW.Width + gLabelLeft
        
        HWW_Tab.Left = tvTreeView.Width + imgSplitter.Width
        HWW_Tab.Width = Me.ScaleWidth - (tvTreeView.Width + imgSplitter.Width)
    Else
        imgSplitter.Visible = False
        ImgSplitter2Width = Me.ScaleWidth
        
        LabelHWW.Left = gLabelLeft
        LabelHWW.Width = Me.ScaleWidth - ToolbarHWW.Width
        ToolbarHWW.Left = LabelHWW.Width
       
        HWW_Tab.Left = 0
        HWW_Tab.Width = Me.ScaleWidth
    End If
    
    If WWW_Tab.Visible Then
        ImgSplitter2.Visible = True
        ImgSplitter2.Width = ImgSplitter2Width
        
        WWW_Tab.Height = ImgSplitter2.Top - WWW_Tab.Top
        
        LabelHWW.Top = WWW_Tab.Top + WWW_Tab.Height + ImgSplitter2.Height
        ToolbarHWW.Top = WWW_Tab.Top + WWW_Tab.Height + ImgSplitter2.Height
        
        HWW_Tab.Top = WWW_Tab.Top + WWW_Tab.Height + ImgSplitter2.Height + LabelHWW.Height
        HWW_Tab.Height = Me.ScaleHeight - (gClientTop + WWW_Tab.Height + LabelWWW.Height + ImgSplitter2.Height + LabelHWW.Height)
        
        ImgSplitter2.Left = HWW_Tab.Left
    Else
        ImgSplitter2.Visible = False
        HWW_Tab.Height = Me.ScaleHeight - HWW_Tab.Top
    End If
End Sub

Private Sub Form_Resize()
    SetAddressBar
    If tvTreeView.Visible Then
        SetWebTreeWindow
    End If
    
    If WWW_Tab.Visible Then
        SetWWWTabWindow
    End If
    
    If HWW_Tab.Visible Then
        SetHWWTabWindow
    End If
End Sub

Sub SpliiterSizeControls()
    On Error Resume Next

    If imgSpitter.Visible Then
        tvTreeView.Left = 0
        LabelTree.Left = gLabelLeft
        
        LabelTree.Top = gClientTop
        ToolbarTree.Top = gClientTop
        tvTreeView.Top = gClientTop + LabelTree.Height
        
        'set the width
        If picSplitter.Left < gWebTreeMinWidth Then
            treeright = gWebTreeMinWidth
        Else
            treeright = picSplitter.Left
        End If
        
        tvTreeView.Height = Me.ScaleHeight - (gClientTop + LabelTree.Height)
        LabelTree.Width = treeright - (ToolbarTree.Width + gLabelLeft)
        ToolbarTree.Left = LabelTree.Left + LabelTree.Width
        tvTreeView.Width = treeright
        
        imgSplitter.Left = treeright
        picSplitter.Left = treeright
        imgSplitter.Top = gClientTop
        picSplitter.Top = gClientTop
        imgSplitter.Height = Me.ScaleHeight - gClientTop
        picSplitter.Height = Me.ScaleHeight - gClientTop
        
        If WWW_Tab.Visible Then
            LabelWWW.Left = treeright + imgSplitter.Width + gLabelLeft
            LabelWWW.Width = Me.ScaleWidth - (tvTreeView.Width + imgSplitter.Width) - ToolbarWWW.Width - gLabelLeft
            ToolbarWWW.Left = LabelWWW.Left + LabelWWW.Width
            
            WWW_Tab.Left = imgSplitter.Left + imgSplitter.Width
            WWW_Tab.Top = tvTreeView.Top
            WWW_Tab.Width = Me.ScaleWidth - (tvTreeView.Width + imgSplitter.Width)
        End If
        
        If WWW_Tab.Visible And HWW_Tab.Visible Then
            'set the height
            ImgSplitter2.Left = treeright + imgSplitter.Width
            ImgSplitter2.Width = Me.ScaleWidth - (tvTreeView.Width + imgSplitter.Width)
        End If
        
        If HWW_Tab.Visible Then
            LabelHWW.Left = treeright + imgSplitter.Width + gLabelLeft
            LabelHWW.Width = Me.ScaleWidth - (tvTreeView.Width + imgSplitter.Width) - ToolbarHWW.Width - gLabelLeft
            ToolbarHWW.Left = LabelWWW.Left + LabelHWW.Width
            
            HWW_Tab.Left = treeright + imgSplitter.Width
            HWW_Tab.Width = Me.ScaleWidth - (tvTreeView.Width + imgSplitter.Width)
        End If
    End If
    
    ToolbarTree.Refresh
End Sub

Sub Spliiter2SizeControls()
    If ImgSplitter2.Visible Then
        'set the width
        If WWW_Tab.Visible Then
            LabelWWW.Top = gClientTop
            ToolbarWWW.Top = gClientTop
            WWW_Tab.Top = gClientTop + LabelWWW.Height
            
            WWW_Tab.Height = picSplitter2.Top - WWW_Tab.Top
        End If
        
        ImgSplitter2.Top = picSplitter2.Top
        
        If HWW_Tab.Visible Then
            LabelHWW.Top = ImgSplitter2.Top + ImgSplitter2.Height
            ToolbarHWW.Top = ImgSplitter2.Top + ImgSplitter2.Height
            
            HWW_Tab.Top = LabelHWW.Top + LabelHWW.Height
            HWW_Tab.Height = Me.ScaleHeight - (LabelHWW.Top + LabelHWW.Height)
        End If
    End If
End Sub

Private Sub mnuFileFind_Click()
    HWW_Tab.Visible = True
    LabelHWW.Visible = True
    ToolbarHWW.Visible = True
    
    SetHWWTabWindow
End Sub

Private Sub mnuFileOpen_Click()
    WWW_Tab.Visible = True
    LabelWWW.Visible = True
    ToolbarWWW.Visible = True
    SetWWWTabWindow
End Sub

Private Sub mnuFileSendTo_Click()
    tvTreeView.Visible = True
    SetWebTreeWindow
End Sub






Private Sub ToolbarTree_ButtonClick(ByVal Button As MSComctlLib.Button)
    If Button.Key = "Close" Then
        CloseTree
    ElseIf Button.Key = "Max" Then
        imgSplitter.Left = 6000
    ElseIf Button.Key = "Hide" Then
        CloseTree
    End If
    
    Form_Resize
End Sub

Private Sub ToolbarWWW_ButtonClick(ByVal Button As MSComctlLib.Button)
    If Button.Key = "Close" Then
        CloseWWW
    ElseIf Button.Key = "Max" Then
        CloseTree
        CloseHWW
    ElseIf Button.Key = "Hide" Then
        CloseWWW
    End If
    
    Form_Resize
End Sub

Private Sub ToolbarHWW_ButtonClick(ByVal Button As MSComctlLib.Button)
    If Button.Key = "Close" Then
        CloseHWW
    ElseIf Button.Key = "Max" Then
        CloseTree
        CloseWWW
    ElseIf Button.Key = "Hide" Then
        CloseHWW
    End If
        Form_Resize
End Sub

Private Sub CloseTree()
    LabelTree.Visible = False
    ToolbarTree.Visible = False
    tvTreeView.Visible = False
    imgSplitter.Visible = False
    picSplitter.Visible = False
End Sub

Private Sub CloseWWW()
    LabelWWW.Visible = False
    ToolbarWWW.Visible = False
    WWW_Tab.Visible = False
    ImgSplitter2.Visible = False
    picSplitter2.Visible = False
    
    If Not HWW_Tab.Visible Then
        imgSplitter.Visible = False
        picSplitter.Visible = False
    End If
End Sub

Private Sub CloseHWW()
    LabelHWW.Visible = False
    ToolbarHWW.Visible = False
    HWW_Tab.Visible = False
    ImgSplitter2.Visible = False
    picSplitter2.Visible = False

    If Not WWW_Tab.Visible Then
        imgSplitter.Visible = False
        picSplitter.Visible = False
    End If
End Sub

Private Sub imgSplitter_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    With imgSplitter
        picSplitter.Move .Left, .Top, .Width, .Height
    End With
    picSplitter.Visible = True
    gMoving = True
End Sub

Private Sub imgSplitter_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim sglPos As Single
    
    If gMoving Then
        Call picSplitter.ZOrder(0)
        sglPos = X + imgSplitter.Left
        If sglPos > Me.Width Then
            picSplitter.Left = Me.Width
        Else
            picSplitter.Left = sglPos
        End If
    End If
End Sub

Private Sub imgSplitter_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    SpliiterSizeControls
    picSplitter.Visible = False
    gMoving = False
End Sub

Private Sub TreeView1_DragDrop(Source As Control, X As Single, Y As Single)
    If Source = imgSplitter Then
        SpliiterSizeControls
    End If
End Sub

Private Sub imgSplitter2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    With ImgSplitter2
        picSplitter2.Move .Left, .Top, .Width, .Height
    End With
    picSplitter2.Visible = True
    gMoving = True
End Sub

Private Sub imgSplitter2_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim sglPos As Single
    
    If gMoving Then
        Call picSplitter2.ZOrder(0)
        sglPos = Y + ImgSplitter2.Top
        If sglPos > Me.Height Then
            picSplitter2.Top = Me.Height
        Else
            picSplitter2.Top = sglPos
        End If
    End If
End Sub

Private Sub imgSplitter2_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Spliiter2SizeControls
    picSplitter2.Visible = False
    gMoving = False
End Sub


