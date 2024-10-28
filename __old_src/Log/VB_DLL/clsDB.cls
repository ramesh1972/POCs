VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpbuffer As String, ByVal nSize As Long) As Long
Private mCnn As ADODB.Connection

'*************************************************************************
'*Method Name      : GetErrorUDLPath                                      *
'*Author           : Ramesh Kota                                         *
'*Created on       : 17/07/2001           Modified on :                  *
'*Return Value     : Gets the System Path String                         *
'*Description      : An API call is made to get the System Directory     *
'*                   Path.                                               *
'*************************************************************************
Private Function GetErrorUDLPath() As String
    Dim lPath As String * 255
    Dim lLeng As Long
    Dim lErrorUDLPath As String
    
    lLeng = GetSystemDirectory(lPath, Len(lPath))
    lErrorUDLPath = Left(lPath, lLeng)
    GetErrorUDLPath = "File Name=" & lErrorUDLPath & "\errors.udl"
    
    Exit Function
End Function

'*************************************************************************
'*Method Name      : EstablishConn                                       *
'*Author           : Ramesh Kota                                         *
'*Created on       : 17/07/2001           Modified on :                  *
'*Return Value     : TRUE if connection is esablished else FALSE         *
'*Description      : Establishes the connection and returns a boolean    *
'*                   value.                                              *
'*************************************************************************
Public Function EstablishConn() As Boolean
    ' Close nay existing connections
    Call CloseConnection
    
    'Instantiating the new connection
    Set mCnn = CreateObject("ADODB.Connection")
    mCnn.CursorLocation = adUseClient
    mCnn.Open GetErrorUDLPath
    
    EstablishConn = True
    Exit Function
End Function

'*************************************************************************
'*Method Name      : CloseConnection                                     *
'*Author           : Ramesh Kota                                         *
'*Created on       : 17/07/2001            Modified on :                 *
'*Return Value     : TRUE if connection is esablished else FALSE         *
'*Description      : Closes the connection Established and releases      *
'*                   memory                                              *
'*************************************************************************
Public Function CloseConnection() As Boolean
    If mCnn.State = 1 Then
        Set mCnn = Nothing
        CloseConnection = True
    End If
    
    Exit Function
End Function

'*************************************************************************
'*Method Name      : ExecSQL                                             *
'*Author           : Ramesh Kota                                         *
'*Created on       : 17/07/2001            Modified on :                 *
'*Return Value     : TRUE if sql statement is executed successfully      *
'*Description      : Takes a Sql string as an argument and executes it   *
'*************************************************************************
Public Function ExecSQL(ByVal piSql As String) As Boolean
    On Error GoTo ExecSQL_Err
    
    If piSql = "" Then
        GoTo ExecSQL_Err
    End If

    Dim lRecAfft As Integer
    
    mCnn.Execute piSql, lRecAfft
    If lRecAfft < 0 Then
        GoTo ExecSQL_Err
    End If
    
    ExecSQL = True
    GoTo ExecSQL_Exit
    
ExecSQL_Err:
    ExecSQL = False
ExecSQL_Exit:
End Function

'*************************************************************************
'*Method Name      : ExecSQLReturnRS                                     *
'*Author           : Ramesh Kota                                         *
'*Created on       : 17/07/2001            Modified on :                 *
'*Return Value     : ADODB Recordset                                     *
'*Description      : Takes a Select Sql string as an argument, executes  *
'*                   it and returns the adodb recordset.                 *
'*************************************************************************
Public Function ExecSQLReturnRS(ByVal piSql As String) As ADODB.Recordset
    On Error GoTo ExecSQLReturnRS_Err
    
    If piSql = "" Then
        GoTo ExecSQLReturnRS_Err
    End If

    Dim lRecAfft As Integer
    Dim lRS As ADODB.Recordset
    
    Set lRS = CreateObject("ADODB.Recordset")
    Set lRS = mCnn.Execute(piSql)
    
    Set ExecSQLReturnRS = lRS
    GoTo ExecSQLReturnRS_Exit
    
ExecSQLReturnRS_Err:
    Set ExecSQLReturnRS = Nothing
ExecSQLReturnRS_Exit:
    Set lRS = Nothing
End Function
