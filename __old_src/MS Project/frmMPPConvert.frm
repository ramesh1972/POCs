VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmMPPConvert 
   Caption         =   "Convert MS Project file to HTML"
   ClientHeight    =   1545
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   1545
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin MSComDlg.CommonDialog wccFileDialog 
      Left            =   4080
      Top             =   960
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton cmdConvert 
      Caption         =   "Convert "
      Height          =   495
      Left            =   240
      TabIndex        =   3
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton cmdBrowse 
      Caption         =   "..."
      Height          =   375
      Left            =   3960
      TabIndex        =   2
      Top             =   120
      Width           =   495
   End
   Begin VB.TextBox txtMPPFile 
      Height          =   375
      Left            =   1440
      TabIndex        =   1
      Top             =   120
      Width           =   2415
   End
   Begin VB.Label lblMPP 
      Caption         =   "MS Project File"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "frmMPPConvert"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 Private Const MAX_PATH = 1024
 Private gProjFile As String

 Private Type BROWSEINFO
     hwndOwner As Long
     pidlRoot As Long
     pszDisplayName As String
     lpszTitle As String
     ulFlags As Long
     lpfn As Long
     lParam As Long
     iImage As Long
 End Type
 
 Private Declare Function SHBrowseForFolder Lib "shell32.dll" ( _
    lpbi As BROWSEINFO _
 ) As Long
 Private Declare Function SHGetPathFromIDList Lib "shell32.dll" ( _
    ByVal pidl As Long, _
    ByVal pszPath As String _
 ) As Boolean
 Private Declare Sub CoTaskMemFree Lib "ole32.dll" ( _
   ByVal lpv As Long _
 )
 
Dim gMSProj As MSProject.Project
Dim gMPPName As String
Dim gWebFilesPath As String
Dim gOutHTMLStr As String

Private Sub cmdBrowse_Click()
    wccFileDialog.Filter = "*.mpp"
    wccFileDialog.ShowOpen
    
    txtMPPFile.Text = wccFileDialog.FileName
End Sub

Private Sub cmdConvert_Click()
    If txtMPPFile.Text = "" Then
        MsgBox "Enter a file name."
        Exit Sub
    End If

    Set gMSProj = CreateObject("MSProject.Project")
   
    gMSProj.Application.FileOpen txtMPPFile.Text
        
    gMSProj.Application.DisplayAlerts = False
    gMSProj.Application.Visible = False
    
    Call ProcessProjectFile
    
    ' get the web folder
    Dim lCaption As String
    Dim lSh As New Shell
    lCaption = "Select a Web folder." ' (e.g. c:\inetpub\wwwroot\)" & vbCrLf & "A msproj folder will be created under this folder"
    gWebFilesPath = BrowseForFolderEx(Me.hWnd, lCaption, ssfDESKTOP)

    MsgBox gWebFilesPath
    Exit Sub
    Call ProcessHTMLFile
    
    ' Open the web browser
    gMSProj.Application.FileCloseAll
    
    Set gMSProj = Nothing
    Set lTS = Nothing
End Sub
Public Sub SetProjFile(ByVal piProjFile As String)
    gProjFile = piProjFile
End Sub
Public Function GetTaskTree() As String
    Dim lTask As MSProject.Task
    Dim lTaskCount As Long
    Dim lProj As MSProject.Project
    
    Set gMSProj = CreateObject("MSProject.Project")
    
    gMSProj.Application.FileOpen gProjFile
    gMSProj.Application.DisplayAlerts = False
    gMSProj.Application.Visible = False
    
    Set lProj = gMSProj.Application.ActiveProject
    gMPPName = lProj.Name
    gMPPName = Mid(gMPPName, 1, Len(gMPPName) - 4)
    
    lTaskCount = 0
    lTaskCount = lProj.Tasks.Count
    
    For Each lTask In lProj.Tasks
        lUrl = "tree-view.asp" & "?MSProject=" & gMPPName & "&TaskID=" & lTask.Index
        
        If lTask.OutlineChildren.Count > 0 Then
            gOutHTMLStr = gOutHTMLStr & "dbAdd( true ,'" & lTask.Name & "','" & lUrl & "' ," & Val(lTask.OutlineLevel - 1) & ", '' , 0);" & vbCrLf
        Else
            gOutHTMLStr = gOutHTMLStr & "dbAdd( false,'" & lTask.Name & "','" & lUrl & "' ," & Val(lTask.OutlineLevel - 1) & ", '' , 0);" & vbCrLf
        End If
    Next
    
    GetTaskTree = gOutHTMLStr
End Function

Private Sub ProcessHTMLFile()
    Dim lfileObj As Scripting.FileSystemObject
    Dim lTS As Scripting.TextStream
    Dim lWebFilesPath As String
    Dim lFileStr As String
    Dim lWebBasePath As String

    lWebFilesPath = "C:\Inetpub\wwwroot\msproj"
    lWebBasePath = App.Path & "\web"
    
    Set lfileObj = CreateObject("Scripting.FileSystemObject")
    If Not lfileObj.FolderExists(lWebBasePath & "\" & gMPPName) Then
        Call lfileObj.CreateFolder(lWebBasePath & "\" & gMPPName)
    End If
    
    ' Open the base files
    Set lTS = lfileObj.OpenTextFile(lWebBasePath & "\" & "tree-contents.html")
    
    ' read all the contents
    lFileStr = lTS.ReadAll
    lTS.Close
    
    ' Replace the INSERT_TREE_DBADD_FUNCTION label
    lFileStr = Replace(lFileStr, "<!-- INSERT_TREE_DBADD_FUNCTIONS -->", gOutHTMLStr, 1, , vbTextCompare)

    'save the tree-contents html string to C
    Set lTS = lfileObj.CreateTextFile(lWebBasePath & "\" & gMPPName & "\" & gMPPName & "-contents.html")
    lTS.Write (lFileStr)
    lTS.Close
    
    ' open the frameset
    Set lTS = lfileObj.OpenTextFile(lWebBasePath & "\" & "tree-frameset.html")
    
    ' read all the contents
    lFileStr = lTS.ReadAll
    lTS.Close
    
    ' Replace the INSERT_TREE_DBADD_FUNCTION label
    lFileStr = Replace(lFileStr, "<!-- INSERT_CONTENTS_FILE -->", gMPPName & "-contents.html", 1, , vbTextCompare)
    lFileStr = Replace(lFileStr, "<!-- INSERT_NODE_VIEW_FILE -->", gMPPName & "-view.asp", 1, , vbTextCompare)
    
    ' save the tree-frameset
    Set lTS = lfileObj.CreateTextFile(lWebBasePath & "\" & gMPPName & "\default.html")
    lTS.Write (lFileStr)
    lTS.Close
    
    ' copy the view file
    Call lfileObj.CopyFile(lWebBasePath & "\" & "tree-node-view.asp", lWebBasePath & "\" & gMPPName & "\" & gMPPName & "-view.asp")
    
    ' copy the ppt file
    Call lfileObj.CopyFile(txtMPPFile.Text, lWebBasePath & "\" & gMPPName & "\" & gMPPName & ".mpp")
    
    ' Move the files to the user selected folder
    If Not lfileObj.FolderExists(lWebFilesPath) Then
        Call lfileObj.CreateFolder(lWebFilesPath)
        Call lfileObj.CreateFolder(lWebFilesPath & "\images")
    End If
    
    If Not lfileObj.FolderExists(lWebFilesPath & "\" & gMPPName) Then
        Call lfileObj.CreateFolder(lWebFilesPath & "\" & gMPPName)
    End If
    
    Call lfileObj.CopyFolder(lWebBasePath & "\" & gMPPName, lWebFilesPath & "\" & gMPPName)
    Call lfileObj.CopyFolder(lWebBasePath & "\images", lWebFilesPath & "\images")
End Sub

Function BrowseForFolderEx(ByVal hWnd As Long, _
   ByVal title As String, ByVal options As Long, _
   Optional root As Variant) As String
 
     Dim bi As BROWSEINFO
     Dim lpIdList As Long
     Dim sFolderName As String
     
     ' initializes the BROWSEINFO structure
     bi.hwndOwner = hWnd
     bi.lpszTitle = title
     bi.ulFlags = options
     
     ' defaults the missing argument to the DESKTOP
     If IsMissing(root) Then
         bi.pidlRoot = 0
     Else
         bi.pidlRoot = root
     End If
 
     ' calls the API function
     lpIdList = SHBrowseForFolder(bi)
         
     ' converts the PIDL to a path name
     If lpIdList Then
        sFolderName = String(MAX_PATH, 0)
        h = SHGetPathFromIDList(lpIdList, sFolderName)
        BrowseForFolderEx = sFolderName
        CoTaskMemFree lpIdList
     End If
 End Function


