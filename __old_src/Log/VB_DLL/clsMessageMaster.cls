VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 1  'NoTransaction
END
Attribute VB_Name = "clsMessageMaster"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
'*************************************************************************
'* Application  : BOOE
'* Module       : Error and Logging
'* File name    : clsMessageMaster
'* Purpose      : This class is used to Handle the Error and Log
'*                Processing tasks.
'*                The list below gives the purposes of this class
'*                      1) Adding New Errors, Warnings, Infromation
'*                         to the system.
'*                      2) Updating the same
'*                      3) Deleting the same
'*                      4) Browsing the various properties of the messages
'*                A Message can be an error, warning or information.
'*                A Message can belong to the system level, common level or
'*                sub-system level. For e.g Some errors belong only to MAC,
'*                while some are common to all sub-systems.
'*
'*                Tables
'*                ------
'*                The functions in this file select, update, insert and delete
'*                records from the L_MessageMaster table.
'*
'* Prepared by  : Ramesh Viswanathan
'* Date         : 24/04/2002
'* Copyright    : (C) SSI Technologies,India
'*
'*************************************************************************

'*************************************************************************
'*Revision History
'Version No.  -     Date    -       By  -         Explanation
'*************************************************************************
'* 1.0.0.0           24/04/2001   Ramesh Viswanathan     First BaseLine
'*
'*************************************************************************

'*************************************************************************
'* Method Name      : InsertMessage                                      *
'* Author           : Ramesh Viswanathan                                 *
'* Input Arguments  : 1) piMsgDefineKey                                  *
'*                       The key (a unique string) that will be a define *
'*                       in various source files                         *
'*                    2) piMsgType                                       *
'*                       0 - Error                                       *
'*                       1 - Warning                                     *
'*                       2 - Information                                 *
'*                    3) piMsgText                                       *
'*                       This is the Message text for the Error, Warning,*
'*                       Information, Caption etc.
'*                    4) piMsgContext                                    *
'*                       The Context of the above piMsgID will be changed*
'*                       to the one being passed.                        *
'*                       The possible Message Contexts are,              *
'*                          Non-Stop Sql, ADODB, Web Client, Web Server, *
'*                          MAC, RMS User, RMS Manager, Other.           *
'*                          Message Contexts can be created and stored   *
'*                          in the MessageContext table                  *
'*                    5) piContextMsgID                                  *
'*                       The Message ID of the Message in a particular   *
'*                       context as defined by the external system, that *
'*                       needs to be updated. Not to be confused with    *
'* Return Value     : A Boolean indicating whether the insert was true or*
'*                    false.                                             *
'* Description      : The function inserts an message into the           *
'*                    system with the basic properties like Type, Text   *
'*************************************************************************
Public Function InsertMessage(ByVal piMsgDefineKey As String, ByVal piMsgType As Integer, ByVal piMsgText As String, ByVal piContextID As Integer, ByVal piContextMsgID As Integer) As String
On Error GoTo InsertMessage_Err
    Dim lDB As clsDB
    Dim lCM As clsMessageContext
    Dim piContextName As String
    Dim lDate As String
    Dim llast_mod As String
    Dim lSqlStr As String
    
    If piMsgText = "" Then
        InsertMessage = "The message text cannot be empty."
        GoTo InsertMessage_Err
    End If
    
    If piMsgType < 0 Or piMsgType > 2 Then
        InsertMessage = "The message type is not valid."
        GoTo InsertMessage_Err
    End If
        
    If Not CheckIfKeyExists(piMsgDefineKey) Then
        InsertMessage = "The Key " & piMsgDefineKey & " already exists."
        GoTo InsertMessage_Err
    End If
    
    Set lCM = New clsMessageContext
    piContextName = ""
    piContextName = lCM.GetContextName(piContextID)
    If piContextName = "" Then
        InsertMessage = "Invalid Message Context " & piContextID
        GoTo InsertMessage_Err
    End If
    
    If Not CheckIfContextMsgIDExists(piContextID, piContextMsgID) Then
        InsertMessage = "The context id" & piContextMsgID & " already exists."
        GoTo InsertMessage_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Call lDB.EstablishConn
    
    lDate = FormatDateTime(Now(), vbShortDate)
    llast_mod = FormatDateTime(Now(), vbGeneralDate)

    lSqlStr = "Insert into MessageMaster (MM_MessageType, MM_MessageText, CM_ContextID, MM_ContexMessageID, MM_MessageLastModifiedDate) Values (" & _
                piMsgType & "," & _
                "'" & piMsgText & "'," & _
                piContextID & "," & _
                piContextMsgID & "," & _
                "'" & llast_mod & "')"
    
    If lDB.ExecSQL(lSqlStr) Then
        InsertMessage = "Success"
    Else
        InsertMessage = "Insert Failed"
    End If
  
    Call lDB.CloseConnection
    GoTo InsertMessage_Exit:
    
InsertMessage_Err:
InsertMessage_Exit:
    Set lDB = Nothing
End Function

'*************************************************************************
'* Method Name      : UpdateMessage                                      *
'* Author           : Ramesh Viswanathan                                 *
'* Input Arguments  : 1) piMsgID                                         *
'*                       The Message ID of the Message to be updated. Not*
'*                       to be confused with piContextMsgID. Must be a   *
'*                       positive integer.                               *
'*                    2) piMsgDefineKey                                  *
'*                       The key (a unique string) that will be a define *
'*                       in various source files                         *
'*                    3) piMsgType                                       *
'*                       0 - Error                                       *
'*                       1 - Warning                                     *
'*                       2 - Information                                 *
'*                    4) piMsgText                                       *
'*                       This is the Message text for the Error, Warning,*
'*                       Information, Caption etc.
'*                    5) piMsgContext                                    *
'*                       The Context of the above piMsgID will be changed*
'*                       to the one being passed.                        *
'*                       The possible Message Contexts are,              *
'*                          Non-Stop Sql, ADODB, Web Client, Web Server, *
'*                          MAC, RMS User, RMS Manager, Other.           *
'*                          Message Contexts can be created and stored   *
'*                          in the MessageContext table                  *
'*                    6) piContextMsgID                                  *
'*                       The Message ID of the Message in a particular   *
'*                       context as defined by the external system, that *
'*                       needs to be updated. Not to be confused with    *
'* Return Value     : A Boolean indicating whether the update was true or*
'*                    false.                                             *
'* Description      : The function updates the basic properties of a     *
'*                    message, Type, Text                                *
'*************************************************************************
Public Function UpdateMessage(ByVal piMsgID As Integer, ByVal piMsgDefineKey As String, ByVal piMsgType As Integer, ByVal piMsgText As String, ByVal piContextID As Integer, ByVal piContextMsgID) As Boolean
On Error GoTo UpdateMessage_Err
    Dim lDB As clsDB
    Dim lCM As clsMessageContext
    Dim piContextName As String
    Dim lDate As String
    Dim llast_mod As String
    Dim lSqlStr As String
    
    If piMsgID < 1 Then
        UpdateMessage = "Invalid message ID."
        GoTo UpdateMessage_Err
    End If
    
    If Not CheckIfMessageExists(piMsgID) Then
        UpdateMessage = "Message does not exist."
        GoTo UpdateMessage_Err
    End If
        
    If piMsgText = "" Then
        UpdateMessage = "The message text cannot be empty."
        GoTo UpdateMessage_Err
    End If
    
    If piMsgType < 0 Or piMsgType > 2 Then
        UpdateMessage = "The message type is not valid."
        GoTo UpdateMessage_Err
    End If
        
    If Not CheckIfKeyExists(piMsgDefineKey) Then
        UpdateMessage = "The Key " & piMsgDefineKey & " already exists."
        GoTo UpdateMessage_Err
    End If
    
    Set lCM = New clsMessageContext
    piContextName = ""
    piContextName = lCM.GetContextName(piContextID)
    If piContextName = "" Then
        UpdateMessage = "Invalid Message Context " & piContextID
        GoTo UpdateMessage_Err
    End If
    
    If CheckIfContextMsgIDExists(piContextID, piContextMsgID) Then
        UpdateMessage = "The context id " & piContextMsgID & " already exists."
        GoTo UpdateMessage_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Call lDB.EstablishConn
    
    lDate = FormatDateTime(Now(), vbShortDate)
    llast_mod = FormatDateTime(Now(), vbGeneralDate)

    lSqlStr = "Update MessageMaster Set " & _
              "MM_MessageType = " & piMsgType & _
              "MM_MessageText = '" & piMsgText & "'," & _
              "CM_ContextID = " & piContextID & "," & _
              "MM_ContexMessageID = " & piContextMsgID & "," & _
              "MM_MessageLastModifiedDate = '" & llast_mod & "'" & _
              " Where MM_MessageID = " & piMsgID
              
    If lDB.ExecSQL(lSqlStr) Then
        UpdateMessage = "Success"
    Else
        UpdateMessage = "Update Failed"
    End If
  
    Call lDB.CloseConnection
    GoTo UpdateMessage_Exit:
    
UpdateMessage_Err:
UpdateMessage_Exit:
    Set lDB = Nothing
End Function


'*************************************************************************
'* Method Name      : DeleteMessage                                      *
'* Author           : Ramesh Viswanathan                                 *
'* Created on       : 25/04/2001           Modified on :                 *
'* Input Arguments  : 1) piMsgID                                         *
'*                       The Message ID of the Message to be deleted. Not*
'*                       to be confused with piContextMsgID              *
'*                                                                       *
'* Return Value     : A Boolean indicating whether the delete was true or*
'*                    false.                                             *
'* Description      : Deletes a message from the Log system permanently  *
'*************************************************************************
Public Function DeleteMessage(ByVal piMsgID As Integer) As Boolean
On Error GoTo DeleteMessage_Err
    Dim lDB As clsDB
    Dim lSqlStr As String
    
    If piMsgID < 1 Then
        DeleteMessage = "Invalid message ID."
        GoTo DeleteMessage_Err
    End If
    
    If Not CheckIfMessageExists(piMsgID) Then
        DeleteMessage = "Message does not exist."
        GoTo DeleteMessage_Err
    End If
        
    ' validations are over
    Set lDB = New clsDB
    Call lDB.EstablishConn
    
    lSqlStr = "Delete From MessageMaster Where MM_MessageID = " & piMsgID
              
    If lDB.ExecSQL(lSqlStr) Then
        DeleteMessage = "Success"
    Else
        DeleteMessage = "Delete Failed"
    End If
  
    Call lDB.CloseConnection
    GoTo DeleteMessage_Exit:
    
DeleteMessage_Err:
DeleteMessage_Exit:
    Set lDB = Nothing
End Function

'*************************************************************************
'* Method Name      : BrowseMessage                                      *
'* Author           : Ramesh Viswanathan                                 *
'* Created on       : 25/04/2001           Modified on :                 *
'* Input Arguments  : 1) piMsgID                                         *
'*                       The Message ID of the Message to be updated. Not*
'*                       to be confused with piContextMsgID. Must be a   *
'*                       positive integer.                               *
'*                    2) piMsgDefineKey                                  *
'*                       The key (a unique string) that will be a define *
'*                       in various source files                         *
'*                    3) piMsgType                                       *
'*                       0 - Error                                       *
'*                       1 - Warning                                     *
'*                       2 - Information                                 *
'*                    4) piMsgText                                       *
'*                       This is the Message text for the Error, Warning,*
'*                       Information, Caption etc.
'*                    5) piMsgContext                                    *
'*                       The Context of the above piMsgID will be changed*
'*                       to the one being passed.                        *
'*                       The possible Message Contexts are,              *
'*                          Non-Stop Sql, ADODB, Web Client, Web Server, *
'*                          MAC, RMS User, RMS Manager, Other.           *
'*                          Message Contexts can be created and stored   *
'*                          in the MessageContext table                  *
'*                    6) piContextMsgID                                  *
'*                       The Message ID of the Message in a particular   *
'*                       context as defined by the external system, that *
'*                       needs to be updated. Not to be confused with    *
'*                    A combination of the above input arguments is used *
'*                    to return the recordset of Messages.               *
'*                                                                       *
'* Return Value     : ADODB.Recordset                                    *
'* Description      : The function takes the various query parameters    *
'*                    from input arguments, processes the single SELECT  *
'*                    SQL Statement to return a list of messages.        *
'*************************************************************************
Public Function BrowseMessage(ByVal piMsgID As Integer, ByVal piMsgDefineKey As String, ByVal piMsgType As Integer, ByVal piContextID As Integer, ByVal piContextMsgID) As ADODB.Recordset
On Error GoTo BrowseMessage_Err
    Dim lDB As clsDB
    Dim lRS As ADODB.Recordset
    Dim lCM As clsMessageContext
    Dim piContextName As String
    Dim lSqlStr As String
    Dim lWhereClause As String
    Dim lBrowseByMsgID As Boolean
    Dim lBrowseByMsgType As Boolean
    Dim lBrowseByMsgKey As Boolean
    Dim lBrowseByContext As Boolean
    Dim lBrowseByContextMsgID As Boolean
    
    lWhereClause = ""
    lBrowseByMsgID = True
    lBrowseByMsgType = True
    lBrowseByMsgKey = True
    lBrowseByContext = True
    lBrowseByContextMsgID = True
    
    If piMsgID < 1 Then
        lBrowseByMsgID = False
    End If
    
    If piMsgType < 0 Or piMsgType > 2 Then
        lBrowseByMsgType = False
    End If
        
    If Not CheckIfKeyExists(piMsgDefineKey) Then
        lBrowseByMsgKey = False
    End If
    
    Set lCM = New clsMessageContext
    piContextName = ""
    piContextName = lCM.GetContextName(piContextID)
    If piContextName = "" Then
        lBrowseByContext = False
    End If
    
    If Not CheckIfContextMsgIDExists(piContextID, piContextMsgID) Then
        lBrowseByContextMsgID = False
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From MessageMaster Where "
    If lBrowseByMsgID Then
        If lWhereClause = "" Then
            lWhereClause = " MM_MessageID = " & piMsgID
        Else
            lWhereClause = lWhereClause & " And MM_MessageID = " & piMsgID
        End If
    End If
    
    If lBrowseByMsgKey Then
        If lWhereClause = "" Then
            lWhereClause = " MM_MessageDefineKey = '" & piMsgDefineKey & "'"
        Else
            lWhereClause = lWhereClause & " And MM_MessageDefineKey = '" & piMsgDefineKey & "'"
        End If
    End If
    
    If lBrowseByMsgType Then
        If lWhereClause = "" Then
            lWhereClause = " MM_MessageType = " & piMsgType
        Else
            lWhereClause = lWhereClause & " And MM_MessageType = " & piMsgType
        End If
    End If
              
    If lBrowseByContext Then
        If lWhereClause = "" Then
            lWhereClause = " CM_ContextID = " & piContextID
        Else
            lWhereClause = lWhereClause & " And CM_ContextID = " & piContextID
        End If
    End If
              
    If lBrowseByContextMsgID Then
        If lWhereClause = "" Then
            lWhereClause = " MM_ContexMessageID = " & piContextMsgID
        Else
            lWhereClause = lWhereClause & " And MM_ContexMessageID = " & piContextMsgID
        End If
    End If
              
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
    Set BrowseMessage = lRS
    
    Call lDB.CloseConnection
    GoTo BrowseMessage_Exit:
    
BrowseMessage_Err:
BrowseMessage_Exit:
    Set lRS = Nothing
    Set lDB = Nothing
End Function

Public Function CheckIfContextMsgIDExists(ByVal piContextID As Integer, ByVal piContextMsgID As Integer, Optional piMsgID As Integer) As Boolean
On Error GoTo CheckIfContextMsgIDExists_Err
    Dim lDB As clsDB
    Dim lSqlStr As String
    Dim lRS As ADODB.Recordset
    
    If piContextID < 1 Or piContextMsgID < 1 Then
        GoTo CheckIfContextMsgIDExists_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From MessageMaster Where CM_ContextID = " & piContextID & " And MM_ContexMessageID = " & piContextMsgID
            
    If piMsgID > 0 Then
        lSqlStr = lSqlStr & " And MM_MessageID <> " & piMsgID
    End If
    
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
    If lRS.RecordCount > 0 Then
        CheckIfContextMsgIDExists = True
    Else
        CheckIfContextMsgIDExists = False
    End If
  
    Call lDB.CloseConnection
    GoTo CheckIfContextMsgIDExists_Exit:
    
CheckIfContextMsgIDExists_Err:
    CheckIfContextMsgIDExists = False
CheckIfContextMsgIDExists_Exit:
    Set lDB = Nothing
    Set lRS = Nothing
End Function

Public Function CheckIfKeyExists(ByVal piMsgDefineKey As String, Optional piMsgID As Integer) As Boolean
On Error GoTo CheckIfKeyExists_Err
    Dim lDB As clsDB
    Dim lSqlStr As String
    Dim lRS As ADODB.Recordset
    
    If piMsgDefineKey = "" Then
        GoTo CheckIfKeyExists_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From MessageMaster Where MM_MessageDefineKey = '" & piMsgDefineKey & "'"
            
    If piMsgID > 0 Then
        lSqlStr = lSqlStr & " And MM_MessageID <> " & piMsgID
    End If
    
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
    If lRS.RecordCount > 0 Then
        CheckIfKeyExists = True
    Else
        CheckIfKeyExists = False
    End If
  
    Call lDB.CloseConnection
    GoTo CheckIfKeyExists_Exit:
    
CheckIfKeyExists_Err:
    CheckIfKeyExists = False
CheckIfKeyExists_Exit:
    Set lDB = Nothing
    Set lRS = Nothing
End Function

Public Function CheckIfMessageExists(ByVal piMsgID As Integer) As Boolean
On Error GoTo CheckIfMessageExists_Err
    Dim lDB As clsDB
    Dim lSqlStr As String
    Dim lRS As ADODB.Recordset
    
    If piMsgID < 0 Then
        GoTo CheckIfMessageExists_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From MessageMaster Where MM_MessageID = " & piMsgID
            
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
    If lRS.RecordCount > 0 Then
        CheckIfMessageExists = True
    Else
        CheckIfMessageExists = False
    End If
  
    Call lDB.CloseConnection
    GoTo CheckIfMessageExists_Exit:
    
CheckIfMessageExists_Err:
    CheckIfMessageExists = False
CheckIfMessageExists_Exit:
    Set lDB = Nothing
    Set lRS = Nothing
End Function

Public Function GetMessage(ByVal piMsgID As Integer) As String
On Error GoTo GetMessage_Err
    Dim lDB As clsDB
    Dim lSqlStr As String
    Dim lRS As ADODB.Recordset
    
    If piMsgID < 1 Then
        GetMessage = "Invalid Message ID"
        GoTo GetMessage_Err
    End If
    
    If Not CheckIfMessageExists(piMsgID) Then
        GetMessage = "Message does not exist."
        GoTo GetMessage_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From MessageMaster Where MM_MessageID = " & piMsgID
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
    If lRS.RecordCount > 0 Then
        GetMessage = Trim(lRS("MM_MessageText"))
    Else
        GetMessage = "Message text not available"
    End If
    
    Call lDB.CloseConnection
    GoTo GetMessage_Exit:
    
GetMessage_Err:
GetMessage_Exit:
    Set lRS = Nothing
    Set lDB = Nothing
End Function

Public Function GetContextMessage(ByVal piContextID As Integer, ByVal piContextMsgID As Integer) As String
On Error GoTo GetContextMessage_Err
    Dim lDB As clsDB
    Dim lCM As clsMessageContext
    Dim piContextName As String
    Dim lSqlStr As String
    Dim lRS As ADODB.Recordset
    
    If piContextMsgID < 1 Then
        GetContextMessage = "Invalid Message ID"
        GoTo GetContextMessage_Err
    End If
    
    Set lCM = New clsMessageContext
    piContextName = ""
    piContextName = lCM.GetContextName(piContextID)
    If piContextName = "" Then
        GetContextMessage = "Invalid Message Context " & piContextID
        GoTo GetContextMessage_Err
    End If
    
    If Not CheckIfContextMsgIDExists(piContextID, piContextMsgID) Then
        GetContextMessage = "The message context id " & piContextMsgID & " does not exist."
        GoTo GetContextMessage_Err
    End If
    
    ' validations are over
    Set lDB = New clsDB
    Set lRS = CreateObject("ADODB.Recordset")
    Call lDB.EstablishConn
    
    lSqlStr = "Select * From MessageMaster Where CM_ContextID = " & piContextID & _
              " And MM_ContexMessageID = " & piContextMsgID
    Set lRS = lDB.ExecSQLReturnRS(lSqlStr)
    If lRS.RecordCount > 0 Then
        GetContextMessage = Trim(lRS("MM_MessageText"))
    Else
        GetContextMessage = "Message text not available"
    End If
    
    Call lDB.CloseConnection
    GoTo GetContextMessage_Exit:
    
GetContextMessage_Err:
GetContextMessage_Exit:
    Set lRS = Nothing
    Set lDB = Nothing
End Function
