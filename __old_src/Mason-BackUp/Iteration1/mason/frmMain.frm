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
      BorderStyle     =   0  'None
      Height          =   375
      Left            =   6360
      TabIndex        =   21
      Text            =   "Text1"
      Top             =   720
      Width           =   2655
   End
   Begin VB.ComboBox ComboDocument 
      Height          =   315
      Left            =   6240
      TabIndex        =   20
      Text            =   "Combo1"
      Top             =   720
      Width           =   3015
   End
   Begin VB.TextBox TextBoxProtocol 
      BorderStyle     =   0  'None
      Height          =   285
      Left            =   960
      TabIndex        =   18
      Text            =   "Text1"
      Top             =   720
      Width           =   615
   End
   Begin VB.ComboBox ComboProtocol 
      Height          =   315
      Left            =   840
      TabIndex        =   17
      Text            =   "Combo1"
      Top             =   720
      Width           =   975
   End
   Begin VB.TextBox TextBoxAddress 
      BorderStyle     =   0  'None
      Height          =   285
      Left            =   2520
      TabIndex        =   15
      Text            =   "Text1"
      Top             =   720
      Width           =   2535
   End
   Begin VB.CommandButton ButtonGo 
      Height          =   315
      Left            =   9480
      Picture         =   "frmMain.frx":00EA
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   720
      Width           =   975
   End
   Begin VB.ComboBox ComboAddress 
      Height          =   315
      ItemData        =   "frmMain.frx":192C
      Left            =   2520
      List            =   "frmMain.frx":1939
      Style           =   2  'Dropdown List
      TabIndex        =   13
      Top             =   720
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
      DisabledImageList=   "ImageListMain"
      HotImageList    =   "ImageListMain"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   27
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "WWW"
            Object.ToolTipText     =   "World Wide Web"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "HWW"
            Object.ToolTipText     =   "Home Wide Web"
            Object.Tag             =   "xx"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Library"
            Object.ToolTipText     =   "Library"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Users"
            Object.ToolTipText     =   "Users"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Connection"
            Object.ToolTipText     =   "Connection Details"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Schedular"
            Object.ToolTipText     =   "Schedular"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Publish"
            Object.ToolTipText     =   "Publish"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Search"
            Object.ToolTipText     =   "Search"
            ImageIndex      =   15
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "EMail"
            Object.ToolTipText     =   "E-Mail"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Messenger"
            Object.ToolTipText     =   "Messenger"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "FileTransfer"
            Object.ToolTipText     =   "Transfer Files"
            ImageIndex      =   12
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Media"
            Object.ToolTipText     =   "Media Albums"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button16 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "EDocs"
            Object.ToolTipText     =   "E-Documents"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button17 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Services"
            Object.ToolTipText     =   "Internet Services"
            ImageIndex      =   13
            Style           =   5
         EndProperty
         BeginProperty Button18 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Calendar"
            Object.ToolTipText     =   "Calendar"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button19 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button20 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Status"
            Object.ToolTipText     =   "Status"
            ImageIndex      =   16
         EndProperty
         BeginProperty Button21 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Help"
            Object.ToolTipText     =   "Dynamic Help"
            ImageIndex      =   17
         EndProperty
         BeginProperty Button22 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button23 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Back"
            Object.ToolTipText     =   "Back"
            ImageIndex      =   18
         EndProperty
         BeginProperty Button24 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Forward"
            Object.ToolTipText     =   "Forward"
            ImageIndex      =   19
         EndProperty
         BeginProperty Button25 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Refresh"
            Object.ToolTipText     =   "Refresh Window"
            ImageIndex      =   20
         EndProperty
         BeginProperty Button26 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Stop"
            Object.ToolTipText     =   "Stop Transfer"
            ImageIndex      =   21
         EndProperty
         BeginProperty Button27 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Exit"
            Object.ToolTipText     =   "Exit Application"
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
      Left            =   4080
      TabIndex        =   5
      Top             =   2040
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
      Top             =   4800
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
      Top             =   720
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
      Top             =   720
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
      Top             =   720
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
      Height          =   375
      Left            =   4320
      TabIndex        =   7
      Top             =   1440
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
      Begin VB.Menu mnuNetworkConnections 
         Caption         =   "&Network Connections"
      End
      Begin VB.Menu mnuSep3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuWebSiteLogins 
         Caption         =   "WebSite Logins"
      End
      Begin VB.Menu mnuSSO 
         Caption         =   "&Single Sign On"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuMSO 
         Caption         =   "&Manual Sign On"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnu14 
         Caption         =   "-"
      End
      Begin VB.Menu mnuBasicUserInformation 
         Caption         =   "&User Information"
      End
      Begin VB.Menu mnuManageUsers 
         Caption         =   "Manage Users"
      End
      Begin VB.Menu mnuSep68 
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
      Begin VB.Menu mnuExpandWebPageLinks 
         Caption         =   "Expand Page Links"
      End
      Begin VB.Menu mnuSep66 
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
         Caption         =   "Set As Default Page"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuStorePage 
         Caption         =   "&Store Page"
      End
      Begin VB.Menu mnuManageWebStore 
         Caption         =   "Manage Store"
      End
      Begin VB.Menu mnuSep67 
         Caption         =   "-"
      End
      Begin VB.Menu mnuViewHistory 
         Caption         =   "&View History"
      End
      Begin VB.Menu mnuManageHistory 
         Caption         =   "Manage History"
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
      Begin VB.Menu mnuShowHomeSitesHomePage 
         Caption         =   "Show Home Page"
      End
      Begin VB.Menu mnuSep70 
         Caption         =   "-"
      End
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
         Begin VB.Menu mnuEditHomeSite 
            Caption         =   "Edit Site"
         End
         Begin VB.Menu mnuSaveHomeSite 
            Caption         =   "Save Site"
         End
         Begin VB.Menu mnuCloseHomeSite 
            Caption         =   "Close Site"
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
         Begin VB.Menu mnuEditSitePage 
            Caption         =   "Edit Page"
         End
         Begin VB.Menu mnuSaveHomeSitePage 
            Caption         =   "Save Page"
         End
         Begin VB.Menu mnuCloseHomeSitePage 
            Caption         =   "Close Page"
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
      Begin VB.Menu mnuHomeSiteDatabase 
         Caption         =   "Site Database"
         Begin VB.Menu mnuSiteDatabaseProperties 
            Caption         =   "Properties"
         End
         Begin VB.Menu mnuSep64 
            Caption         =   "-"
         End
         Begin VB.Menu mnuViewSiteTables 
            Caption         =   "View Tables"
         End
         Begin VB.Menu mnuNewSiteTable 
            Caption         =   "New Table"
         End
         Begin VB.Menu mnuEditSiteTable 
            Caption         =   "Edit Table"
         End
      End
      Begin VB.Menu mnuSep65 
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
      Begin VB.Menu mnuFindInHomePages 
         Caption         =   "Find In Open Pages"
      End
   End
   Begin VB.Menu mnuLibrary 
      Caption         =   "&Library"
      Begin VB.Menu mnuShowLibrary 
         Caption         =   "&Show"
      End
      Begin VB.Menu mnuSep41 
         Caption         =   "-"
      End
      Begin VB.Menu mnuLibraryContents 
         Caption         =   "Library Contents"
         Begin VB.Menu mnuViewLibraryContents 
            Caption         =   "Content Properties"
         End
         Begin VB.Menu mnuSep69 
            Caption         =   "-"
         End
         Begin VB.Menu mnuViewLibraryContent 
            Caption         =   "View Content"
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
         Begin VB.Menu mnuLibraryDelete 
            Caption         =   "Delete Content"
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
         Caption         =   "Publish"
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
         Begin VB.Menu mnuShowLibSiteDatabase 
            Caption         =   "Site Database"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowEmails 
            Caption         =   "Emails"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowChats 
            Caption         =   "Chats"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowContacts 
            Caption         =   "Contacts"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowDownloadedFiles 
            Caption         =   "Downloaded Files"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowMediaAlbums 
            Caption         =   "Media Albums"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowEDocuments 
            Caption         =   "e-Documents"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuShowServices 
            Caption         =   "Services"
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
         Begin VB.Menu mnuSep57 
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
      End
      Begin VB.Menu mnuMailLoginOptions 
         Caption         =   "Manage Logins"
      End
      Begin VB.Menu mnuSep59 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSendMailOptions 
         Caption         =   "Send Options"
      End
      Begin VB.Menu mnuReceiveMailOptions 
         Caption         =   "Receive Options"
      End
      Begin VB.Menu mnuMailDisplayOptions 
         Caption         =   "Display Options"
      End
      Begin VB.Menu mnuSep61 
         Caption         =   "-"
      End
      Begin VB.Menu mnuInsertMailAttachments 
         Caption         =   "Insert Attachments"
      End
      Begin VB.Menu mnuViewAttachments 
         Caption         =   "View Saved Attachments"
      End
      Begin VB.Menu mnuAttachmentOptions 
         Caption         =   "Attachments Options"
      End
      Begin VB.Menu mnuMailStoreOptions 
         Caption         =   "Mail Store Options"
      End
      Begin VB.Menu mnuSep56 
         Caption         =   "-"
      End
      Begin VB.Menu mnuMergeAllEmailAccounts 
         Caption         =   "Merge All Accounts"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuGroupMailOptions 
         Caption         =   "Merge Options"
      End
      Begin VB.Menu mnuSep60 
         Caption         =   "-"
      End
      Begin VB.Menu mnuEMailSignature 
         Caption         =   "Signature"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function OSWinHelp% Lib "user" Alias "WinHelpA" (ByVal hWnd&, ByVal HelpFile$, ByVal wCommand%, dwData As Any)
Dim gBorderWidth As Long
Dim gLabelLeft As Long
Dim gMoving As Boolean
Dim gClientTop As Long
Dim gWebTreeMinWidth As Long
Dim gDocumentComboMinWidth As Long
Dim gToolbarGap As Long
Dim gAddressbarGar As Long

Const MIIM_STATE = 1
Const MIIM_ID As Long = 2
Const MIIM_SUBMENU As Long = 4
Const MIIM_CHECKMARKS As Long = 8
Const MIIM_TYPE As Long = 16
Const MIIM_DATA As Long = 32
Const MIIM_STRING As Long = 64
Const MIIM_BITMAP As Long = 128
Const MIIM_FTYPE As Long = 256

Private Sub Form_Load()
    Me.Left = GetSetting(App.Title, "Settings", "MainLeft", 1000)
    Me.Top = GetSetting(App.Title, "Settings", "MainTop", 1000)
    Me.Width = GetSetting(App.Title, "Settings", "MainWidth", 6500)
    Me.Height = GetSetting(App.Title, "Settings", "MainHeight", 6500)
    
    AppendMenuItems
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

Sub AppendMenuItems()
    Dim hMenuBar As Long
    Dim hMenuItem As Long
    Dim hMenuSubItem As Long
    Dim hMenuPopup As Long
    Dim mID As Long
    Dim FlagStr As Long
    Dim FlagChecked As Long
    Dim FlagPos As Long
    Dim FlagSep As Long
    Dim FlagPopUp As Long
1    Dim Flas As Long
    Dim SubFlag As Long
    Dim ChkFlag As Long
    
    FlagStr = 0
    FlagChecked = 8
    FlagPopUp = 16
    FlagPos = 1024
    FlagSep = 2048
    
    mID = 1000
    Flag = FlagStr
    hMenuBar = GetMenu(hWnd)
    
    ' Main Menu
    hMenuItem = GetSubMenu(hMenuBar, 0)
    
    ' Language Menu
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuItem, 25, Flag, hMenuPopup, "&Language")
    Flag = FlagPos Or FlagChecked
    Call InsertMenu(hMenuPopup, 0, Flag, mID + 3, "US English")

    ' Security
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuItem, 26, Flag, hMenuPopup, "&Security")
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 0, Flag, mID + 4, "Certificates")
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 1, Flag, mID + 4, "Security Levels")
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 2, Flag, mID + 4, "Licenses")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call InsertMenu(hMenuItem, 27, Flag, 0, "")

    ' Home Web
    hMenuItem = GetSubMenu(hMenuBar, 2)
    
    Flag = FlagPos
    Call InsertMenu(hMenuItem, 14, Flag, mID + 4, "Content Properties")
    Call InsertMenu(hMenuItem, 15, Flag, mID + 4, "Show Format Panel")
    
    Flag = FlagPos Or FlagSep
    Call InsertMenu(hMenuItem, 16, Flag, 0, "")
    
    ' Library
    hMenuItem = GetSubMenu(hMenuBar, 3)
    
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuItem, 2, Flag, hMenuPopup, "&Library Folders")
    
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 0, Flag, mID + 4, "Folder Properties")
    
    Flag = FlagPos Or FlagSep
    Call InsertMenu(hMenuPopup, 1, Flag, 0, "")
   
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 2, Flag, mID + 4, "Create Folder")
    Call InsertMenu(hMenuPopup, 3, Flag, mID + 4, "Open Folder")
    Call InsertMenu(hMenuPopup, 4, Flag, mID + 4, "Edit Folder")
    Call InsertMenu(hMenuPopup, 5, Flag, mID + 4, "Move Folder")
    Call InsertMenu(hMenuPopup, 7, Flag, mID + 4, "Delete Folder")
    
    ' Search Menu
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 4, Flag, hMenuPopup, "&Search")
    
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Search &Engines")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 5, "www.yahoo.com")
    Call AppendMenu(hMenuItem, Flag, mID + 6, "www.google.com")
    Call AppendMenu(hMenuItem, Flag, mID + 7, "www.msn.com")
    Call AppendMenu(hMenuItem, Flag, mID + 8, "www.lycos.com")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Select Search Engines")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Search Library")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 10, "All")
    Call AppendMenu(hMenuItem, Flag, mID + 11, "Selected Content")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 12, "Saved Web Pages")
    Call AppendMenu(hMenuItem, Flag, mID + 13, "Home Sites")
    Call AppendMenu(hMenuItem, Flag, mID + 14, "E-Mails")
    Call AppendMenu(hMenuItem, Flag, mID + 15, "E-Documents")
    Call AppendMenu(hMenuItem, Flag, mID + 16, "Media Albums")
    Call AppendMenu(hMenuItem, Flag, mID + 17, "Downloaded Files")
    Call AppendMenu(hMenuItem, Flag, mID + 18, "Local Drives")
    Call AppendMenu(hMenuItem, Flag, mID + 19, "Calendar")
    Call AppendMenu(hMenuItem, Flag, mID + 20, "Contacts")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Design Search")
    
    hMenuSubItem = CreatePopupMenu()
    Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "Merge In Engine")
    
    Flag = FlagStr
    Call AppendMenu(hMenuSubItem, Flag, mID + 21, "Start Merge")
    Call AppendMenu(hMenuSubItem, Flag, mID + 22, "Map Input Fields")
    Call AppendMenu(hMenuSubItem, Flag, mID + 23, "Map Results Fields")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 24, "Search Page")
    Call AppendMenu(hMenuItem, Flag, mID + 25, "Input Fields")
    Call AppendMenu(hMenuItem, Flag, mID + 26, "Results Fields")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 27, "Add Search Engines")
    Call AppendMenu(hMenuPopup, Flag, mID + 28, "Remove Search Engines")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 28, "Save Search Phrases")
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 29, "View Search Phrases")
    Call AppendMenu(hMenuPopup, Flag, mID + 31, "Edit Search Phrases")

    ' Messenger
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 6, Flag, hMenuPopup, "&Messenger")

    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 32, "Alerts On")
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 33, "Manage Alerts")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 60, "&StartUp Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 61, "&Messenger Servers")
    Call AppendMenu(hMenuPopup, Flag, mID + 61, "&Manage Logins")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 34, "View Online Contacts")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 35, "Set Online Status")
    Call AppendMenu(hMenuPopup, Flag, mID + 36, "View Online Contacts")
    Call AppendMenu(hMenuPopup, Flag, mID + 37, "Address Book")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 38, "Chat Room")
    Call AppendMenu(hMenuPopup, Flag, mID + 39, "Manage Chat Rooms")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 40, "Audio Room")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Audio Controls")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 41, "Volume Control")
    Call AppendMenu(hMenuItem, Flag, mID + 42, "Recording Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 43, "Audio Options")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 44, "Video Room")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Video Controls")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 45, "Rendering Options")
    Call AppendMenu(hMenuItem, Flag, mID + 46, "Capture Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 47, "Video Options")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 48, "&Scribble Pad")
    Call AppendMenu(hMenuPopup, Flag, mID + 49, "&Share Media")
    Call AppendMenu(hMenuPopup, Flag, mID + 50, "&Share Web Pages")
    Call AppendMenu(hMenuPopup, Flag, mID + 51, "&File Transfer")
    Call AppendMenu(hMenuPopup, Flag, mID + 52, "&Share Browser")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 53, "&Telephony")
    Call AppendMenu(hMenuPopup, Flag, mID + 54, "&Call Settings")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 55, "&Web Conference")
    Call AppendMenu(hMenuPopup, Flag, mID + 56, "&Call Settings")

    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Plan Conferences")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 57, "Manage")
    Call AppendMenu(hMenuItem, Flag, mID + 58, "Add Participants")
    Call AppendMenu(hMenuItem, Flag, mID + 59, "Add Agenda")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 62, "&Security Options")

    ' File Transfer
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 7, Flag, hMenuPopup, "&File Transfer")

    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Open FTP Sites")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "FTP Site1")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "FTP Site2")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Open Connection")
    
    Call AppendMenu(hMenuPopup, Flag, mID + 66, "Select Profiles")
    Call AppendMenu(hMenuPopup, Flag, mID + 67, "Disconnect")
    Call AppendMenu(hMenuPopup, Flag, mID + 68, "Close")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 69, "Session Profiles")
    Call AppendMenu(hMenuPopup, Flag, mID + 70, "Manage FTP Sites")
    Call AppendMenu(hMenuPopup, Flag, mID + 71, "Save FTP Site")
    Call AppendMenu(hMenuPopup, Flag, mID + 72, "View FTP Folders")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 73, "Manage Logins")
    Call AppendMenu(hMenuPopup, Flag, mID + 74, "Transfer Properties")
    Call AppendMenu(hMenuPopup, Flag, mID + 75, "Folder Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 76, "Display Options")

    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 77, "View Schedules")
    Call AppendMenu(hMenuPopup, Flag, mID + 78, "Schedular")
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Alerts On")

    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Download Sites")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 80, "Download Site1")
    Call AppendMenu(hMenuItem, Flag, mID + 81, "Download Site2")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 82, "View Download Sites")
    Call AppendMenu(hMenuPopup, Flag, mID + 83, "Manage Download Sites")
    Call AppendMenu(hMenuPopup, Flag, mID + 84, "Save Download Site")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "View Downloads Folder")
    Call AppendMenu(hMenuPopup, Flag, mID + 86, "Downloads Folder Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 87, "Downloads Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 88, "File Associations")

    ' Media Menu
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 8, Flag, hMenuPopup, "&Media")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "View Collection")
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "View Album")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Albums")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Create Album")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Edit Album")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Remove Album")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Album Properties")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Default Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Display Options")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Album Pages")

    Call AppendMenu(hMenuItem, Flag, mID + 63, "Create Album Page")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Edit Album Page")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Remove Album Page")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Page Properties")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Default Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Display Options")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Page Contents")

    Call AppendMenu(hMenuItem, Flag, mID + 63, "Create Album Content")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Edit Album Content")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Remove Album Content")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Content Properties")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Default Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Display Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 63, "Design Album")
    Call AppendMenu(hMenuPopup, Flag, mID + 64, "Design Page")
    Call AppendMenu(hMenuPopup, Flag, mID + 64, "Design Content")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Information")
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Images")
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Audio Content")
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Video")
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Media Links")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Get Images")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Image Control")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Size And Resolution")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Render Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "View Image Editors")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Image Formats")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Take Snapshot")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Get Audio")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Audio Control")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Volume Control")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Graphic Equilizer")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Render Options")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Audio Players")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Encoders/Decoders")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Audio Devices")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Record Audio")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Get Video")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Video Control")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Render Options")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Capture Options")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Video Players")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Encoders/Decoders")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Video Devices")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Record Video")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Get Media Links")
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Save Media Link")
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Network Options")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Performance Options")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Zoom Window")
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Search Media")
    
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 9, Flag, hMenuPopup, "&e-Documents")
        
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "View Collection")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Collection")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "New Document")
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "New From Templates")
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Template1")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Template2")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Open Document")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Lock Document")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Unlock Document")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Save Document")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Close Document")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Display Options")
           Flag = FlagStr
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Full")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Pages")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Document Properties")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Document Ruler")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Page Number")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Header")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Footer")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Wrap Text")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Select")
            Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "All")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Page")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Content At Cursor")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Insert")
            Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Page")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Slide")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Grid")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Table")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Line Break")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Text")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Document Page Link")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Hyper Link")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Bullets")
    
        Flag = FlagPos Or FlagPopUp
        hMenuSubItem = CreatePopupMenu()
            Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "Standard")
                Flag = FlagStr
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Cover")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Introduction")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Summary")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Prelude")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Contents")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Index")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Appendix")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Margin")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Page Numbers")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Borders")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Header")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Footer")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Bibliography")
    
        Flag = FlagPos Or FlagPopUp
        hMenuSubItem = CreatePopupMenu()
            Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "Content")
                Flag = FlagStr
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Date And Time")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Special characters")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Formatted Strings")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Currency")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Formulas")
    
        Flag = FlagPos Or FlagPopUp
        hMenuSubItem = CreatePopupMenu()
            Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "Media")
                Flag = FlagStr
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Picture")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Audio")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Video")
    
        Flag = FlagPos Or FlagPopUp
        hMenuSubItem = CreatePopupMenu()
            Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "From Templates")
                Flag = FlagStr
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Template1")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Template2")
    
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Format")
            Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Font")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Color")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Align")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Spacing")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Border")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "BackGround")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Document Properties")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Document Language")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Templates")
            Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "View")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Create")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Edit")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Save")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Remove")
        
        Flag = FlagPos Or FlagSep
        Call AppendMenu(hMenuItem, Flag, 0, "")
        Flag = FlagPos
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Load")
        
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Style Sheets")
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Select")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "View")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Create")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Edit")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Save")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Remove")
        
        Flag = FlagPos Or FlagSep
        Call AppendMenu(hMenuItem, Flag, 0, "")
        Flag = FlagPos
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Load")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Find")
        
    ' Calendar
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 10, Flag, hMenuPopup, "&Calendar")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Display Calendar")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Display Clock")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Display Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Show Planner")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Show Plans")
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "All")
        
        Flag = FlagPos Or FlagSep
        Call AppendMenu(hMenuItem, Flag, 0, "")
    
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Today")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "This Week")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Past Week")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Next Week")
    
        Flag = FlagPos Or FlagSep
        Call AppendMenu(hMenuItem, Flag, 0, "")
    
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Select Time Period")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "View Plan")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "New Plan")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Plan")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Plan")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "View Task Folder")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "New Task Folder")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Task Folder")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Task Folder")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "View Task")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "New Task")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Task")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Task")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Set Alerts")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Alerts On")
    
    ' Services Menu
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 11, Flag, hMenuPopup, "&Services")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Open Services Catalog")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Catalog")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Add Service Link")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Serice Link")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Save Service Link")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Add Service Type")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Serice Type")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "News Groups")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Internet Directories")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "IRC Chat Rooms")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "TV Channels")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Radio Channels")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Streaming Media Sites")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Blogs")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "RSS Feeds")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Online Games")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Information Catalog")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Product Catalog")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Download Services Catalog")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Upload Service Link")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Design Service Page")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Add To Home Site")
    
    ' Options
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 12, Flag, hMenuPopup, "&Options")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Startup Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Network Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Servers Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Login Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Exit Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Links Panel Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Browser Panel Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Library Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Search Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Audio Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Video Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "EMail Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Messenger Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "FTP Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Schedule Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Publish Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Themes Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Setup Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Status Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Messages Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Security Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Performance Options")
    
    ' Panels
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 13, Flag, hMenuPopup, "&Panels")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Application Themes")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Theme1")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Theme2")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Theme3")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Openned Panels")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel1")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel2")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel3")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Recently Closed Panels")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel1")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel2")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel3")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Undo Last Action")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Select All")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Select At Cursor")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Copy Selected")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Cut Selected")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Paste")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Paste (With Dependencies)")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Find")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Replace")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Minimize Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Maximize Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Restore Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Hide Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Close Panel")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Lock Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Lock All Panels")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Tile Panels Horizontal")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Tile Panels Vertical")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Dock Panels")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Best Fit")
    
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 14, Flag, hMenuPopup, "&End")
    
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 28, "Save Settings On Exit")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "LogOff")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Exit")
    
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
    gToolbarGap = 20
    gAddressbarGar = 40
    
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
        
    TextBoxProtocol.Height = 240
    TextBoxAddress.Height = 240
    TextBoxDocument.Height = 240
    
    URLLabelLeft = gLabelLeft * 2
    If tbToolBar.Visible Then
        gClientTop = tbToolBar.Height + gToolbarGap
    Else
        gClientTop = gToobargap
    End If
    
    LabelProtocol.Top = gClientTop + 60
    LabelAddress.Top = gClientTop + 60
    LabelDocument.Top = gClientTop + 60
    
    ComboProtocol.Top = gClientTop
    TextBoxProtocol.Top = gClientTop + 40
    
    ComboAddress.Top = gClientTop
    TextBoxAddress.Top = gClientTop + 40
    
    ComboDocument.Top = gClientTop
    TextBoxDocument.Top = gClientTop + 40
    
    ButtonGo.Top = gClientTop
    
    LabelProtocol.Left = URLLabelLeft
    ComboProtocol.Left = URLLabelLeft + LabelProtocol.Width + URLLabelLeft
    TextBoxProtocol.Left = 2 * URLLabelLeft + LabelProtocol.Width + URLLabelLeft
    
    ComboProtocol.Width = 975
    TextBoxProtocol.Width = 650
    
    LabelAddress.Left = ComboProtocol.Left + ComboProtocol.Width + URLLabelLeft
    ComboAddress.Left = LabelAddress.Left + LabelAddress.Width + URLLabelLeft
    TextBoxAddress.Left = LabelAddress.Left + LabelAddress.Width + 2 * URLLabelLeft
    
    ComboAddress.Width = 3200
    TextBoxAddress.Width = 2860
    
    LabelDocument.Left = ComboAddress.Left + ComboAddress.Width + URLLabelLeft
    ComboDocument.Left = LabelDocument.Left + LabelDocument.Width + URLLabelLeft
    TextBoxDocument.Left = LabelDocument.Left + LabelDocument.Width + 2 * URLLabelLeft
    
    ComboWidth = Me.ScaleWidth - (URLLabelLeft + LabelProtocol.Width + ComboProtocol.Width + URLLabelLeft) - _
                                          (URLLabelLeft + LabelAddress.Width + ComboAddress.Width + URLLabelLeft) - _
                                          (URLLabelLeft + LabelDocument.Width + URLLabelLeft) - (URLLabelLeft + ButtonGo.Width)
                                          
    If ComboWidth < gDocumentComboMinWidth Then
        ComboDocument.Width = gDocumentComboMinWidth
    Else
        ComboDocument.Width = ComboWidth
    End If
    
    TextBoxDocument.Width = ComboDocument.Width - 310
    
    ButtonGo.Left = ComboDocument.Left + ComboDocument.Width + URLLabelLeft
    
    gClientTop = gClientTop + ButtonGo.Height + gAddressbarGar
End Sub

Private Sub SetWebTreeWindow()
    LabelWWW.Height = 330
    ToolbarWWW.Height = 330
    LabelHWW.Height = 330
    ToolbarHWW.Height = 330
    LabelTree.Height = 330
    ToolbarTree.Height = 330
    
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
    LabelTree.Width = treeright - ToolbarTree.Width - gLabelLeft
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
    
    LabelWWW.Height = 330
    ToolbarWWW.Height = 330
    
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
    
    LabelHWW.Height = 330
    ToolbarHWW.Height = 330
    
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

Private Sub mnuHWW_Click()
    HWW_Tab.Visible = True
    LabelHWW.Visible = True
    ToolbarHWW.Visible = True
    
    SetHWWTabWindow
End Sub

Private Sub mnuShowLibraryMain_Click()
    LabelTree.Visible = True
    ToolbarTree.Visible = True
    tvTreeView.Visible = True
    
    SetWebTreeWindow
End Sub

Private Sub mnuWWW_Click()
    WWW_Tab.Visible = True
    LabelWWW.Visible = True
    ToolbarWWW.Visible = True
    
    SetWWWTabWindow
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

Private Sub imgSplitter_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    With imgSplitter
        picSplitter.Move .Left, .Top, .Width, .Height
    End With
    picSplitter.Visible = True
    gMoving = True
End Sub

Private Sub imgSplitter_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    Dim sglPos As Single
    
    If gMoving Then
        Call picSplitter.ZOrder(0)
        sglPos = x + imgSplitter.Left
        If sglPos > Me.Width Then
            picSplitter.Left = Me.Width
        Else
            picSplitter.Left = sglPos
        End If
    End If
End Sub

Private Sub imgSplitter_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    SpliiterSizeControls
    picSplitter.Visible = False
    gMoving = False
End Sub

Private Sub TreeView1_DragDrop(Source As Control, x As Single, y As Single)
    If Source = imgSplitter Then
        SpliiterSizeControls
    End If
End Sub

Private Sub imgSplitter2_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    With ImgSplitter2
        picSplitter2.Move .Left, .Top, .Width, .Height
    End With
    picSplitter2.Visible = True
    gMoving = True
End Sub

Private Sub imgSplitter2_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
    Dim sglPos As Single
    
    If gMoving Then
        Call picSplitter2.ZOrder(0)
        sglPos = y + ImgSplitter2.Top
        If sglPos > Me.Height Then
            picSplitter2.Top = Me.Height
        Else
            picSplitter2.Top = sglPos
        End If
    End If
End Sub

Private Sub imgSplitter2_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    Spliiter2SizeControls
    picSplitter2.Visible = False
    gMoving = False
End Sub

