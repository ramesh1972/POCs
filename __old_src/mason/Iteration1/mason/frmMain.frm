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

Private Sub Form_Load()
    AppendMenuItems
    SetStandardWindowProperties
    
    HideAllWindows
End Sub

Public Sub Form_Resize()
    SetAddressBar
    If fMainForm.tvTreeView.Visible Then
        SetWebTreeWindow
    End If
    
    If fMainForm.WWW_Tab.Visible Then
        SetWWWTabWindow
    End If
    
    If fMainForm.HWW_Tab.Visible Then
        SetHWWTabWindow
    End If
End Sub

Private Sub mnuHWW_Click()
    HWW_Tab.Visible = True
    LabelHWW.Visible = True
    ToolbarHWW.Visible = True
    
    SetHWWTabWindow
End Sub

Private Sub mnuOpenWebPage_Click()
    ' 1. check to see if window exists
        ' no, 1. create the window,
            ' 2. on the window put a browser control
        ' yes, check to see if there is a tab
            ' no, 1. create a tab,
                ' 2. create the browser control
            ' yes, 1. create a new tab
                 ' 2. store the previous tab html page
                
    ' gloabl web window
    ' global tab control
    ' global web browser control
    ' previous html pages
         ' no. tabs
         ' html pages array.
End Sub

Private Sub mnuShowLibraryMain_Click()
    LabelTree.Visible = True
    ToolbarTree.Visible = True
    tvTreeView.Visible = True
    
    SetWebTreeWindow
End Sub

Private Sub mnuWWW_Click()
    ' if visible, make it invisible, else make it visible
    ' resize the windows
    
    If WWW_Tab.Visible Then
        WWW_Tab.Visible = False
        LabelWWW.Visible = False
        ToolbarWWW.Visible = False
        
        Form_Resize
    Else
        WWW_Tab.Visible = True
        LabelWWW.Visible = True
        ToolbarWWW.Visible = True
        
        ResizeWindows.SetWWWTabWindow
    End If
    
    
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

