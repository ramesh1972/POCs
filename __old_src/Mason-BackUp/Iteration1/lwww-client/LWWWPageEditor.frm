VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "shdocvw.dll"
Begin VB.Form Ctrl_Frm_Mason 
   Caption         =   "Local Wide Web Wearver Page Editor"
   ClientHeight    =   7185
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7785
   LinkTopic       =   "Form1"
   ScaleHeight     =   7185
   ScaleWidth      =   7785
   StartUpPosition =   3  'Windows Default
   Begin SHDocVwCtl.WebBrowser Ctrl_WebBrowser_HWW 
      Height          =   3135
      Left            =   120
      TabIndex        =   5
      Top             =   3960
      Width           =   7095
      ExtentX         =   12515
      ExtentY         =   5530
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   ""
   End
   Begin VB.CommandButton Ctrl_Btn_ParseWWWPage 
      Caption         =   "Go"
      Height          =   255
      Left            =   5760
      TabIndex        =   4
      Top             =   120
      Width           =   375
   End
   Begin VB.CommandButton Ctrl_Btn_BrowseWWW 
      Caption         =   "Browse"
      Height          =   255
      Left            =   4920
      TabIndex        =   3
      Top             =   120
      Width           =   735
   End
   Begin VB.TextBox Ctrl_Txt_WWWURL 
      Height          =   285
      Left            =   1200
      ScrollBars      =   3  'Both
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   120
      Width           =   3495
   End
   Begin SHDocVwCtl.WebBrowser Ctrl_WebBrowser_WWW 
      Height          =   3375
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   7095
      ExtentX         =   12515
      ExtentY         =   5953
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      NoWebView       =   0   'False
      HideFileNames   =   0   'False
      SingleClick     =   0   'False
      SingleSelection =   0   'False
      NoFolders       =   0   'False
      Transparent     =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   ""
   End
   Begin VB.Label Ctrl_Lbl_EnterURL 
      Caption         =   "Web page"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   975
   End
End
Attribute VB_Name = "Ctrl_Frm_Mason"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim gObj_WWWBody As HTMLBody
Dim gObj_HWWBody As HTMLBody
Dim gDivCount As Long
Dim gHWWDivCount As Long
Dim gIsMouseDown As Boolean
Dim gIsSelectedObjectCreated As Boolean
Dim gIsSelectedObjectInserted As Boolean
Dim gObj_SelectedDiv As HTMLDivElement
Dim gObj_DivToBeInserted As HTMLDivElement
Dim gNewDivID As Long
Dim gObj_WWWWindow As HTMLWindow2
Dim gObj_HWWWindow As HTMLWindow2

Public WithEvents gObj_WWWBrowser As SHDocVw.WebBrowser
Attribute gObj_WWWBrowser.VB_VarHelpID = -1
Public WithEvents gObj_WWWDoc As HTMLDocument
Attribute gObj_WWWDoc.VB_VarHelpID = -1

Public WithEvents gObj_HWWBrowser As SHDocVw.WebBrowser
Attribute gObj_HWWBrowser.VB_VarHelpID = -1
Public WithEvents gObj_HWWDoc As HTMLDocument
Attribute gObj_HWWDoc.VB_VarHelpID = -1

Private Sub Form_Load()
    gDivCount = 0
    gHWWDivCount = 0
    gNewDivID = 0
    gIsMouseDown = False
    gIsSelectedObjectCreated = False
    gNewDivID = 0
    Set gObj_SelectedDiv = Nothing
    
    Set gObj_WWWBrowser = Ctrl_WebBrowser_WWW
    Set gObj_HWWBrowser = Ctrl_WebBrowser_HWW
    
    Call RePositionControls
End Sub

Private Sub Form_Resize()
    Call RePositionControls
End Sub

Private Sub RePositionControls()
    Ctrl_Lbl_EnterURL.Top = Ctrl_Frm_Mason.ScaleTop + 100
    Ctrl_Lbl_EnterURL.Left = Ctrl_Frm_Mason.ScaleLeft + 100
    Ctrl_Lbl_EnterURL.Width = 800
    
    Ctrl_Btn_ParseWWWPage.Top = Ctrl_Frm_Mason.ScaleTop + 100
    Ctrl_Btn_ParseWWWPage.Width = 400
    Ctrl_Btn_ParseWWWPage.Left = Ctrl_Frm_Mason.Width - Ctrl_Btn_ParseWWWPage.Width - 200
    
    Ctrl_Btn_BrowseWWW.Top = Ctrl_Frm_Mason.ScaleTop + 100
    Ctrl_Btn_BrowseWWW.Width = 700
    Ctrl_Btn_BrowseWWW.Left = Ctrl_Btn_ParseWWWPage.Left - Ctrl_Btn_BrowseWWW.Width - 100
    
    Ctrl_Txt_WWWURL.Top = Ctrl_Frm_Mason.ScaleTop + 100
    Ctrl_Txt_WWWURL.Left = Ctrl_Lbl_EnterURL.Left + Ctrl_Lbl_EnterURL.Width + 100
    Ctrl_Txt_WWWURL.Width = Ctrl_Btn_BrowseWWW.Left - Ctrl_Txt_WWWURL.Left - 100
    
    Ctrl_Lbl_EnterURL.Height = 200
    Ctrl_Txt_WWWURL.Height = Ctrl_Btn_BrowseWWW.Height = Ctrl_Btn_ParseWWWPage.Height = 100
    
    Ctrl_WebBrowser_WWW.Top = 100 + Ctrl_Lbl_EnterURL.Height + 200
    Ctrl_WebBrowser_WWW.Left = Ctrl_Frm_Mason.ScaleLeft + 100
    Ctrl_WebBrowser_WWW.Width = Ctrl_Frm_Mason.Width - 300
    Ctrl_WebBrowser_WWW.Height = (Ctrl_Frm_Mason.Height - 100 - Ctrl_Lbl_EnterURL.Height - 200 - 500) / 2
    
    Ctrl_WebBrowser_HWW.Top = 100 + Ctrl_Lbl_EnterURL.Height + 200 + Ctrl_WebBrowser_WWW.Height + 100
    Ctrl_WebBrowser_HWW.Left = Ctrl_Frm_Mason.ScaleLeft + 100
    Ctrl_WebBrowser_HWW.Width = Ctrl_Frm_Mason.Width - 300
    Ctrl_WebBrowser_HWW.Height = (Ctrl_Frm_Mason.Height - 100 - Ctrl_Lbl_EnterURL.Height - 200 - 500) / 2 - 100
End Sub

Private Sub Ctrl_Btn_BrowseWWW_Click()
    gDivCount = 0
    gHWWDivCount = 0
    gNewDivID = 0
    gIsMouseDown = False
    gIsSelectedObjectCreated = False
    gNewDivID = 0
    Set gObj_SelectedDiv = Nothing

    Ctrl_Txt_WWWURL.Text = "Http://localhost/lwww/temp.htm"

    Ctrl_WebBrowser_WWW.Navigate2 Ctrl_Txt_WWWURL.Text
    Ctrl_WebBrowser_HWW.Navigate2 "Http://localhost/lwww/blank.htm"
End Sub

Private Sub Ctrl_Btn_ParseWWWPage_Click()
    Call ParseWWWPage
End Sub

Public Function ParseWWWPage() As String
    Dim HTMLPageStr As String
    
    HTMLPageStr = AddDivTagsToWWWPage(gObj_WWWDoc.documentElement.outerHTML)
    gObj_WWWDoc.body.innerHTML = HTMLPageStr
    
    Call ResizeDivTags(gObj_WWWDoc.documentElement)
End Function

Function AddDivTagsToWWWPage(ByVal PageStr As String) As String
    Dim NewPageStr As String
    Dim CharCount As Long
    Dim DivStr As String
    
    DivStr = "<Div id='HeadDiv' style='padding-right:1;padding-left:1;padding-top:1;border-top:4px solid blue;border-bottom:0;border-left:0;border-right:0' nowrap>"
    CharCount = Len(PageStr)
    
    For Idx = 1 To CharCount
        ' Find <xx> tag and put a <div> before
        Char = Mid(PageStr, Idx, 1)
        NextChar = Mid(PageStr, Idx + 1, 1)
        If Char = "<" Then
            If NextChar <> "/" Then
                tag = GetTagOnWWWPage(PageStr, Idx + 1)
                NonBlockTag = CheckIfNonBlockTag(tag)
                SingleTag = CheckIfTagHasNoEndTag(tag)
                
                If NonBlockTag = True And FoundNonBlockTag = False Then
                    NewPageStr = NewPageStr + Char
                    FoundNonBlockTag = True
                ElseIf SingleTag = True Then
                    NewPageStr = NewPageStr + DivStr + Char
                    FoundSingleTagBegin = True
                Else
                    NewPageStr = NewPageStr + DivStr + Char
                End If
                
                FoundEndingTagBegin = False
            Else
                tag = GetTagOnWWWPage(PageStr, Idx + 2)
                NonBlockTag = CheckIfNonBlockTag(tag)
                If NonBlockTag = True Then
                    FoundNonBlockTag = True
                Else
                    FoundNonBlockTag = False
                End If
                
                NewPageStr = NewPageStr + Char
                
                FoundEndingTagBegin = True
                FoundSingleTagBegin = False
            End If
        ElseIf Char = ">" Then
            NewPageStr = NewPageStr + Char
            If FoundEndingTagBegin = True And FoundNonBlockTag = False Then
                NewPageStr = NewPageStr + "</Div>"
                FoundEndingTagBegin = False
            ElseIf FoundSingleTagBegin = True Then
                NewPageStr = NewPageStr + "</Div>"
                FoundSingleTagBegin = False
            Else
                FoundNonBlockTag = False
            End If
        Else
            NewPageStr = NewPageStr + Char
        End If
    Next
    
    AddDivTagsToWWWPage = NewPageStr
    
End Function

Function GetTagOnWWWPage(ByVal PageStr As String, ByVal Index As Long) As String
    Dim TagStr As String
    Dim Char As String
    
    For Idx = Index To Len(PageStr)
        Char = Mid(PageStr, Idx, 1)
        
        If Char = "<" Then
        ElseIf Char <> " " And Char <> ">" Then
            TagStr = TagStr + Char
        Else
            Exit For
        End If
    Next
    
    GetTagOnWWWPage = Trim(TagStr)
End Function

Function CheckIfNonBlockTag(ByVal tag As String) As Boolean
    If tag = "HTML" Or _
       tag = "HEAD" Or _
       tag = "META" Or _
       tag = "TITLE" Or _
       tag = "SCRIPT" Or _
       tag = "BODY" Or _
       tag = "TBODY" Then
        CheckIfNonBlockTag = True
    Else
        CheckIfNonBlockTag = False
    End If
End Function

Function CheckIfTagHasNoEndTag(ByVal tag As String) As Boolean
    If tag = "IMG" Or _
       tag = "INPUT" Or _
       tag = "BR" _
    Then
        CheckIfTagHasNoEndTag = True
    Else
        CheckIfTagHasNoEndTag = False
    End If
End Function

Public Function ResizeDivTags(ByVal Elem As IHTMLElement) As String
    Dim Count As Long
    Dim SubElem As IHTMLElement
    Dim DivElem As IHTMLDivElement
    Dim NextElem As IHTMLElement
    
    If Elem Is Nothing Then GoTo ExitEnd
    Count = Elem.children.length

    For Idx = 0 To Count - 1
        Set SubElem = Elem.children.Item(Idx)
        Call ResizeDivTags(SubElem)
    Next

    If Elem.tagName = "DIV" And Elem.Id = "HeadDiv" Then
        Elem.Id = "HeadDiv_" + CStr(gDivCount)
        gDivCount = gDivCount + 1
        Set DivElem = Elem
        Set NextElem = DivElem.children(0)
        
        If NextElem Is Nothing Then
        Else
            DivElem.Style.Left = NextElem.Style.Left
            DivElem.Style.Top = NextElem.Style.Top
            DivElem.Style.Width = NextElem.offsetWidth
            DivElem.Style.Height = NextElem.offsetHeight
        End If
    End If

ExitEnd:
End Function

Private Sub gObj_WWWBrowser_BeforeNavigate2(ByVal pDisp As Object, URL As Variant, Flags As Variant, TargetFrameName As Variant, PostData As Variant, Headers As Variant, Cancel As Boolean)
    ' Nothing here
End Sub

Private Sub gObj_WWWBrowser_DocumentComplete(ByVal pDisp As Object, URL As Variant)
    On Error Resume Next
    If pDisp Is Ctrl_WebBrowser_WWW.Object Then
        Set gObj_WWWDoc = Ctrl_WebBrowser_WWW.Document
        Set gObj_WWWWindow = gObj_WWWDoc.parentWindow
        Set gObj_WWWBody = gObj_WWWDoc.body
    End If
End Sub

Private Function gObj_WWWDoc_onclick() As Boolean
    If gIsMouseDown And Not (gObj_SelectedDiv Is Nothing) Then
        gIsMouseDown = False
        gObj_SelectedDiv.removeNode (True)
        Set gObj_SelectedDiv = Nothing
        gIsSelectedObjectCreated = False
        gDragging = True
    End If
End Function

Private Sub gObj_WWWDoc_onmousedown()
    If gObj_WWWWindow.window.event.srcElement.tagName = "DIV" Then
        gIsMouseDown = True
    End If
End Sub

Public Sub gObj_WWWDoc_onMouseMove()
    Dim curWnd As HTMLWindow2
    Dim curElement As IHTMLElement
    Dim tag As String
    
    If gIsMouseDown = True Then
        If Not gIsSelectedObjectCreated Then
            Set curWnd = Ctrl_WebBrowser_WWW.Document.parentWindow
            Set curElement = curWnd.event.srcElement
            tag = curElement.tagName
            
            If tag = "DIV" Then
                Set gObj_SelectedDiv = curElement.cloneNode(True)
                Call gObj_WWWDoc.body.appendChild(gObj_SelectedDiv)
                gObj_SelectedDiv.Id = curElement.Id & gNewDivID
                gNewDivID = gNewDivID + 1
                gIsSelectedObjectCreated = True
                gIsSelectedObjectInserted = False
            End If
        End If

        If gObj_SelectedDiv Is Nothing Then
        Else
            Call MakeSelTagPosAbsolute(gObj_SelectedDiv)

            gObj_SelectedDiv.Style.posLeft = gObj_WWWBody.scrollLeft + gObj_WWWWindow.window.event.x
            gObj_SelectedDiv.Style.posTop = gObj_WWWBody.scrollTop + gObj_WWWWindow.window.event.y
            
        End If
    End If
End Sub

Public Function MakeSelTagPosAbsolute(ByRef pObj As IHTMLElement)
    Call pObj.Style.setAttribute("position", "absolute")
End Function

Private Sub gObj_HWWBrowser_BeforeNavigate2(ByVal pDisp As Object, URL As Variant, Flags As Variant, TargetFrameName As Variant, PostData As Variant, Headers As Variant, Cancel As Boolean)
    ' Nothing here
End Sub

Private Sub gObj_HWWBrowser_DocumentComplete(ByVal pDisp As Object, URL As Variant)
    On Error Resume Next
    If pDisp Is Ctrl_WebBrowser_HWW.Object Then
        Set gObj_HWWDoc = Ctrl_WebBrowser_HWW.Document
        Set gObj_HWWWindow = gObj_HWWDoc.parentWindow
        Set gObj_HWWBody = gObj_HWWDoc.body
    End If
End Sub

Public Sub gObj_HWWDoc_onMouseMove()
    Dim curWnd As HTMLWindow2
    Dim curElement As IHTMLDOMNode
    Dim tag As String

    If gIsSelectedObjectCreated Then
        If Not gIsSelectedObjectInserted Then
            DivStr = "<Div id='InsHeadDiv" + CStr(gHWWDivCount) + "' style='padding-right:1;padding-left:1;padding-top:1;border-top:4px solid blue;border-bottom:0;border-left:0;border-right:0' nowrap>"
            DivStr = DivStr + gObj_SelectedDiv.innerHTML + "</Div>"
            
            gObj_HWWDoc.body.innerHTML = gObj_HWWDoc.body.innerHTML + DivStr
            Set gObj_DivToBeInserted = gObj_HWWDoc.All("InsHeadDiv" + CStr(gHWWDivCount))
            gHWWDivCount = gHWWDivCount + 1
            gIsSelectedObjectInserted = True
            Call gObj_WWWDoc_onclick
        End If
    End If
      
    If gIsSelectedObjectInserted Then
        If gObj_DivToBeInserted Is Nothing Then
        Else
            Call MakeSelTagPosAbsolute(gObj_DivToBeInserted)

            gObj_DivToBeInserted.Style.posLeft = gObj_HWWBody.scrollLeft + gObj_HWWWindow.window.event.x
            gObj_DivToBeInserted.Style.posTop = gObj_HWWBody.scrollTop + gObj_HWWWindow.window.event.y
        End If
    End If
End Sub

Private Sub gObj_HWWDoc_onmouseup()
    gIsMouseDownOnHWW = False
    Set gObj_DivToBeInserted = Nothing
    gIsSelectedObjectInserted = True
End Sub

