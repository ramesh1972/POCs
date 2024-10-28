Attribute VB_Name = "ResizeWindows"
Public Sub SetAddressBar()
    fMainForm.LabelProtocol.Height = 275
    fMainForm.LabelProtocol.Width = 620
    fMainForm.LabelProtocol.Alignment = vbAlignCenter
    
    fMainForm.LabelAddress.Height = 275
    fMainForm.LabelAddress.Width = 570
    fMainForm.LabelAddress.Alignment = vbAlignCenter
    
    fMainForm.LabelDocument.Height = 275
    fMainForm.LabelDocument.Width = 765
    fMainForm.LabelDocument.Alignment = vbAlignCenter
    
    fMainForm.ButtonGo.Height = 315
    fMainForm.ButtonGo.Width = 975
        
    fMainForm.TextBoxProtocol.Height = 240
    fMainForm.TextBoxAddress.Height = 240
    fMainForm.TextBoxDocument.Height = 240
    
    URLLabelLeft = gLabelLeft * 2
    If fMainForm.tbToolBar.Visible Then
        gClientTop = fMainForm.tbToolBar.Height + gToolbarGap
    Else
        gClientTop = gToobarGap
    End If
    
    fMainForm.LabelProtocol.Top = gClientTop + 60
    fMainForm.LabelAddress.Top = gClientTop + 60
    fMainForm.LabelDocument.Top = gClientTop + 60
    
    fMainForm.ComboProtocol.Top = gClientTop
    fMainForm.TextBoxProtocol.Top = gClientTop + 40
    
    fMainForm.ComboAddress.Top = gClientTop
    fMainForm.TextBoxAddress.Top = gClientTop + 40
    
    fMainForm.ComboDocument.Top = gClientTop
    fMainForm.TextBoxDocument.Top = gClientTop + 40
    
    fMainForm.ButtonGo.Top = gClientTop
    
    fMainForm.LabelProtocol.Left = URLLabelLeft
    fMainForm.ComboProtocol.Left = URLLabelLeft + fMainForm.LabelProtocol.Width + URLLabelLeft
    fMainForm.TextBoxProtocol.Left = 2 * URLLabelLeft + fMainForm.LabelProtocol.Width + URLLabelLeft
    
    fMainForm.ComboProtocol.Width = 975
    fMainForm.TextBoxProtocol.Width = 650
    
    fMainForm.LabelAddress.Left = fMainForm.ComboProtocol.Left + fMainForm.ComboProtocol.Width + URLLabelLeft
    fMainForm.ComboAddress.Left = fMainForm.LabelAddress.Left + fMainForm.LabelAddress.Width + URLLabelLeft
    fMainForm.TextBoxAddress.Left = fMainForm.LabelAddress.Left + fMainForm.LabelAddress.Width + 2 * URLLabelLeft
    
    fMainForm.ComboAddress.Width = 3200
    fMainForm.TextBoxAddress.Width = 2860
    
    fMainForm.LabelDocument.Left = fMainForm.ComboAddress.Left + fMainForm.ComboAddress.Width + URLLabelLeft
    fMainForm.ComboDocument.Left = fMainForm.LabelDocument.Left + fMainForm.LabelDocument.Width + URLLabelLeft
    fMainForm.TextBoxDocument.Left = fMainForm.LabelDocument.Left + fMainForm.LabelDocument.Width + 2 * URLLabelLeft
    
    ComboWidth = fMainForm.ScaleWidth - (URLLabelLeft + fMainForm.LabelProtocol.Width + fMainForm.ComboProtocol.Width + URLLabelLeft) - _
                                          (URLLabelLeft + fMainForm.LabelAddress.Width + fMainForm.ComboAddress.Width + URLLabelLeft) - _
                                          (URLLabelLeft + fMainForm.LabelDocument.Width + URLLabelLeft) - (URLLabelLeft + fMainForm.ButtonGo.Width)
                                          
    If ComboWidth < gDocumentComboMinWidth Then
        fMainForm.ComboDocument.Width = gDocumentComboMinWidth
    Else
        fMainForm.ComboDocument.Width = ComboWidth
    End If
    
    fMainForm.TextBoxDocument.Width = fMainForm.ComboDocument.Width - 310
    
    fMainForm.ButtonGo.Left = fMainForm.ComboDocument.Left + fMainForm.ComboDocument.Width + URLLabelLeft
    
    gClientTop = gClientTop + fMainForm.ButtonGo.Height + gAddressbarGap
End Sub

Public Sub SetWebTreeWindow()
    fMainForm.LabelWWW.Height = 330
    fMainForm.ToolbarWWW.Height = 330
    fMainForm.LabelHWW.Height = 330
    fMainForm.ToolbarHWW.Height = 330
    fMainForm.LabelTree.Height = 330
    fMainForm.ToolbarTree.Height = 330
    
    fMainForm.ToolbarTree.Visible = True
    fMainForm.LabelTree.Visible = True
    
    fMainForm.tvTreeView.Left = 0
    fMainForm.LabelTree.Left = gLabelLeft

    fMainForm.LabelTree.Top = gClientTop
    fMainForm.ToolbarTree.Top = gClientTop
    fMainForm.tvTreeView.Top = gClientTop + fMainForm.LabelTree.Height
    
    fMainForm.tvTreeView.Height = fMainForm.ScaleHeight - (fMainForm.LabelTree.Top + fMainForm.LabelTree.Height)
    
    If fMainForm.WWW_Tab.Visible Or fMainForm.HWW_Tab.Visible Then
        fMainForm.imgSplitter.Visible = True
        fMainForm.imgSplitter.Top = gClientTop
        fMainForm.imgSplitter.Height = fMainForm.ScaleHeight - gClientTop
        fMainForm.picSplitter.Height = fMainForm.ScaleHeight - gClientTop
        If fMainForm.imgSplitter.Left < gWebTreeMinWidth Then
            treeright = gWebTreeMinWidth
        Else
            treeright = fMainForm.imgSplitter.Left
        End If
        
        fMainForm.imgSplitter.Left = treeright
        fMainForm.picSplitter.Left = treeright
    Else
        treeright = gWebTreeMinWidth
    End If
    
    fMainForm.tvTreeView.Width = treeright
    fMainForm.LabelTree.Width = treeright - fMainForm.ToolbarTree.Width - gLabelLeft
    fMainForm.ToolbarTree.Left = fMainForm.LabelTree.Left + fMainForm.LabelTree.Width
    
    If fMainForm.WWW_Tab.Visible And fMainForm.HWW_Tab.Visible Then
        fMainForm.ImgSplitter2.Width = fMainForm.ScaleWidth - fMainForm.tvTreeView.Width - fMainForm.imgSplitter.Width
        fMainForm.ImgSplitter2.Left = fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width
    End If
    
    If fMainForm.WWW_Tab.Visible = True Then
        fMainForm.tvTreeView.Width = treeright
        
        fMainForm.LabelWWW.Left = fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width + gLabelLeft
        fMainForm.LabelWWW.Caption = "Hello World Wide Web"
        fMainForm.LabelWWW.Width = fMainForm.ScaleWidth - fMainForm.ToolbarWWW.Width - fMainForm.tvTreeView.Width - fMainForm.imgSplitter.Width - gLabelLeft
        fMainForm.ToolbarWWW.Left = fMainForm.LabelWWW.Left + fMainForm.LabelWWW.Width
        
        fMainForm.WWW_Tab.Left = fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width
        fMainForm.WWW_Tab.Width = fMainForm.ScaleWidth - fMainForm.tvTreeView.Width - fMainForm.imgSplitter.Width
    End If
    
    If fMainForm.HWW_Tab.Visible = True Then
        fMainForm.tvTreeView.Width = fMainForm.imgSplitter.Left
        
        fMainForm.LabelHWW.Left = fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width + gLabelLeft
        fMainForm.LabelHWW.Caption = "Hello Home Wide Web"
        fMainForm.LabelHWW.Width = fMainForm.ScaleWidth - fMainForm.ToolbarHWW.Width - fMainForm.tvTreeView.Width - fMainForm.imgSplitter.Width - gLabelLeft
        fMainForm.ToolbarHWW.Left = fMainForm.LabelHWW.Left + fMainForm.LabelHWW.Width
        
        fMainForm.HWW_Tab.Left = fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width
        fMainForm.HWW_Tab.Width = fMainForm.ScaleWidth - fMainForm.tvTreeView.Width - fMainForm.imgSplitter.Width
    End If
    
    fMainForm.ToolbarTree.Refresh
End Sub

Public Sub SetWWWTabWindow()
    Dim ImgSplitter2Width As Long
    Dim ClientTop As Long
    
    fMainForm.LabelWWW.Height = 330
    fMainForm.ToolbarWWW.Height = 330
    
    fMainForm.LabelWWW.Top = gClientTop
    fMainForm.ToolbarWWW.Top = gClientTop
    fMainForm.WWW_Tab.Top = gClientTop + fMainForm.LabelWWW.Height
    
    If fMainForm.tvTreeView.Visible Then
        ImgSplitter2Width = fMainForm.ScaleWidth - (fMainForm.imgSplitter.Width + fMainForm.tvTreeView.Width)
        
        fMainForm.imgSplitter.Visible = True
        
        fMainForm.picSplitter.Left = fMainForm.tvTreeView.Width
        fMainForm.imgSplitter.Left = fMainForm.tvTreeView.Width

        fMainForm.imgSplitter.Top = gClientTop
        fMainForm.picSplitter.Top = gClientTop
        
        fMainForm.imgSplitter.Height = fMainForm.ScaleHeight - gClientTop
        fMainForm.picSplitter.Height = fMainForm.ScaleHeight - gClientTop
        
        fMainForm.LabelWWW.Left = fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width + gLabelLeft
        fMainForm.LabelWWW.Width = fMainForm.ScaleWidth - (fMainForm.ToolbarWWW.Width + fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width + gLabelLeft)
        fMainForm.LabelWWW.Caption = "Hello World Wide Web"
        fMainForm.ToolbarWWW.Left = fMainForm.LabelWWW.Left + fMainForm.LabelWWW.Width
            
        fMainForm.WWW_Tab.Left = fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width
        fMainForm.WWW_Tab.Width = fMainForm.ScaleWidth - (fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width)
    Else
        ImgSplitter2Width = fMainForm.ScaleWidth
        
        fMainForm.imgSplitter.Visible = False
        fMainForm.picSplitter.Visible = False
        
        fMainForm.LabelWWW.Left = gLabelLeft
        fMainForm.LabelWWW.Width = fMainForm.ScaleWidth - fMainForm.ToolbarWWW.Width
        fMainForm.ToolbarWWW.Left = fMainForm.LabelWWW.Width
        
        fMainForm.WWW_Tab.Left = 0
        fMainForm.WWW_Tab.Width = fMainForm.ScaleWidth
    End If
    
    If fMainForm.HWW_Tab.Visible Then
        fMainForm.ImgSplitter2.Visible = True
        fMainForm.ImgSplitter2.Width = ImgSplitter2Width
        fMainForm.ImgSplitter2.Left = fMainForm.WWW_Tab.Left
        
        fMainForm.LabelHWW.Top = fMainForm.ImgSplitter2.Top + fMainForm.ImgSplitter2.Height
        fMainForm.ToolbarHWW.Top = fMainForm.ImgSplitter2.Top + fMainForm.ImgSplitter2.Height
        
        fMainForm.WWW_Tab.Height = fMainForm.ImgSplitter2.Top - fMainForm.WWW_Tab.Top
        fMainForm.HWW_Tab.Top = fMainForm.WWW_Tab.Height + fMainForm.WWW_Tab.Top + fMainForm.ImgSplitter2.Height + fMainForm.LabelHWW.Height
        fMainForm.HWW_Tab.Height = fMainForm.ScaleHeight - gClientTop - fMainForm.WWW_Tab.Height - fMainForm.LabelWWW.Height - fMainForm.ImgSplitter2.Height - fMainForm.LabelHWW.Height
    Else
        fMainForm.ImgSplitter2.Visible = False
        fMainForm.WWW_Tab.Height = fMainForm.ScaleHeight - fMainForm.WWW_Tab.Top
    End If
End Sub

Public Sub SetHWWTabWindow()
    Dim ImgSplitter2Width As Long
    Dim ClientTop As Long
    
    fMainForm.LabelHWW.Height = 330
    fMainForm.ToolbarHWW.Height = 330
    
    fMainForm.LabelHWW.Top = gClientTop
    fMainForm.ToolbarHWW.Top = gClientTop
    fMainForm.HWW_Tab.Top = gClientTop + fMainForm.LabelHWW.Height

    
    If fMainForm.tvTreeView.Visible Then
        ImgSplitter2Width = fMainForm.ScaleWidth - fMainForm.imgSplitter.Width - fMainForm.tvTreeView.Width
        
        fMainForm.imgSplitter.Visible = True
        fMainForm.picSplitter.Left = fMainForm.tvTreeView.Width
        fMainForm.imgSplitter.Left = fMainForm.tvTreeView.Width

        fMainForm.imgSplitter.Top = gClientTop
        fMainForm.picSplitter.Top = gClientTop
        
        fMainForm.imgSplitter.Height = fMainForm.ScaleHeight - gClientTop
        fMainForm.picSplitter.Height = fMainForm.ScaleHeight - gClientTop
        
        fMainForm.LabelHWW.Left = fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width + gLabelLeft
        fMainForm.LabelHWW.Caption = "Hello Home Wide Web"
        fMainForm.LabelHWW.Width = fMainForm.ScaleWidth - (fMainForm.ToolbarHWW.Width + fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width + gLabelLeft)
        fMainForm.ToolbarHWW.Left = fMainForm.LabelHWW.Left + fMainForm.LabelHWW.Width + gLabelLeft
        
        fMainForm.HWW_Tab.Left = fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width
        fMainForm.HWW_Tab.Width = fMainForm.ScaleWidth - (fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width)
    Else
        fMainForm.imgSplitter.Visible = False
        ImgSplitter2Width = fMainForm.ScaleWidth
        
        fMainForm.LabelHWW.Left = gLabelLeft
        fMainForm.LabelHWW.Width = fMainForm.ScaleWidth - fMainForm.ToolbarHWW.Width
        fMainForm.ToolbarHWW.Left = fMainForm.LabelHWW.Width
       
        fMainForm.HWW_Tab.Left = 0
        fMainForm.HWW_Tab.Width = fMainForm.ScaleWidth
    End If
    
    If fMainForm.WWW_Tab.Visible Then
        fMainForm.ImgSplitter2.Visible = True
        fMainForm.ImgSplitter2.Width = ImgSplitter2Width
        
        fMainForm.WWW_Tab.Height = fMainForm.ImgSplitter2.Top - fMainForm.WWW_Tab.Top
        
        fMainForm.LabelHWW.Top = fMainForm.WWW_Tab.Top + fMainForm.WWW_Tab.Height + fMainForm.ImgSplitter2.Height
        fMainForm.ToolbarHWW.Top = fMainForm.WWW_Tab.Top + fMainForm.WWW_Tab.Height + fMainForm.ImgSplitter2.Height
        
        fMainForm.HWW_Tab.Top = fMainForm.WWW_Tab.Top + fMainForm.WWW_Tab.Height + fMainForm.ImgSplitter2.Height + fMainForm.LabelHWW.Height
        fMainForm.HWW_Tab.Height = fMainForm.ScaleHeight - (gClientTop + fMainForm.WWW_Tab.Height + fMainForm.LabelWWW.Height + fMainForm.ImgSplitter2.Height + fMainForm.LabelHWW.Height)
        
        fMainForm.ImgSplitter2.Left = fMainForm.HWW_Tab.Left
    Else
        fMainForm.ImgSplitter2.Visible = False
        fMainForm.HWW_Tab.Height = fMainForm.ScaleHeight - fMainForm.HWW_Tab.Top
    End If
End Sub


Sub SpliiterSizeControls()
    On Error Resume Next

    If imgSpitter.Visible Then
        fMainForm.tvTreeView.Left = 0
        fMainForm.LabelTree.Left = gLabelLeft
        
        fMainForm.LabelTree.Top = gClientTop
        fMainForm.ToolbarTree.Top = gClientTop
        fMainForm.tvTreeView.Top = gClientTop + fMainForm.LabelTree.Height
        
        'set the width
        If fMainForm.picSplitter.Left < gWebTreeMinWidth Then
            treeright = gWebTreeMinWidth
        Else
            treeright = fMainForm.picSplitter.Left
        End If
        
        fMainForm.tvTreeView.Height = fMainForm.ScaleHeight - (gClientTop + fMainForm.LabelTree.Height)
        fMainForm.LabelTree.Width = treeright - (fMainForm.ToolbarTree.Width + gLabelLeft)
        fMainForm.ToolbarTree.Left = fMainForm.LabelTree.Left + fMainForm.LabelTree.Width
        fMainForm.tvTreeView.Width = treeright
        
        fMainForm.imgSplitter.Left = treeright
        fMainForm.picSplitter.Left = treeright
        fMainForm.imgSplitter.Top = gClientTop
        fMainForm.picSplitter.Top = gClientTop
        fMainForm.imgSplitter.Height = fMainForm.ScaleHeight - gClientTop
        fMainForm.picSplitter.Height = fMainForm.ScaleHeight - gClientTop
        
        If fMainForm.WWW_Tab.Visible Then
            fMainForm.LabelWWW.Left = treeright + fMainForm.imgSplitter.Width + gLabelLeft
            fMainForm.LabelWWW.Width = fMainForm.ScaleWidth - (fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width) - fMainForm.ToolbarWWW.Width - gLabelLeft
            fMainForm.ToolbarWWW.Left = fMainForm.LabelWWW.Left + fMainForm.LabelWWW.Width
            
            fMainForm.WWW_Tab.Left = fMainForm.imgSplitter.Left + fMainForm.imgSplitter.Width
            fMainForm.WWW_Tab.Top = fMainForm.tvTreeView.Top
            fMainForm.WWW_Tab.Width = fMainForm.ScaleWidth - (fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width)
        End If
        
        If fMainForm.WWW_Tab.Visible And fMainForm.HWW_Tab.Visible Then
            'set the height
            fMainForm.ImgSplitter2.Left = treeright + fMainForm.imgSplitter.Width
            fMainForm.ImgSplitter2.Width = fMainForm.ScaleWidth - (fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width)
        End If
        
        If fMainForm.HWW_Tab.Visible Then
            fMainForm.LabelHWW.Left = treeright + fMainForm.imgSplitter.Width + gLabelLeft
            fMainForm.LabelHWW.Width = fMainForm.ScaleWidth - (fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width) - fMainForm.ToolbarHWW.Width - gLabelLeft
            fMainForm.ToolbarHWW.Left = fMainForm.LabelWWW.Left + fMainForm.LabelHWW.Width
            
            fMainForm.HWW_Tab.Left = treeright + fMainForm.imgSplitter.Width
            fMainForm.HWW_Tab.Width = fMainForm.ScaleWidth - (fMainForm.tvTreeView.Width + fMainForm.imgSplitter.Width)
        End If
    End If
    
    fMainForm.ToolbarTree.Refresh
End Sub

Sub Spliiter2SizeControls()
    If fMainForm.ImgSplitter2.Visible Then
        'set the width
        If fMainForm.WWW_Tab.Visible Then
            fMainForm.LabelWWW.Top = gClientTop
            fMainForm.ToolbarWWW.Top = gClientTop
            fMainForm.WWW_Tab.Top = gClientTop + fMainForm.LabelWWW.Height
            
            fMainForm.WWW_Tab.Height = fMainForm.picSplitter2.Top - fMainForm.WWW_Tab.Top
        End If
        
        fMainForm.ImgSplitter2.Top = fMainForm.picSplitter2.Top
        
        If fMainForm.HWW_Tab.Visible Then
            fMainForm.LabelHWW.Top = fMainForm.ImgSplitter2.Top + fMainForm.ImgSplitter2.Height
            fMainForm.ToolbarHWW.Top = fMainForm.ImgSplitter2.Top + fMainForm.ImgSplitter2.Height
            
            fMainForm.HWW_Tab.Top = fMainForm.LabelHWW.Top + fMainForm.LabelHWW.Height
            fMainForm.HWW_Tab.Height = fMainForm.ScaleHeight - (fMainForm.LabelHWW.Top + fMainForm.LabelHWW.Height)
        End If
    End If
End Sub


