VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 1  'NoTransaction
END
Attribute VB_Name = "clseDoc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private cnn As ADODB.Connection     'To Hold the Connection Object
Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpbuffer As String, ByVal nSize As Long) As Long


'*************************************************************************
'*                                                                       *
'*Method Name      : EstablishConn                                       *
'*                                                                       *
'*Author           : Ramesh Kota                                         *
'*                                                                       *
'*Created on       : 17/07/2001           Modified on :                  *
'*                                                                       *
'*Return Value     : TRUE if connection is esablished else FALSE         *
'*                                                                       *
'*Description      : Establishes the connection and returns a boolean    *
'*                   value.                                              *
'*                                                                       *
'*************************************************************************
Private Function EstablishConn() As Boolean
'Instantiating
Set cnn = CreateObject("ADODB.Connection")
cnn.CursorLocation = adUseClient
cnn.Open GetBOOEUDLPath
EstablishConn = True
Exit Function
End Function
Private Function CloseConnection() As Boolean

'*************************************************************************
'*Method Name      : CloseConnection                                     *
'*                                                                       *
'*Author           : Ramesh Kota                                         *
'*                                                                       *
'*Created on       : 17/07/2001            Modified on :                 *
'*                                                                       *
'*Return Value     : TRUE if connection is esablished else FALSE         *
'*                                                                       *
'*Description      : Closes the connection Established and releases      *
'*                   memory                                              *
'*                                                                       *
'*************************************************************************
If cnn.State = 1 Then
    Set cnn = Nothing
    CloseConnection = True
End If
Exit Function
End Function
Private Function GetBOOEUDLPath() As String

'*************************************************************************
'*                                                                       *
'*Method Name      : GetBOOEUDLPath                                      *
'*                                                                       *
'*Author           : Ramesh Kota                                         *
'*                                                                       *
'*Created on       : 17/07/2001           Modified on :                  *
'*                                                                       *
'*Return Value     : Gets the System Path String                         *
'*                                                                       *
'*Description      : An API call is made to get the System Directory     *
'*                   Path.                                               *
'*                                                                       *
'*************************************************************************
Dim lPath As String * 255
Dim lLeng As Long
Dim lBOOEUDLPath As String
lLeng = GetSystemDirectory(lPath, Len(lPath))
lBOOEUDLPath = Left(lPath, lLeng)
GetBOOEUDLPath = "File Name=" & lBOOEUDLPath & "\eDoc.udl"
Exit Function
End Function

Public Function GetLeafLets(ByVal piTreeLeafID As Integer) As ADODB.Recordset
    Dim lRs As ADODB.Recordset
    Dim lSql As String
    
    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    lSql = "Select * From eD_TreeLeaves Where T_NodeID = " & piTreeLeafID & " Order By TL_LeafElementPosition"
    Set lRs = cnn.Execute(lSql)
    
    Set GetLeafLets = lRs
    If cnn.State = 1 Then CloseConnection
    
    Set lRs = Nothing
End Function

Public Function GetParagraph(ByVal piLeafElementID As Integer) As ADODB.Recordset
    Dim lRs As ADODB.Recordset
    Dim lSql As String
    
    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    lSql = "Select * From eD_Paragraph Where P_ParagraphID = " & piLeafElementID
    Set lRs = cnn.Execute(lSql)
    
    Set GetParagraph = lRs
    If cnn.State = 1 Then CloseConnection
    
    Set lRs = Nothing
End Function

Public Function InsertPara(ByVal piNodeID As Integer, ByVal piParaTitle As String, ByVal piPara As String, ByVal piLeafElementID As Integer, ByVal piDirection As String, ByRef poNewElementID) As Boolean
On Error GoTo InsertPara_Err

    Dim lRs As ADODB.Recordset
    Dim lPosition As Integer
    Dim lShifted As Boolean
    Dim lSql As String
    Dim lNewElementID As Integer
    Dim lCmd As ADODB.Command
    Dim lParam As ADODB.Parameter
    Dim lParamOut As ADODB.Parameter

    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    If piLeafElementID <> 0 Then
        ' Get position of the piLeafElementID in piNodeID
        lPosition = GetLeafElementPosition(piNodeID, piLeafElementID)
        If lPosition = -1 Then
            GoTo InsertPara_Err
        End If
    Else
        lPosition = 0
    End If
    
    If piDirection = "Before" Then
        ' Increment all positions after the determined position by 1
        lShifted = ShiftPositionUp(piNodeID, lPosition)
        
        If Not lShifted Then
            GoTo InsertPara_Err
        End If
        
        ' Insert new Para in ed_Paragraphs and get the P_ParagraphID
        Set lCmd = CreateObject("ADODB.Command")
        lCmd.ActiveConnection = cnn
        lCmd.CommandText = "ParaInsert"
        lCmd.CommandType = adCmdStoredProc
           
        Set lParam = lCmd.CreateParameter("", adVarChar, adParamInput, 256)
        lCmd.Parameters.Append lParam
        lParam.Value = piParaTitle
        
        Set lParam = lCmd.CreateParameter("", adVarChar, adParamInput, 4096)
        lCmd.Parameters.Append lParam
        lParam.Value = piPara
        
        Set lParamOut = lCmd.CreateParameter("", adInteger, adParamOutput)
        lCmd.Parameters.Append lParamOut

        Call lCmd.Execute

        ' Get the new elemenet ID
        lNewElementID = lParamOut.Value
        
        ' Insert the P_ParagraphID into eD_TReeLEaves
        lSql = "Insert Into eD_TreeLeaves Values(" & piNodeID & "," & _
                                                     "'PARA'" & "," & _
                                                     lNewElementID & "," & _
                                                     lPosition & ")"
        Call cnn.Execute(lSql)
    ElseIf piDirection = "After" Then
        ' Insert new Para in ed_Paragraphs and get the P_ParagraphID
        Set lCmd = CreateObject("ADODB.Command")
        lCmd.ActiveConnection = cnn
        lCmd.CommandText = "ParaInsert"
        lCmd.CommandType = adCmdStoredProc
           
        Set lParam = lCmd.CreateParameter("", adVarChar, adParamInput, 256)
        lCmd.Parameters.Append lParam
        lParam.Value = piParaTitle
        
        Set lParam = lCmd.CreateParameter("", adVarChar, adParamInput, 4096)
        lCmd.Parameters.Append lParam
        lParam.Value = piPara
        
        Set lParamOut = lCmd.CreateParameter("", adInteger, adParamOutput)
        lCmd.Parameters.Append lParamOut

        Call lCmd.Execute

        ' Get the new elemenet ID
        lNewElementID = lParamOut.Value
        
        ' Insert the P_ParagraphID into eD_TReeLEaves
        lSql = "Insert Into eD_TreeLeaves Values(" & piNodeID & "," & _
                                                     "'PARA'" & "," & _
                                                     lNewElementID & "," & _
                                                     lPosition + 1 & ")"
        Call cnn.Execute(lSql)
    Else
        GoTo InsertPara_Err
    End If

    poNewElementID = lNewElementID
    InsertPara = True
    GoTo InsertPara_Exit

InsertPara_Err:
    InsertPara = False
InsertPara_Exit:
    Set lRs = Nothing
    Set lCmd = Nothing
End Function

Public Function GetLeafElementPosition(ByVal piNodeID As Integer, ByVal piLeafElementID As Integer) As Integer
    Dim lRs As ADODB.Recordset
    Dim lPosition As Integer
    Dim lSql As String
    
    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    lSql = "Select TL_LeafElementPosition From eD_TreeLeaves Where " & _
           " T_NodeID = " & piNodeID & _
           " And TL_LeafElementID = " & piLeafElementID
    
    Set lRs = cnn.Execute(lSql)
    
    If lRs.RecordCount > 0 Then
        lPosition = Val(lRs("TL_LeafElementPosition"))
    Else
        lPosition = -1
    End If
    
    GetLeafElementPosition = lPosition
End Function

Public Function ShiftPositionUp(ByVal piNodeID As Integer, ByVal lPosition As Integer) As Boolean
On Error GoTo ShiftPositionUp_Err

    Dim lRs As ADODB.Recordset
    Dim lSql As String
    Dim lLeafElementID As Integer
    Dim lNewLeafPos As Integer
    Dim lIdx As Integer
    
    lIdx = 1
    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    lSql = "Select * From eD_TreeLeaves Where " & _
           " T_NodeID = " & piNodeID & " Order By TL_LeafElementPosition"
    Set lRs = cnn.Execute(lSql)
    
    If lRs.RecordCount > 0 Then
        While Not lRs.EOF
            If lIdx >= lPosition Then
                lLeafElementID = Val(lRs("TL_LeafElementID"))
                lNewLeafPos = Val(lRs("TL_LeafElementPosition")) + 1
                lSql = "Update eD_TreeLeaves Set TL_LeafElementPosition = " & lNewLeafPos & _
                       " Where TL_LeafElementID = " & lLeafElementID
                Call cnn.Execute(lSql)
            End If
            
            lIdx = lIdx + 1
            lRs.MoveNext
        Wend
    Else
        GoTo ShiftPositionUp_Err
    End If
    
    ShiftPositionUp = True
    GoTo ShiftPositionUp_Exit
    
ShiftPositionUp_Err:
    ShiftPositionUp = False
ShiftPositionUp_Exit:
    Set lRs = Nothing
End Function

Public Function ShiftNodePositionUp(ByVal piParentNodeID As Integer, ByVal piPosition As Integer) As Boolean
On Error GoTo ShiftNodePositionUp_Err

    Dim lRs As ADODB.Recordset
    Dim lSql As String
    Dim lNodeID As Integer
    Dim lNewNodePos As Integer
    Dim lIdx As Integer
    
    lIdx = 1
    
    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    lSql = "Select * From eD_Tree Where " & _
           " T_ParentNode = " & piParentNodeID & " Order By T_Position"
    Set lRs = cnn.Execute(lSql)
    
    If lRs.RecordCount > 0 Then
        While Not lRs.EOF
            If lIdx >= piPosition Then
                lNodeID = Val(lRs("T_NodeID"))
                lNewNodePos = Val(lRs("T_Position")) + 1
                lSql = "Update eD_Tree Set T_Position = " & lNewNodePos & _
                       " Where T_NodeID = " & lNodeID
                Call cnn.Execute(lSql)
            End If
            
            lIdx = lIdx + 1
            lRs.MoveNext
        Wend
    Else
        GoTo ShiftNodePositionUp_Err
    End If
    
    ShiftNodePositionUp = True
    GoTo ShiftNodePositionUp_Exit
    
ShiftNodePositionUp_Err:
    ShiftNodePositionUp = False
ShiftNodePositionUp_Exit:
    Set lRs = Nothing
End Function


Public Function GetNodeDetails(ByVal piNodeID As Integer) As ADODB.Recordset
    Dim lRs As ADODB.Recordset
    Dim lSql As String
    
    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    lSql = "Select * From eD_Tree Where T_NodeID = " & piNodeID
    Set lRs = cnn.Execute(lSql)
    
    Set GetNodeDetails = lRs
    If cnn.State = 1 Then CloseConnection
    
    Set lRs = Nothing
End Function

Public Function InsertNode(ByVal piNodeID As Integer, ByVal piNewNodeTitle As String, ByVal piDirection As String) As Integer
On Error GoTo InsertNode_Err
    Dim lRs As ADODB.Recordset
    Dim lPosition As Integer
    Dim lShifted As Boolean
    Dim lSql As String
    Dim lCmd As ADODB.Command
    Dim lParam As ADODB.Parameter
    Dim lParamOut As ADODB.Parameter

    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    ' Get position of the piLeafElementID in piNodeID
    Set lRs = GetNodeDetails(piNodeID)
    If lRs.RecordCount < 0 Then
        GoTo InsertNode_Err
    End If
    
    If piDirection = "Before" Then
        ' Increment all positions after the determined position by 1
        lPosition = Val(lRs("T_Position"))
        lShifted = ShiftNodePositionUp(Val(lRs("T_ParentNode")), lPosition)
    ElseIf piDirection = "After" Then
        lPosition = Val(lRs("T_Position")) + 1
        lShifted = ShiftNodePositionUp(Val(lRs("T_ParentNode")), lPosition)
    Else
        GoTo InsertNode_Err
    End If
    
    If Not lShifted Then
        GoTo InsertNode_Err
    End If
    
    ' Insert new Node in ed_Tree and get the T_NodeID
    Set lCmd = CreateObject("ADODB.Command")
    lCmd.ActiveConnection = cnn
    lCmd.CommandText = "NodeInsert"
    lCmd.CommandType = adCmdStoredProc
       
    Set lParam = lCmd.CreateParameter("", adChar, adParamInput, 32)
    lCmd.Parameters.Append lParam
    lParam.Value = "NODE"
    
    Set lParam = lCmd.CreateParameter("", adVarChar, adParamInput, 1024)
    lCmd.Parameters.Append lParam
    lParam.Value = piNewNodeTitle
    
    Set lParam = lCmd.CreateParameter("", adInteger, adParamInput)
    lCmd.Parameters.Append lParam
    lParam.Value = Val(lRs("T_ParentNode"))
    
    Set lParam = lCmd.CreateParameter("", adInteger, adParamInput)
    lCmd.Parameters.Append lParam
    lParam.Value = lPosition
    
    Set lParamOut = lCmd.CreateParameter("", adInteger, adParamOutput)
    lCmd.Parameters.Append lParamOut

    Call lCmd.Execute

    ' Get the new elemenet ID
    InsertNode = lParamOut.Value

    GoTo InsertNode_Exit

InsertNode_Err:
    InsertNode = -1
InsertNode_Exit:
End Function

Public Function InsertLeaf(ByVal piParentNodeID As Integer, ByVal piLeafElementID As Integer, ByVal piDirection As String, ByVal piNewNodeTitle As String) As Integer
On Error GoTo InsertLeaf_Err
    Dim lRs As ADODB.Recordset
    Dim lPosition As Integer
    Dim lShifted As Boolean
    Dim lSql As String
    Dim lCmd As ADODB.Command
    Dim lParam As ADODB.Parameter
    Dim lParamOut As ADODB.Parameter

    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    ' Increment all positions after the determined position by 1
    If piLeafElementID <> 0 Then
        Set lRs = GetNodeDetails(piLeafElementID)
        If lRs.RecordCount < 0 Then
            GoTo InsertLeaf_Err
        End If

        If piDirection = "Before" Then
            lShifted = ShiftNodePositionUp(Val(lRs("T_ParentNode")), Val(lRs("T_Position")))
            lPosition = Val(lRs("T_Position"))
        ElseIf piDirection = "After" Then
            lShifted = ShiftNodePositionUp(Val(lRs("T_ParentNode")), Val(lRs("T_Position")) + 1)
            lPosition = Val(lRs("T_Position")) + 1
        Else
            GoTo InsertLeaf_Err
        End If
    Else
        lPosition = 1
        lShifted = True
    End If
    
    If Not lShifted Then
        GoTo InsertLeaf_Err
    End If
    
    ' Insert new Node in ed_Tree and get the T_NodeID
    Set lCmd = CreateObject("ADODB.Command")
    lCmd.ActiveConnection = cnn
    lCmd.CommandText = "NodeInsert"
    lCmd.CommandType = adCmdStoredProc
       
    Set lParam = lCmd.CreateParameter("", adChar, adParamInput, 32)
    lCmd.Parameters.Append lParam
    lParam.Value = "LEAF"
    
    Set lParam = lCmd.CreateParameter("", adVarChar, adParamInput, 1024)
    lCmd.Parameters.Append lParam
    lParam.Value = piNewNodeTitle
    
    Set lParam = lCmd.CreateParameter("", adInteger, adParamInput)
    lCmd.Parameters.Append lParam
    lParam.Value = piParentNodeID
    
    Set lParam = lCmd.CreateParameter("", adInteger, adParamInput)
    lCmd.Parameters.Append lParam
    lParam.Value = lPosition
    
    Set lParamOut = lCmd.CreateParameter("", adInteger, adParamOutput)
    lCmd.Parameters.Append lParamOut

    Call lCmd.Execute

    ' Get the new elemenet ID
    InsertLeaf = lParamOut.Value

    GoTo InsertLeaf_Exit

InsertLeaf_Err:
    InsertLeaf = -1
InsertLeaf_Exit:
End Function

Public Function InsertBreak(ByVal piNodeID As Integer, ByVal piNoOfBreaks As Integer, ByVal piLeafElementID As Integer, ByVal piDirection As String) As Boolean
On Error GoTo InsertBreak_Err

    Dim lRs As ADODB.Recordset
    Dim lPosition As Integer
    Dim lShifted As Boolean
    Dim lSql As String
    Dim lNewElementID As Integer
    Dim lCmd As ADODB.Command
    Dim lParam As ADODB.Parameter
    Dim lParamOut As ADODB.Parameter

    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    If piLeafElementID <> 0 Then
        ' Get position of the piLeafElementID in piNodeID
        lPosition = GetLeafElementPosition(piNodeID, piLeafElementID)
        If lPosition = -1 Then
            GoTo InsertBreak_Err
        End If
    Else
        lPosition = 0
    End If
    
    If piDirection = "Before" Then
        ' Increment all positions after the determined position by 1
        lShifted = ShiftPositionUp(piNodeID, lPosition)
        
        If Not lShifted Then
            GoTo InsertBreak_Err
        End If
        
        ' Insert new Para in ed_Paragraphs and get the P_ParagraphID
        Set lCmd = CreateObject("ADODB.Command")
        lCmd.ActiveConnection = cnn
        lCmd.CommandText = "BreakInsert"
        lCmd.CommandType = adCmdStoredProc
           
        Set lParam = lCmd.CreateParameter("", adInteger, adParamInput)
        lCmd.Parameters.Append lParam
        lParam.Value = piNoOfBreaks
        
        Set lParamOut = lCmd.CreateParameter("", adInteger, adParamOutput)
        lCmd.Parameters.Append lParamOut

        Call lCmd.Execute

        ' Get the new elemenet ID
        lNewElementID = lParamOut.Value
        
        ' Insert the P_ParagraphID into eD_TReeLEaves
        lSql = "Insert Into eD_TreeLeaves Values(" & piNodeID & "," & _
                                                     "'BREAK'" & "," & _
                                                     lNewElementID & "," & _
                                                     lPosition & ")"
        Call cnn.Execute(lSql)
    ElseIf piDirection = "After" Then
        ' Insert new Para in ed_Paragraphs and get the P_ParagraphID
        Set lCmd = CreateObject("ADODB.Command")
        lCmd.ActiveConnection = cnn
        lCmd.CommandText = "BreakInsert"
        lCmd.CommandType = adCmdStoredProc
           
        Set lParam = lCmd.CreateParameter("", adInteger, adParamInput)
        lCmd.Parameters.Append lParam
        lParam.Value = piNoOfBreaks
        
        Set lParamOut = lCmd.CreateParameter("", adInteger, adParamOutput)
        lCmd.Parameters.Append lParamOut

        Call lCmd.Execute

        ' Get the new elemenet ID
        lNewElementID = lParamOut.Value
        
        ' Insert the P_ParagraphID into eD_TReeLEaves
        lSql = "Insert Into eD_TreeLeaves Values(" & piNodeID & "," & _
                                                     "'BREAK'" & "," & _
                                                     lNewElementID & "," & _
                                                     lPosition + 1 & ")"
        Call cnn.Execute(lSql)
    Else
        GoTo InsertBreak_Err
    End If

    InsertBreak = True
    GoTo InsertBreak_Exit

InsertBreak_Err:
    InsertBreak = False
InsertBreak_Exit:
    Set lRs = Nothing
    Set lCmd = Nothing
End Function


Public Function GetBreak(ByVal piLeafElementID As Integer) As ADODB.Recordset
    Dim lRs As ADODB.Recordset
    Dim lSql As String
    
    EstablishConn
    Set lRs = CreateObject("ADODB.Recordset")
    
    lSql = "Select * From eD_LineBreaks Where LB_BreakID = " & piLeafElementID
    Set lRs = cnn.Execute(lSql)
    
    Set GetBreak = lRs
    If cnn.State = 1 Then CloseConnection
    
    Set lRs = Nothing
End Function

Public Function UpdatePara(ByVal piNodeID As Integer, ByVal piParaTitle As String, ByVal piPara As String, ByVal piLeafElementID As Integer, ByVal piTTextAlign, ByVal piTTextColor As String, ByVal piTTextDeco As String, ByVal piTBGColor As String, ByVal piTBGImage As String, ByVal piTBorderWidth As Integer, ByVal piTBorderColor As String, ByVal piTBorderStyle As String, ByVal piTFontFamily As String, ByVal piTFontSize As Integer, ByVal piTFontWeight As String, ByVal piTextAlign As String, ByVal piTextColor As String, ByVal piTextDeco As String, ByVal piBGColor As String, ByVal piBGImage As String, ByVal piBorderWidth As Integer, ByVal piBorderColor As String, ByVal piBorderStyle As String, ByVal piFontFamily As String, ByVal piFontSize As Integer, ByVal piFontWeight As String) As Boolean
On Error GoTo UpdatePara_Err

    Dim lSql As String

    EstablishConn
    
    ' Insert the P_ParagraphID into eD_TReeLEaves
    lSql = "Update eD_Paragraph " & _
           "Set P_ParagraphTitle = '" & piParaTitle & "'" & _
           ", P_ParagraphText = '" & piPara & "'" & _
           ", P_TitleTextAlign = '" & piTTextAlign & "'" & _
           ", P_TitleTextColor = '" & piTTextColor & "'" & _
           ", P_TitleTextDeco = '" & piTTextDeco & "'" & _
           ", P_TitleBGColor = '" & piTBGColor & "'" & _
           ", P_TitleBorderWidth = " & piTBorderWidth & _
           ", P_TitleBorderColor = '" & piTBorderColor & "'" & _
           ", P_TitleBorderStyle = '" & piTBorderStyle & "'" & _
           ", P_TitleFontFamily = '" & piTFontFamily & "'" & _
           ", P_TitleFontSize = " & piTFontSize & _
           ", P_TitleFontWeight = '" & piTFontWeight & "'" & _
           ", P_TextAlign = '" & piTextAlign & "'" & _
           ", P_TextColor = '" & piTextColor & "'" & _
           ", P_TextDeco = '" & piTextDeco & "'" & _
           ", P_BGColor = '" & piBGColor & "'" & _
           ", P_BorderWidth = " & piBorderWidth & _
           ", P_BorderColor = '" & piBorderColor & "'" & _
           ", P_BorderStyle = '" & piBorderStyle & "'" & _
           ", P_FontFamily = '" & piFontFamily & "'" & _
           ", P_FontSize = " & piFontSize & _
           ", P_FontWeight = '" & piFontWeight & "'" & _
           " Where P_ParagraphID = " & piLeafElementID
    
    Call cnn.Execute(lSql)

    UpdatePara = True
    GoTo UpdatePara_Exit

UpdatePara_Err:
    UpdatePara = False
UpdatePara_Exit:
End Function

Public Function UpdateBreak(ByVal piNodeID As Integer, ByVal piNoOfBreaks As Integer, ByVal piLeafElementID As Integer) As Boolean
On Error GoTo UpdateBreak_Err

    Dim lSql As String

    EstablishConn
    
    lSql = "Update eD_LineBreaks Set LB_NoOfBreaks = " & piNoOfBreaks & _
           " Where LB_BreakID = " & piLeafElementID
    
    Call cnn.Execute(lSql)

    UpdateBreak = True
    GoTo UpdateBreak_Exit

UpdateBreak_Err:
    UpdateBreak = False
UpdateBreak_Exit:
End Function



