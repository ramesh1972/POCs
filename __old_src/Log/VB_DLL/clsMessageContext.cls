VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 1  'NoTransaction
END
Attribute VB_Name = "clsMessageContext"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'*************************************************************************
'* Method Name      : InsertContext                                      *
'* Author           : Ramesh Viswanathan                                 *
'* Input Arguments  : 1) piContext                                       *
'*                       The Context to be inserted                      *
'*                       The possible Message Contexts are,              *
'*                          Non-Stop Sql, ADODB, Web Client, Web Server, *
'*                          MAC, RMS User, RMS Manager, Other.           *
'*                          Message Contexts can be created and stored   *
'*                          in the ContextMaster table                   *
'* Return Value     : A String indicating the result of the insert       *
'* Description      : The function inserts a context into the            *
'*                    system                                             *
'*************************************************************************
Public Function InsertContext(ByVal piContext As String) As String
On Error GoTo InsertContext_Err
    Dim lDB As clsDB
    Dim lDate As String
    Dim llast_mod As String
    Dim lSqlStr As String

    If Not CheckIfValidContext(piContext) Then
        InsertContext = "The Context " & piContext & " is not valid. Must be in all caps. Only alphabets are allowed."
        GoTo InsertContext_Err
    End If
    
    If CheckIfContextExists(piContext) Then
        InsertContext = "The Context " & piContext & " already exists."
        GoTo InsertContext_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Call lDB.EstablishConn
    
    lDate = FormatDateTime(Now(), vbShortDate)
    llast_mod = FormatDateTime(Now(), vbGeneralDate)

    lSqlStr = "Insert into ContextMaster (CM_ContextName, CM_LastModifiedDate) Values (" & _
                "'" & piContext & "'," & _
                "'" & llast_mod & "')"
    
    If lDB.ExecSQL(lSqlStr) Then
        InsertContext = "Success"
    Else
        InsertContext = "Insert Failed"
    End If
  
    Call lDB.CloseConnection
    GoTo InsertContext_Exit:
    
InsertContext_Err:
InsertContext_Exit:
    Set lDB = Nothing
End Function

Public Function UpdateContext(ByVal piContextID As Integer, ByVal piContext As String) As String
On Error GoTo UpdateContext_Err
    Dim lDB As clsDB
    Dim lDate As String
    Dim llast_mod As String
    Dim lSqlStr As String

    If piContextID < 1 Then
        UpdateContext = "The Context ID " & piContext & " is invalid."
        GoTo UpdateContext_Err
    End If
    
    If Not CheckIfValidContext(piContext) Then
        UpdateContext = "The Context " & piContext & " is not valid. Must be in all caps. Only alphabets are allowed."
        GoTo UpdateContext_Err
    End If
    
    If CheckIfContextExists(piContext, piContextID) Then
        UpdateContext = "The Context " & piContext & " already exists."
        GoTo UpdateContext_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Call lDB.EstablishConn
    
    lDate = FormatDateTime(Now(), vbShortDate)
    llast_mod = FormatDateTime(Now(), vbGeneralDate)

    lSqlStr = "Update ContextMaster Set " & _
              "CM_ContextName = '" & piContext & "', " & _
              "CM_LastModifiedDate = '" & llast_mod & "'" & _
              " Where CM_ContextID = " & piContextID
              
    If lDB.ExecSQL(lSqlStr) Then
        UpdateContext = "Success"
    Else
        UpdateContext = "Update Failed"
    End If
  
    Call lDB.CloseConnection
    GoTo UpdateContext_Exit:
    
UpdateContext_Err:
UpdateContext_Exit:
    Set lDB = Nothing
End Function

Public Function DeleteContext(ByVal piContextID As Integer) As String
On Error GoTo DeleteContext_Err
    Dim lDB As clsDB
    Dim lSqlStr As String

    If piContextID < 1 Then
        DeleteContext = "The Context ID " & piContextID & " is invalid."
        GoTo DeleteContext_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Call lDB.EstablishConn
    
    lSqlStr = "Delete From ContextMaster Where CM_ContextID = " & piContextID
              
    If lDB.ExecSQL(lSqlStr) Then
        DeleteContext = "Success"
    Else
        DeleteContext = "Delete Failed"
    End If
  
    Call lDB.CloseConnection
    GoTo DeleteContext_Exit:
    
DeleteContext_Err:
DeleteContext_Exit:
    Set lDB = Nothing
End Function

Function CheckIfValidContext(ByVal piContext As String) As Boolean
    Dim lIdx As Integer
    
    If piContext = "" Then
        CheckIfValidContext = False
        Exit Function
    End If
    
    If Len(piContext) > 10 Then
        CheckIfValidContext = False
        Exit Function
    End If
    
    For lIdx = 0 To Len(piContext) - 1
        Dim lChar As String
        lChar = Mid(piContext, lIdx, 1)
        If lChar < "A" Or lChar > "Z" Then
            CheckIfValidContext = False
            Exit Function
        End If
    Next
    
    CheckIfValidContext = True
End Function

Public Function CheckIfContextExists(ByVal piContext As String, Optional piContextID As Integer) As Boolean
On Error GoTo CheckIfContextExists_Err
    Dim lDB As clsDB
    Dim lSqlStr As String
    Dim lRS As ADODB.Recordset
    
    ' validations are over
    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From ContextMaster Where CM_ContextName = '" & piContext & "'"
        
    If piContextID > 0 Then
        lSqlStr = lSqlStr & " And CM_ContextID <> " & piContextID
    End If
    
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
    If lRS.RecordCount > 0 Then
        CheckIfContextExists = True
    Else
        CheckIfContextExists = False
    End If
  
    Call lDB.CloseConnection
    GoTo CheckIfContextExists_Exit:
    
CheckIfContextExists_Err:
    CheckIfContextExists = False
CheckIfContextExists_Exit:
    Set lDB = Nothing
End Function

Public Function GetContextName(ByVal piContextID As Integer) As Boolean
On Error GoTo GetContextName_Err
    Dim lDB As clsDB
    Dim lRS As ADODB.Recordset
    Dim lSqlStr As String

    If piContextID < 1 Then
        GetContextName = ""
        Exit Function
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From ContextMaster Where CM_ContextID = " & piContextID
        
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
    If lRS.RecordCount > 0 Then
        GetContextName = Trim(lRS("CM_ContextName"))
    Else
        GetContextName = ""
    End If
  
    Call lDB.CloseConnection
    GoTo GetContextName_Exit:
    
GetContextName_Err:
    GetContextName = ""
GetContextName_Exit:
    Set lDB = Nothing
    Set lRS = Nothing
End Function

Public Function CheckIfContextIDExists(ByVal piContextID As Integer, ByVal piContextMsgID As Integer, Optional piMsgID As Integer) As Boolean
On Error GoTo CheckIfContextIDExists_Err
    Dim lDB As clsDB
    Dim lSqlStr As String
    Dim lRS As ADODB.Recordset
    
    ' validations are over
    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From MessageMaster Where MM_ContexMessageID = " & piContextMsgID
    lSqlStr = lSqlStr & " And CM_ContextID <> " & piContextID
    
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
    If lRS.RecordCount > 0 Then
        CheckIfContextIDExists = True
    Else
        CheckIfContextIDExists = False
    End If
  
    Call lDB.CloseConnection
    GoTo CheckIfContextIDExists_Exit:
    
CheckIfContextIDExists_Err:
    CheckIfContextIDExists = False
CheckIfContextIDExists_Exit:
    Set lDB = Nothing
    Set lRS = Nothing
End Function

Public Function BrowseContext() As ADODB.Recordset
On Error GoTo BrowseContext_Err
    Dim lDB As clsDB
    Dim lRS As ADODB.Recordset
    Dim lSqlStr As String

    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From ContextMaster"
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
  
    Call lDB.CloseConnection
    
    Set BrowseContext = lRS
    GoTo BrowseContext_Exit:
    
BrowseContext_Err:
BrowseContext_Exit:
    Set lDB = Nothing
    Set lRS = Nothing
End Function

