VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "shdocvw.dll"
Begin VB.Form frmDocClient 
   Caption         =   "Doc Client - Node Manager Node"
   ClientHeight    =   6630
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7680
   LinkTopic       =   "Form1"
   ScaleHeight     =   6630
   ScaleWidth      =   7680
   StartUpPosition =   3  'Windows Default
   Begin SHDocVwCtl.WebBrowser wbDoc 
      Height          =   6375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   7455
      ExtentX         =   13150
      ExtentY         =   11245
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   "res://C:\WINNT\system32\shdoclc.dll/offcancl.htm#http:///"
   End
End
Attribute VB_Name = "frmDocClient"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    Call Navigate("c:\DocHtml.html")
End Sub

Public Function Navigate(ByVal Url As String)
    wbDoc.Navigate2 (Url)
End Function

Private Sub wbDoc_DocumentComplete(ByVal pDisp As Object, Url As Variant)
    gcon_str = "LocalServer"
    
    If Not gactive_doc Is Nothing Then
        Set gactive_doc = Nothing
    End If
    
    If Not gsrv_data Is Nothing Then
        Set gsrv_data = Nothing
    End If
    
    If Not gcln_data Is Nothing Then
        Set gcln_data = Nothing
    End If
    
    Set gactive_doc = New CHTMLDocument
    Set gsrv_data = New CXMLServerData
    Set gcln_data = New CXMLClientData
        
    Call gactive_doc.set_active_dom_doc(wbDoc.Document)
    
    Call gactive_doc.load_xdoc(0)
    Call gactive_doc.load_xnode(13)
End Sub



