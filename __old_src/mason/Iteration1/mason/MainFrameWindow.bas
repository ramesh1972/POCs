Attribute VB_Name = "MainFrameWindow"
Public gBorderWidth As Long
Public gLabelLeft As Long
Public gMoving As Boolean
Public gClientTop As Long
Public gWebTreeMinWidth As Long
Public gDocumentComboMinWidth As Long
Public gToolbarGap As Long
Public gAddressbarGap As Long

Sub SetStandardWindowProperties()
    gBorderWidth = 40
    gLabelLeft = 20
    gToolbarGap = 20
    gAddressbarGap = 40
    
    If fMainForm.tbToolBar.Visible Then
        fMainForm.ImgSplitter2.Top = (fMainForm.ScaleHeight - fMainForm.tbToolBar.Height) / 2
    Else
        fMainForm.ImgSplitter2.Top = fMainForm.ScaleHeight / 2
    End If
    
    fMainForm.imgSplitter.Width = 100
    fMainForm.ImgSplitter2.Height = 100
    fMainForm.picSplitter.Width = 100
    fMainForm.picSplitter2.Width = 100
    
    fMainForm.picSplitter.BackColor = &H808080
    fMainForm.picSplitter.FillColor = &H808080
    fMainForm.picSplitter.ForeColor = &H80000012
    
    fMainForm.picSplitter2.BackColor = &H808080
    fMainForm.picSplitter2.FillColor = &H808080
    fMainForm.picSplitter2.ForeColor = &H80000012
    
    fMainForm.picSplitter.Visible = False
    fMainForm.picSplitter2.Visible = False
    
    fMainForm.ToolbarTree.Width = 3375
    gWebTreeMinWidth = 4425
    ' 13 15 8 11 9  3 1 2 6 7 5
    fMainForm.ToolbarWWW.Width = 4215
    
    '13 4 12  16 9 3 1 2 6 7 5
    fMainForm.ToolbarHWW.Width = 4215
    
    fMainForm.imgSplitter.Left = gWebTreeMinWidth
    
    gDocumentComboMinWidth = 1000

End Sub

Sub HideAllWindows()
    fMainForm.tvTreeView.Visible = False
    fMainForm.LabelTree.Visible = False
    fMainForm.ToolbarTree.Visible = False
    
    fMainForm.LabelWWW.Visible = False
    fMainForm.ToolbarWWW.Visible = False
    fMainForm.WWW_Tab.Visible = False
    
    fMainForm.LabelHWW.Visible = False
    fMainForm.ToolbarHWW.Visible = False
    fMainForm.HWW_Tab.Visible = False
    
    fMainForm.imgSplitter.Visible = False
    fMainForm.ImgSplitter2.Visible = False
    
    fMainForm.picSplitter.Visible = False
    fMainForm.picSplitter2.Visible = False
End Sub

Public Sub CloseTree()
    fMainForm.LabelTree.Visible = False
    fMainForm.ToolbarTree.Visible = False
    fMainForm.tvTreeView.Visible = False
    fMainForm.imgSplitter.Visible = False
    fMainForm.picSplitter.Visible = False
End Sub

Public Sub CloseWWW()
    fMainForm.LabelWWW.Visible = False
    fMainForm.ToolbarWWW.Visible = False
    fMainForm.WWW_Tab.Visible = False
    fMainForm.ImgSplitter2.Visible = False
    fMainForm.picSplitter2.Visible = False
    
    If Not fMainForm.HWW_Tab.Visible Then
        fMainForm.imgSplitter.Visible = False
        fMainForm.picSplitter.Visible = False
    End If
End Sub

Public Sub CloseHWW()
    fMainForm.LabelHWW.Visible = False
    fMainForm.ToolbarHWW.Visible = False
    fMainForm.HWW_Tab.Visible = False
    fMainForm.ImgSplitter2.Visible = False
    fMainForm.picSplitter2.Visible = False

    If Not fMainForm.WWW_Tab.Visible Then
        fMainForm.imgSplitter.Visible = False
        fMainForm.picSplitter.Visible = False
    End If
End Sub

