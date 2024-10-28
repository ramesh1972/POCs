VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 1  'NoTransaction
END
Attribute VB_Name = "clsSoftwareBugs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
    Option Explicit
'*************************************************************
'* Application  : BOOE
'* Module       : Production Support
'* File name    : clsSystem.cls
'* Purpose      : This class is used to insert, update, delete bugs
'* Prepared by  : Ramesh Kota
'* Date         : 13/05/2001
'* Copyright    : (C) SSI Technologies,India
'*
'*************************************************************

Private cnn As ADODB.Connection     'To Hold the Connection Object
Private Declare Function GetSystemDirectory Lib "kernel32" Alias "GetSystemDirectoryA" (ByVal lpbuffer As String, ByVal nSize As Long) As Long


Function GetReportedBy() As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str = "Select distinct(BR_ReportedBy) from PS_Reports"
    Set rst = cnn.Execute(sql_str)
    
    Set GetReportedBy = rst
    If cnn.State = 1 Then CloseConnection
End Function

Function Display(ByVal piGroupID As Integer, ByVal piDatabaseID As Integer, ByVal pi_module As Integer, ByVal pi_status As Integer, ByVal pi_priority As Integer, ByVal pi_severity As Integer, ByVal pi_repby As Integer, ByVal pi_resp As Integer, ByVal pi_fixby As Integer, ByVal pi_verby As Integer, ByVal pi_start_date As Date, ByVal pi_end_date As Date, _
                 ByVal piAffProg As String, ByVal piTestCaseID As String) As ADODB.Recordset
    Dim rst
    Dim sql_str2 As String
    Dim where_clause As String
    
    EstablishConn
    
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str2 = "Select * from PS_Reports"
    where_clause = " Where G_GroupID = " & piGroupID & _
                   " And BD_DatabaseID = " & piDatabaseID

    If (pi_module <> 0) Then
        where_clause = where_clause & " And M_ModuleID = " & pi_module
    End If
    
    If (pi_status <> 0) Then
            where_clause = where_clause & " AND S_StatusID = " & pi_status
    End If

    If (pi_priority <> 0) Then
            where_clause = where_clause & " AND P_PriorityID = " & pi_priority
    End If

    If (pi_severity <> 0) Then
            where_clause = where_clause & " AND S_SeverityID = " & pi_severity
    End If
    
    If (pi_repby <> 0) Then
            where_clause = where_clause & " AND BR_ReportedBy = " & pi_repby
    End If

    If (pi_resp <> 0) Then
            where_clause = where_clause & " AND BR_Responsibility = " & pi_resp
    End If

    If (pi_fixby <> 0) Then
            where_clause = where_clause & " AND BR_FixedBy = " & pi_fixby
    End If

    If (pi_verby <> 0) Then
            where_clause = where_clause & " AND BR_VerifiedBy = " & pi_verby
    End If
    
    If (piAffProg <> "All") Then
            where_clause = where_clause & " AND BR_AffectedProgram = '" & piAffProg & "'"
    End If
    
    If (piTestCaseID = "Only Test Cases") Then
        where_clause = where_clause & " AND BR_TestCaseID != ''"
    ElseIf (piTestCaseID <> "All") Then
        where_clause = where_clause & " AND BR_TestCaseID = '" & piTestCaseID & "'"
    End If
    
    ' add the date and time clause
    where_clause = where_clause & " AND BR_ReportedDate >= '" & pi_start_date & "'" & " AND BR_ReportedDate <= '" & pi_end_date & "'"
    sql_str2 = sql_str2 & where_clause
    sql_str2 = sql_str2 & " Order By BR_ReportedDate desc"

    Set rst = cnn.Execute(sql_str2)
    Set Display = rst
    
    If cnn.State = 1 Then CloseConnection
End Function

Public Function ViewProblem(ByVal piGroupID As Integer, ByVal piDatabaseID As Integer, ByVal pi_Id As Integer) As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str = "Select * from PS_Reports Where BR_Identifier = " & pi_Id & _
              " And G_GroupID = " & piGroupID & _
              " And BD_DatabaseID = " & piDatabaseID
    Set rst = cnn.Execute(sql_str)
    
    Set ViewProblem = rst
    If cnn.State = 1 Then CloseConnection
End Function

Function GetStatus(ByVal pi_Id As Integer) As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    sql_str = "Select Status, FixedDate, VerifiedDate From PS_Reports Where Identifier = " & pi_Id
    
    Set rst = cnn.Execute(sql_str)
    Set GetStatus = rst
    If cnn.State = 1 Then CloseConnection
End Function

Function UpdateAll(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer, ByVal lid As Integer, ByVal ltitle As String, ByVal ldesc As String, ByVal lModule As Integer, ByVal lStatus As Integer, ByVal lPriority As Integer, ByVal lSeverity As Integer, ByVal lrepby As Integer, ByVal lresp As Integer, ByVal lfixby As Integer, ByVal lverby As Integer, _
                   ByVal piSteps As String, ByVal piWorkAround As String, ByVal piResolution As String, ByVal piFilesAffected As String, _
                   ByVal piAffProg As String, ByVal piProgVersionBeforeFix As String, ByVal piProgVersionAfterFix As String, ByVal piTestCaseID As String) As ADODB.Recordset
    Dim sql_str As String
    Dim sql_str1 As String
    Dim sql_str2 As String
    Dim rst As ADODB.Recordset
    Dim rec As ADODB.Recordset
    Dim lfixed_date As Variant
    Dim lverified_date As Variant
    Dim lprev_status As Integer
    Dim llast_mod As String
    
    EstablishConn
    Set rec = CreateObject("ADODB.Recordset")
    sql_str2 = "Select S_StatusID, BR_FixedDate, BR_VerifiedDate From PS_Reports Where BR_Identifier = " & lid
    
    Set rec = cnn.Execute(sql_str2)
    lprev_status = Val(Trim(rec("S_StatusID")))
    
    lfixed_date = rec("BR_FixedDate")
    lverified_date = rec("BR_VerifiedDate")
    
    If lprev_status = 1 Or lprev_status = 2 Then
        If lStatus = 3 Then
            lfixed_date = FormatDateTime(Now(), vbGeneralDate)
        ElseIf lStatus = 4 Then
            lverified_date = FormatDateTime(Now(), vbGeneralDate)
        End If
    ElseIf lprev_status = 3 Then
        If lStatus = 4 Then
            lverified_date = FormatDateTime(Now(), vbGeneralDate)
        End If
    End If

    llast_mod = FormatDateTime(Now(), vbGeneralDate)
    
    sql_str = "Update PS_Reports Set " & _
                "BR_LongDescription = '" & ldesc & "'," & _
                "M_ModuleID = " & lModule & "," & _
                "S_StatusID = " & lStatus & "," & _
                "P_PriorityID = " & lPriority & "," & _
                "S_SeverityID= " & lSeverity & "," & _
                "BR_ReportedBy = " & lrepby & "," & _
                "BR_Responsibility = " & lresp & "," & _
                "BR_FixedBy = " & lfixby & "," & _
                "BR_VerifiedBy = " & lverby & "," & _
                "BR_StepsToRecreate = '" & piSteps & "'," & _
                "BR_WorkAround = '" & piWorkAround & "'," & _
                "BR_Resolution = '" & piResolution & "'," & _
                "BR_FilesAffected = '" & piFilesAffected & "'," & _
                "BR_AffectedProgram = '" & piAffProg & "'," & _
                "BR_VersionBeforeFix = '" & piProgVersionBeforeFix & "'," & _
                "BR_VersionAfterFix = '" & piProgVersionAfterFix & "'," & _
                "BR_TestCaseID = '" & piTestCaseID & "'," & _
                "BR_LastModified = '" & llast_mod & "'"
    
    If (lfixed_date <> "") Then
        sql_str = sql_str & ",BR_FixedDate = '" & lfixed_date & "'"
    End If
                
    If (lverified_date <> "") Then
        sql_str = sql_str & ",BR_VerifiedDate = '" & lverified_date & "'"
    End If
                                
    sql_str = sql_str & " Where BR_Identifier = " & lid & _
                        " And G_GroupID = " & piProjectID & _
                        " And BD_DatabaseID = " & piDatabaseID
    cnn.Execute sql_str
    
    sql_str1 = "Select * from PS_Reports Where " & _
               " G_GroupID = " & piProjectID & _
               " And BD_DatabaseID = " & piDatabaseID & " Order By BR_ReportedDate Desc"
    Set rst = CreateObject("ADODB.Recordset")
    Set rst = cnn.Execute(sql_str1)
    
    Set UpdateAll = rst
    If cnn.State = 1 Then CloseConnection
End Function

Function DisplayAll(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer) As ADODB.Recordset
    Dim rst
    
    Dim sql_str2
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str2 = "Select * from PS_Reports Where " & _
               " G_GroupID = " & piProjectID & _
               " And BD_DatabaseID = " & piDatabaseID & " Order By BR_ReportedDate Desc"
    
    Set rst = cnn.Execute(sql_str2)
    Set DisplayAll = rst
    If cnn.State = 1 Then CloseConnection
End Function

Public Function DeleteProblem(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer, ByVal lid As Integer) As Boolean
On Error GoTo DeleteProblem_Err
    Dim sql_str2
    
    EstablishConn
    sql_str2 = "Delete From PS_Reports Where BR_Identifier = " & lid & _
               " And G_GroupID = " & piProjectID & _
               " And BD_DatabaseID = " & piDatabaseID
    
    cnn.Execute (sql_str2)
    If cnn.State = 1 Then CloseConnection
    DeleteProblem = True
    
    GoTo DeleteProblem_Exit
DeleteProblem_Err:
    DeleteProblem = False
DeleteProblem_Exit:
End Function

 Public Function InsertUserProblem(ByVal piEmpID As Integer, ByVal piProjectID As Integer, ByVal piDatabaseID As Integer, ByVal pi_strTitle As String, ByVal pi_strDesc As String, ByVal piSteps As String, ByVal piAffProg As String, ByVal piProgVersion As String, ByVal piTestCaseID As String) As Boolean
 On Error GoTo InsertUserProblem_Err
    Dim lDate As String
    Dim llast_mod As String
    Dim sql_str As String
    Dim recAfft

    EstablishConn
    lDate = FormatDateTime(Now(), vbShortDate)
    llast_mod = FormatDateTime(Now(), vbGeneralDate)

    sql_str = "Insert into PS_Reports (G_GroupID, BD_DatabaseID, BR_ReportedBy, BR_ShortDescription, BR_LongDescription, BR_StepsToRecreate, BR_AffectedProgram, BR_VersionBeforeFix, BR_TestCaseID, BR_ReportedDate, BR_LastModified) VALUES" _
                & "(" & piProjectID & "," & piDatabaseID & "," & piEmpID & ",'" & pi_strTitle & "','" & pi_strDesc & "'," & _
                "'" & piSteps & "'," & _
                "'" & piAffProg & "'," & _
                "'" & piProgVersion & "'," & _
                "'" & piTestCaseID & "'," & _
                "'" & lDate & "'," & _
                "'" & llast_mod & "')"
    
    cnn.Execute sql_str, recAfft
    If (recAfft > 0) Then
        InsertUserProblem = True
    Else
        InsertUserProblem = False
    End If
    If cnn.State = 1 Then CloseConnection
    GoTo InsertUserProblem_Exit:
InsertUserProblem_Err:
    InsertUserProblem = False
InsertUserProblem_Exit:
End Function

Public Function ViewDescriptions(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer, ByVal pi_Id As Integer) As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String

    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    sql_str = "Select S_StatusID, BR_ShortDescription, BR_LongDescription, BR_StepsToRecreate, BR_WorkAround, BR_Resolution, BR_FilesAffected From PS_Reports Where BR_Identifier = " & pi_Id & _
             " And G_GroupID = " & piProjectID & _
             " And BD_DatabaseID = " & piDatabaseID
    Set rst = cnn.Execute(sql_str)
    
    Set ViewDescriptions = rst
    If cnn.State = 1 Then CloseConnection
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
GetBOOEUDLPath = "File Name=" & lBOOEUDLPath & "\bugs.udl"
Exit Function
End Function
Private Function EstablishConn() As Boolean

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



Public Function GetProjectModules(ByVal piProjectID As Integer, ByVal piModuleID As Integer) As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str = "Select * from P_Modules Where G_GroupID = " & piProjectID
    If (piModuleID <> 0) Then
        sql_str = sql_str & " And M_ModuleID = " & piModuleID
    End If
    
    sql_str = sql_str & " Order By M_ModuleID"
    Set rst = cnn.Execute(sql_str)
    
    Set GetProjectModules = rst
    If cnn.State = 1 Then CloseConnection
    
    Set rst = Nothing
End Function

Public Function GetAllBugsStatus() As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str = "Select * from PS_Status Order By S_StatusID"
    Set rst = cnn.Execute(sql_str)
    
    Set GetAllBugsStatus = rst
    If cnn.State = 1 Then CloseConnection
    
    Set rst = Nothing
End Function

Public Function GetAllBugsPriority() As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str = "Select * from PS_Priority Order By P_PriorityID"
    Set rst = cnn.Execute(sql_str)
    
    Set GetAllBugsPriority = rst
    If cnn.State = 1 Then CloseConnection
    
    Set rst = Nothing
End Function

Public Function GetAllBugsSeverity() As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str = "Select * from PS_Severity Order By S_SeverityID"
    Set rst = cnn.Execute(sql_str)
    
    Set GetAllBugsSeverity = rst
    If cnn.State = 1 Then CloseConnection
    
    Set rst = Nothing
End Function

Public Function GetModuleName(ByVal piProjectID As Integer, ByVal piID As Integer) As String
    Dim sql_str As String
    Dim lRs As ADODB.Recordset
    Dim lName
    
    lName = ""
    
    EstablishConn
    Set lRs = CreateObject("ADODB.RecordSet")
    
    sql_str = "Select * from P_Modules Where G_GroupID = " & piProjectID & " And M_ModuleID = " & piID
    Set lRs = cnn.Execute(sql_str)
    If lRs.RecordCount > 0 Then
        lName = Trim(lRs("M_ModuleName"))
    End If
    
    GetModuleName = lName
    If cnn.State = 1 Then CloseConnection
End Function

Public Function GetStatusName(ByVal piID As Integer) As String
    Dim sql_str As String
    Dim lRs As ADODB.Recordset
    Dim lName
    
    lName = ""
    
    EstablishConn
    Set lRs = CreateObject("ADODB.RecordSet")
    
    sql_str = "Select * from PS_Status Where S_StatusID = " & piID
    Set lRs = cnn.Execute(sql_str)
    If lRs.RecordCount > 0 Then
        lName = Trim(lRs("S_Status"))
    End If
    
    GetStatusName = lName
    If cnn.State = 1 Then CloseConnection
End Function

Public Function GetPriority(ByVal piID As Integer) As String
    Dim sql_str As String
    Dim lRs As ADODB.Recordset
    Dim lName
    
    lName = ""
    
    EstablishConn
    Set lRs = CreateObject("ADODB.RecordSet")
    
    sql_str = "Select * from PS_Priority Where P_PriorityID = " & piID
    Set lRs = cnn.Execute(sql_str)
    If lRs.RecordCount > 0 Then
        lName = Trim(lRs("P_Priority"))
    End If
    
    GetPriority = lName
    If cnn.State = 1 Then CloseConnection
End Function

Public Function GetSeverity(ByVal piID As Integer) As String
    Dim sql_str As String
    Dim lRs As ADODB.Recordset
    Dim lName
    
    lName = ""
    
    EstablishConn
    Set lRs = CreateObject("ADODB.RecordSet")
    
    sql_str = "Select * from PS_Severity Where S_SeverityID = " & piID
    Set lRs = cnn.Execute(sql_str)
    If lRs.RecordCount > 0 Then
        lName = Trim(lRs("S_Severity"))
    End If
    
    GetSeverity = lName
    If cnn.State = 1 Then CloseConnection
End Function

Public Function InsertStatus(ByVal piStatus As String) As Boolean
On Error GoTo InsertStatus_Err

    Dim sql_str As String
    Dim lStatusExists As Boolean
    
    EstablishConn
    
    ' Check if Status already exists
    lStatusExists = True
    lStatusExists = CheckIfStatusExists(piStatus)
    
    If lStatusExists Then
        GoTo InsertStatus_Err
    End If
    
    ' Insert the status
    sql_str = "Insert into PS_Status(S_Status) Values(" & _
              "'" & piStatus & "')"
    
    Call cnn.Execute(sql_str)
    
    InsertStatus = True
    GoTo InsertStatus_Exit
    
InsertStatus_Err:
    InsertStatus = False
InsertStatus_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function CheckIfStatusExists(ByVal piStatus As String) As Boolean
    Dim sql_str As String
    Dim lRs As ADODB.Recordset
    
    Set lRs = CreateObject("ADODB.RecordSet")
    EstablishConn
    
    sql_str = "Select * from PS_Status Where S_Status = '" & piStatus & "'"
    Set lRs = cnn.Execute(sql_str)
    
    If lRs.RecordCount > 0 Then
        CheckIfStatusExists = True
    Else
        CheckIfStatusExists = False
    End If
End Function

Public Function UpdateStatus(ByVal piStatusID As Integer, ByVal piStatus As String) As Boolean
On Error GoTo UpdateStatus_Err

    Dim sql_str As String
    Dim lStatusExists As Boolean
    
    EstablishConn
    
    ' Check if Status already exists
    lStatusExists = True
    lStatusExists = CheckIfStatusExists(piStatus)
    
    If lStatusExists Then
        GoTo UpdateStatus_Err
    End If
    
    ' Insert the status
    sql_str = "Update PS_Status Set S_Status = '" & piStatus & "' Where S_StatusID = " & piStatusID
    
    Call cnn.Execute(sql_str)
    
    UpdateStatus = True
    GoTo UpdateStatus_Exit
    
UpdateStatus_Err:
    UpdateStatus = False
UpdateStatus_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function InsertPriority(ByVal piPriority As String) As Boolean
On Error GoTo InsertPriority_Err

    Dim sql_str As String
    Dim lPriorityExists As Boolean
    
    EstablishConn
    
    ' Check if Priority already exists
    lPriorityExists = True
    lPriorityExists = CheckIfPriorityExists(piPriority)
    
    If lPriorityExists Then
        GoTo InsertPriority_Err
    End If
    
    ' Insert the Priority
    sql_str = "Insert into PS_Priority(P_Priority) Values(" & _
              "'" & piPriority & "')"
    
    Call cnn.Execute(sql_str)
    
    InsertPriority = True
    GoTo InsertPriority_Exit
    
InsertPriority_Err:
    InsertPriority = False
InsertPriority_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function CheckIfPriorityExists(ByVal piPriority As String) As Boolean
    Dim sql_str As String
    Dim lRs As ADODB.Recordset
    
    Set lRs = CreateObject("ADODB.RecordSet")
    EstablishConn
    
    sql_str = "Select * from PS_Priority Where P_Priority = '" & piPriority & "'"
    Set lRs = cnn.Execute(sql_str)
    
    If lRs.RecordCount > 0 Then
        CheckIfPriorityExists = True
    Else
        CheckIfPriorityExists = False
    End If
End Function

Public Function UpdatePriority(ByVal piPriorityID As Integer, ByVal piPriority As String) As Boolean
On Error GoTo UpdatePriority_Err

    Dim sql_str As String
    Dim lPriorityExists As Boolean
    
    EstablishConn
    
    ' Check if Priority already exists
    lPriorityExists = True
    lPriorityExists = CheckIfPriorityExists(piPriority)
    
    If lPriorityExists Then
        GoTo UpdatePriority_Err
    End If
    
    ' Insert the Priority
    sql_str = "Update PS_Priority Set P_Priority = '" & piPriority & "' Where P_PriorityID = " & piPriorityID
    
    Call cnn.Execute(sql_str)
    
    UpdatePriority = True
    GoTo UpdatePriority_Exit
    
UpdatePriority_Err:
    UpdatePriority = False
UpdatePriority_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function InsertSeverity(ByVal piSeverity As String) As Boolean
On Error GoTo InsertSeverity_Err

    Dim sql_str As String
    Dim lSeverityExists As Boolean
    
    EstablishConn
    
    ' Check if Severity already exists
    lSeverityExists = True
    lSeverityExists = CheckIfSeverityExists(piSeverity)
    
    If lSeverityExists Then
        GoTo InsertSeverity_Err
    End If
    
    ' Insert the Severity
    sql_str = "Insert into PS_Severity(S_Severity) Values(" & _
              "'" & piSeverity & "')"
    
    Call cnn.Execute(sql_str)
    
    InsertSeverity = True
    GoTo InsertSeverity_Exit
    
InsertSeverity_Err:
    InsertSeverity = False
InsertSeverity_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function CheckIfSeverityExists(ByVal piSeverity As String) As Boolean
    Dim sql_str As String
    Dim lRs As ADODB.Recordset
    
    Set lRs = CreateObject("ADODB.RecordSet")
    EstablishConn
    
    sql_str = "Select * from PS_Severity Where S_Severity = '" & piSeverity & "'"
    Set lRs = cnn.Execute(sql_str)
    
    If lRs.RecordCount > 0 Then
        CheckIfSeverityExists = True
    Else
        CheckIfSeverityExists = False
    End If
End Function

Public Function UpdateSeverity(ByVal piSeverityID As Integer, ByVal piSeverity As String) As Boolean
On Error GoTo UpdateSeverity_Err

    Dim sql_str As String
    Dim lSeverityExists As Boolean
    
    EstablishConn
    
    ' Check if Severity already exists
    lSeverityExists = True
    lSeverityExists = CheckIfSeverityExists(piSeverity)
    
    If lSeverityExists Then
        GoTo UpdateSeverity_Err
    End If
    
    ' Insert the Severity
    sql_str = "Update PS_Severity Set S_Severity = '" & piSeverity & "' Where S_SeverityID = " & piSeverityID
    
    Call cnn.Execute(sql_str)
    
    UpdateSeverity = True
    GoTo UpdateSeverity_Exit
    
UpdateSeverity_Err:
    UpdateSeverity = False
UpdateSeverity_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function ExecSQLRetRs(ByVal piSql As String) As ADODB.Recordset
    Dim lRs As ADODB.Recordset
    
    EstablishConn
    
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRs = cnn.Execute(piSql)
   
    Set ExecSQLRetRs = lRs
    
    If cnn.State = 1 Then CloseConnection
End Function

Public Function GenBugReport(ByVal lFileFullName As String, ByVal lBugsGroupID As Integer, ByVal lmodule1 As Integer, ByVal lstatus1 As Integer, ByVal lpriority1 As Integer, ByVal lseverity1 As Integer, ByVal lrepby1 As String, ByVal lresp1 As String, ByVal lfixedby1 As Integer, ByVal lverby1 As Integer, ByVal lStartDate As Date, ByVal lEndDate As Date, ByVal lShortDescription As String, ByVal lReportedBy As String, ByVal lReportedDate As String, ByVal lStatus As String, ByVal lModule As String, ByVal lPriority As String, ByVal lSeverity As String, ByVal lResponsibility As String, ByVal lEstimatedTime As String, ByVal lFixedBy As String, ByVal lFixedDate As String, ByVal lVerifiedBy As String, ByVal lVerifiedDate As String) As Boolean
On Error GoTo GenBugReport_Err
    Dim lTSObj As TimeSheet.clsTimeSheet
    Dim lRs As ADODB.Recordset
    Dim lNameRs As ADODB.Recordset
    Dim lName As String
    Dim lSql As String
    Dim lobjWdApp As Word.Application
    Dim lobjWdDoc As Word.Document

    Set lTSObj = CreateObject("TimeSheet.clsTimeSheet")
    Set lobjWdApp = CreateObject("Word.Application")
    Set lRs = CreateObject("ADODB.RecordSet")
    Set lNameRs = CreateObject("ADODB.RecordSet")
    lName = ""
    
    ' create an empty doc
    lobjWdApp.Documents.Add DocumentType:=wdNewBlankDocument
    
    ' Heading
    lobjWdApp.Selection.Font.Size = 18
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.TypeText Text:="Bugs Report"

    ' Reset the font
    lobjWdApp.Selection.Font.Size = 10
    lobjWdApp.Selection.Font.Bold = False
    
    ' header table
    lobjWdApp.ActiveDocument.Tables.Add Range:=lobjWdApp.Selection.Range, NumRows:=6, NumColumns:= _
    1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
    wdAutoFitFixed
    
    ' First row
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(1).Split 1, 2
    
    ' First col
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(1).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Group Name"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' Second col
    lName = ""
    Set lNameRs = lTSObj.GetGroupProfile(lBugsGroupID)
    If lNameRs.RecordCount > 0 Then
        lName = lNameRs("G_GroupName")
    End If
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(2).Width = 390
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=lName
    
    ' Second row
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(1).Split 1, 4
    
    ' second row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(1).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Start Date"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' second row, second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(2).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=CStr(lStartDate)
    
    ' second row, third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(3).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="End Date"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' second row, second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(4).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=CStr(lEndDate)
    
    ' Third row
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(1).Split 1, 4
    
    ' third row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(1).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Module"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' third row, second col
    lName = ""
    lName = GetModuleName(lmodule1, 0)
    If lName = "" Then
        lName = "All"
    End If
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(2).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=lName
    
    ' third row, third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(3).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Status"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' third row, fourth col
    lName = ""
    lName = GetStatusName(lstatus1)
    If lName = "" Then
        lName = "All"
    End If
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(4).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=lName
    
    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(1).Split 1, 4
    
    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(1).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Priority"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' Fourth row, second col
    lName = ""
    lName = GetPriority(lpriority1)
    If lName = "" Then
        lName = "All"
    End If
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(2).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=lName
    
    ' Fourth row, third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(3).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Severity"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' Fourth row, fourth col
    lName = ""
    lName = GetSeverity(lseverity1)
    If lName = "" Then
        lName = "All"
    End If
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(4).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=lName
    
    ' Fifth row
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(1).Split 1, 4
    
    ' Fifth row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(1).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Reported By"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' Fifth row, second col
    lName = ""
    Set lNameRs = lTSObj.GetUserProfile(lrepby1)
    If lNameRs.RecordCount > 0 Then
        lName = lNameRs("U_Name")
    End If
    If lName = "" Then
        lName = "All"
    End If
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(2).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=lName
    
    ' Fifth row, third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(3).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Responsibility"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' Fifth row, fourth col
    lName = ""
    Set lNameRs = lTSObj.GetUserProfile(lresp1)
    If lNameRs.RecordCount > 0 Then
        lName = lNameRs("U_Name")
    End If
    If lName = "" Then
        lName = "All"
    End If
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(4).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=lName
    
    ' Sixth row
    lobjWdApp.ActiveDocument.Tables(1).Rows(6).Cells(1).Split 1, 4
    
    ' Sixth row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(6).Cells(1).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(6).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Fixed By"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' Sixth row, second col
    lName = ""
    Set lNameRs = lTSObj.GetUserProfile(lfixedby1)
    If lNameRs.RecordCount > 0 Then
        lName = lNameRs("U_Name")
    End If
    If lName = "" Then
        lName = "All"
    End If
    lobjWdApp.ActiveDocument.Tables(1).Rows(6).Cells(2).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(6).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=lName
    
    ' Sixth row, third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(6).Cells(3).Width = 70
    lobjWdApp.ActiveDocument.Tables(1).Rows(6).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Verified By"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' Sixth row, fourth col
    lName = ""
    Set lNameRs = lTSObj.GetUserProfile(lverby1)
    If lNameRs.RecordCount > 0 Then
        lName = lNameRs("U_Name")
    End If
    If lName = "" Then
        lName = "All"
    End If
    lobjWdApp.ActiveDocument.Tables(1).Rows(6).Cells(4).Width = 160
    lobjWdApp.ActiveDocument.Tables(1).Rows(6).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeText Text:=lName
    
    ' Move one space down
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph

    Dim MyRange As Word.Range
    Dim lCount As Integer
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd
    
    ' Determine the number of columns for the second table
    Dim lColCount As Integer
    
    lColCount = 1
    
    If lShortDescription = "Y" Then
        lColCount = lColCount + 1
    End If
    If lReportedBy = "Y" Then
        lColCount = lColCount + 1
    End If
    If lReportedDate = "Y" Then
        lColCount = lColCount + 1
    End If
    If lStatus = "Y" Then
        lColCount = lColCount + 1
    End If
    If lModule = "Y" Then
        lColCount = lColCount + 1
    End If
    If lPriority = "Y" Then
        lColCount = lColCount + 1
    End If
    If lSeverity = "Y" Then
        lColCount = lColCount + 1
    End If
    If lResponsibility = "Y" Then
        lColCount = lColCount + 1
    End If
    If lEstimatedTime = "Y" Then
        lColCount = lColCount + 1
    End If
    If lFixedBy = "Y" Then
        lColCount = lColCount + 1
    End If
    If lFixedDate = "Y" Then
        lColCount = lColCount + 1
    End If
    If lVerifiedBy = "Y" Then
        lColCount = lColCount + 1
    End If
    If lVerifiedDate = "Y" Then
        lColCount = lColCount + 1
    End If
    
    ' Create the second table
    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=1, NumColumns:= _
        lColCount, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    
    ' Header for the bugs report table
    Dim lIdx As Integer
    Dim lCellWidth As Integer
    
    lIdx = 1
    lCellWidth = 460 / lColCount
    
    ' header row, first col
    lobjWdApp.ActiveDocument.Tables(2).AllowAutoFit = False
    lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
    lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Identifier"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    If lShortDescription = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Short Description"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lReportedBy = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Reported By"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lReportedDate = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Reported Date"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lStatus = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Status"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lModule = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Module"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lPriority = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Priority"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lSeverity = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Severity"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lResponsibility = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Responsibility"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lEstimatedTime = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Estimated Time"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lFixedBy = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Fixed By"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lFixedDate = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Fixed Date"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lVerifiedBy = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Verified By"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    If lVerifiedDate = "Y" Then
        lIdx = lIdx + 1
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Width = lCellWidth
        lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(lIdx).Select
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.Font.Bold = True
        lobjWdApp.Selection.TypeText Text:="Verified Date"
        lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    End If
    
    ' repeat the header for each page
    lobjWdApp.ActiveDocument.Tables(2).Rows(1).HeadingFormat = True
    
    ' Dynamically generate rows
    Dim lRowCount  As Integer
    lRowCount = 1
    
    'Set lRs = Display(lBugsGroupID, lmodule1, lstatus1, lpriority1, lseverity1, lrepby1, lresp1, lfixedby1, lverby1, lStartDate, lEndDate)
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
        While Not lRs.EOF
            lIdx = 0
            
            ' Add a new row
            lobjWdApp.ActiveDocument.Tables(2).Rows.Add
            lRowCount = lRowCount + 1
            
            ' Identfier
            lIdx = lIdx + 1
            lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
            lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
            lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            lobjWdApp.Selection.Font.Bold = False
            lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
            lobjWdApp.Selection.TypeText Text:=Trim(lRs("BR_Identifier"))
            
            If lShortDescription = "Y" Then
                lIdx = lIdx + 1
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("BR_ShortDescription"))
            End If
            If lReportedBy = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                Set lNameRs = lTSObj.GetUserProfile(Val(Trim(lRs("BR_ReportedBy"))))
                If lNameRs.RecordCount > 0 Then
                    lName = lNameRs("U_Name")
                End If
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lReportedDate = "Y" Then
                lIdx = lIdx + 1
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("BR_ReportedDate"))
            End If
            If lStatus = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                lName = GetStatusName(Val(Trim(lRs("S_StatusID"))))
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lModule = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                'lName = GetModuleName(Val(Trim(lRs("M_ModuleID"))))
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lPriority = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                lName = GetPriority(Val(Trim(lRs("P_PriorityID"))))
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lSeverity = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                lName = GetSeverity(Val(Trim(lRs("S_SeverityID"))))
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lResponsibility = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                Set lNameRs = lTSObj.GetUserProfile(Val(Trim(lRs("BR_Responsibility"))))
                If lNameRs.RecordCount > 0 Then
                    lName = lNameRs("U_Name")
                End If
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lEstimatedTime = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                If Not IsNull(lRs("BR_EstimatedTime")) Then
                    lName = lRs("BR_EstimatedTime")
                End If
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lFixedBy = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                Set lNameRs = lTSObj.GetUserProfile(Val(Trim(lRs("BR_FixedBy"))))
                If lNameRs.RecordCount > 0 Then
                    lName = lNameRs("U_Name")
                End If
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lFixedDate = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                If Not IsNull(lRs("BR_FixedDate")) Then
                    lName = lRs("BR_FixedDate")
                End If
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lVerifiedBy = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                Set lNameRs = lTSObj.GetUserProfile(Val(Trim(lRs("BR_VerifiedBy"))))
                If lNameRs.RecordCount > 0 Then
                    lName = lNameRs("U_Name")
                End If
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            If lVerifiedDate = "Y" Then
                lIdx = lIdx + 1
                lName = ""
                If Not IsNull(lRs("BR_VerifiedDate")) Then
                    lName = lRs("BR_VerifiedDate")
                End If
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Width = lCellWidth
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(lIdx).Select
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.Cells.Shading.Texture = wdTextureNone
                lobjWdApp.Selection.TypeText Text:=lName
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' save the document
    lobjWdApp.ActiveDocument.SaveAs FileName:=lFileFullName

    lobjWdApp.Visible = False
    
    GenBugReport = True
    GoTo GenBugReport_Exit
    
GenBugReport_Err:
    GenBugReport = False
GenBugReport_Exit:
    Set lTSObj = Nothing
    Set lobjWdApp = Nothing
    Set lRs = Nothing
End Function

Public Function GetReportsFileName(ByVal piBugsGroupID As Integer, ByVal piDate As Date) As String
    Dim lFileName As String
    Dim lDate As Date
    Dim lTime As Date
    Dim lStartDay As Long
    Dim lStartMonth As Long
    Dim lStartYear As Long
    Dim lDay As Long
    Dim lMonth As Long
    Dim lYear As Long
    Dim lHour As Long
    Dim lMin As Long
    Dim lSec As Long
    Dim lTempTime As String
    Dim lTempDate As String
    Dim lIdx As Integer
    
    lStartDay = Day(piDate)
    lStartMonth = Month(piDate)
    lStartYear = Year(piDate)
    lTempDate = lStartDay & lStartMonth & lStartYear
    
    lTime = Now()
    lDay = Day(lTime)
    lMonth = Month(lTime)
    lYear = Year(lTime)
    lHour = Hour(lTime)
    lMin = Minute(lTime)
    lSec = Second(lTime)
    lTempTime = lDay & lMonth & lYear & "_" & lHour & lMin & lSec
    
    lFileName = "BugReport_" & piBugsGroupID & "_" & lTempDate & "_" & lTempTime & ".doc"
    GetReportsFileName = lFileName
End Function

Public Function InsertBugsDatabase(ByVal piProjectID As Integer, ByVal piDBName As String, ByVal piBugsDatabaseDesc As String) As Boolean
On Error GoTo InsertBugsDatabase_Err

    Dim sql_str As String
    Dim lBugsDatabaseExists As Boolean
    Dim lProjectExists As Boolean
    Dim lTSObj As TimeSheet.clsTimeSheet
    
    Set lTSObj = CreateObject("TimeSheet.clsTimeSheet")

    EstablishConn
    
    ' Check if project exists
    lProjectExists = True
    lProjectExists = lTSObj.CheckIfGroupExists(piProjectID)
  
    If Not lProjectExists Then
        GoTo InsertBugsDatabase_Err
    End If
    
    ' Insert the BugsDatabase
    sql_str = "Insert into PS_Database(DB_Name, DB_Description, G_GroupID) Values(" & _
              "'" & piDBName & "', " & _
              "'" & piBugsDatabaseDesc & "', " & _
              piProjectID & ")"
    
    Call cnn.Execute(sql_str)
    
    InsertBugsDatabase = True
    GoTo InsertBugsDatabase_Exit
    
InsertBugsDatabase_Err:
    InsertBugsDatabase = False
InsertBugsDatabase_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function UpdateBugsDatabase(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer, ByVal piDBName As String, ByVal piBugsDatabaseDesc As String) As Boolean
On Error GoTo UpdateBugsDatabase_Err

    Dim sql_str As String
    Dim lBugsDatabaseExists As Boolean
    
    EstablishConn
    
    ' Insert the BugsDatabase
    sql_str = "Update PS_Database Set DB_Name = '" & piDBName & "', " & _
                                      " DB_Description = '" & piBugsDatabaseDesc & "' " & _
                                      " Where BD_DatabaseID = " & piDatabaseID & _
                                      " And G_GroupID = " & piProjectID
    
    Call cnn.Execute(sql_str)
    
    UpdateBugsDatabase = True
    GoTo UpdateBugsDatabase_Exit
    
UpdateBugsDatabase_Err:
    UpdateBugsDatabase = False
UpdateBugsDatabase_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function DeleteBugsDatabase(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer) As Boolean
On Error GoTo DeleteBugsDatabase_Err
    Dim sql_str2
    
    EstablishConn
    sql_str2 = "Delete From PS_Database Where BD_DatabaseID = " & piDatabaseID & " And G_GroupID = " & piProjectID
    cnn.Execute (sql_str2)
    If cnn.State = 1 Then CloseConnection
    DeleteBugsDatabase = True
    
    GoTo DeleteBugsDatabase_Exit
DeleteBugsDatabase_Err:
    DeleteBugsDatabase = False
DeleteBugsDatabase_Exit:
End Function

Public Function GetBugsDatabase(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer) As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    Dim where_clause As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    where_clause = ""
    If (piProjectID <> 0) Then
        where_clause = " G_GroupID = " & piProjectID
    End If
    
    If (piDatabaseID <> 0) Then
        If where_clause <> "" Then
            where_clause = where_clause & " And BD_DatabaseID = " & piDatabaseID
        Else
            where_clause = " BD_DatabaseID = " & piDatabaseID
        End If
    End If
    
    If (where_clause <> "") Then
        sql_str = "Select * from PS_Database Where " & where_clause
    Else
        sql_str = "Select * from PS_Database"
    End If
    
    Set rst = cnn.Execute(sql_str)
    
    Set GetBugsDatabase = rst
    If cnn.State = 1 Then CloseConnection
    
    Set rst = Nothing
End Function

Public Function CheckIfBugsDatabaseExists(ByVal piProjectID As Integer, ByVal piDBName As String) As Boolean
    Dim sql_str As String
    Dim lRs As ADODB.Recordset
    
    Set lRs = CreateObject("ADODB.RecordSet")
    EstablishConn
    
    sql_str = "Select * from PS_Database Where DB_Name = '" & piDBName & "' And G_GroupID = " & piProjectID
    Set lRs = cnn.Execute(sql_str)
    
    If lRs.RecordCount > 0 Then
        CheckIfBugsDatabaseExists = True
    Else
        CheckIfBugsDatabaseExists = False
    End If
    
    If cnn.State = 1 Then CloseConnection
End Function

Public Function InsertModule(ByVal piProjectID As String, ByVal piModule As String, ByVal piModuleDesc As String) As Boolean
On Error GoTo InsertModule_Err

    Dim sql_str As String
    Dim lModuleExists As Boolean
    
    EstablishConn
    
    ' Check if Module already exists
    lModuleExists = True
    lModuleExists = CheckIfModuleExists(piProjectID, piModule)
    
    If lModuleExists Then
        GoTo InsertModule_Err
    End If
    
    ' Insert the Module
    sql_str = "Insert into P_Modules(G_GroupID, M_ModuleName, M_ModuleDescription) Values(" & _
              piProjectID & "," & _
              "'" & piModule & "'," & _
              "'" & piModuleDesc & "')"
    
    Call cnn.Execute(sql_str)
    
    InsertModule = True
    GoTo InsertModule_Exit
    
InsertModule_Err:
    InsertModule = False
InsertModule_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function CheckIfModuleExists(ByVal piProjectID As Integer, ByVal piModule As String) As Boolean
    Dim sql_str As String
    Dim lRs As ADODB.Recordset
    
    Set lRs = CreateObject("ADODB.RecordSet")
    EstablishConn
    
    sql_str = "Select * from P_Modules Where M_ModuleName = '" & piModule & "' And G_GroupID = " & piProjectID
    Set lRs = cnn.Execute(sql_str)
    
    If lRs.RecordCount > 0 Then
        CheckIfModuleExists = True
    Else
        CheckIfModuleExists = False
    End If
End Function

Public Function UpdateModule(ByVal piProjectID As Integer, ByVal piModuleID As Integer, ByVal piModule As String, ByVal piModuleDesc As String) As Boolean
On Error GoTo UpdateModule_Err

    Dim sql_str As String
    Dim lModuleExists As Boolean
    
    EstablishConn
    
    ' Insert the Module
    sql_str = "Update P_Modules Set M_ModuleName = '" & piModule & "'" & _
                                   ", M_ModuleDescription = '" & piModuleDesc & "'" & _
                                   " Where M_ModuleID = " & piModuleID
    
    Call cnn.Execute(sql_str)
    
    UpdateModule = True
    GoTo UpdateModule_Exit
    
UpdateModule_Err:
    UpdateModule = False
UpdateModule_Exit:
    If cnn.State = 1 Then CloseConnection
End Function

Public Function DeleteModule(ByVal piProjectID As Integer, ByVal piModuleID As Integer) As Boolean
On Error GoTo DeleteModule_Err
    Dim sql_str2
    
    EstablishConn
    sql_str2 = "Delete From P_Modules Where M_ModuleID = " & piModuleID & " And G_GroupID = " & piProjectID
    cnn.Execute (sql_str2)
    If cnn.State = 1 Then CloseConnection
    DeleteModule = True
    
    GoTo DeleteModule_Exit
DeleteModule_Err:
    DeleteModule = False
DeleteModule_Exit:
End Function

Public Function GetAffectedPrograms(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer) As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str = "Select Distinct(BR_AffectedProgram) From PS_Reports " & _
              " Where G_GroupID = " & piProjectID & _
              " And BD_DatabaseID = " & piDatabaseID & _
              " Order By BR_AffectedProgram"
    Set rst = cnn.Execute(sql_str)
    
    Set GetAffectedPrograms = rst
    If cnn.State = 1 Then CloseConnection
    
    Set rst = Nothing
End Function

Public Function GetTestCases(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer) As ADODB.Recordset
    Dim rst As ADODB.Recordset
    Dim sql_str As String
    
    EstablishConn
    Set rst = CreateObject("ADODB.Recordset")
    
    sql_str = "Select Distinct(BR_TestCaseID) From PS_Reports " & _
              " Where G_GroupID = " & piProjectID & _
              " And BD_DatabaseID = " & piDatabaseID & _
              " Order By BR_TestCaseID"
    Set rst = cnn.Execute(sql_str)
    
    Set GetTestCases = rst
    If cnn.State = 1 Then CloseConnection
    
    Set rst = Nothing
End Function

 Public Function UpdateUserProblem(ByVal piProjectID As Integer, ByVal piDatabaseID As Integer, ByVal piIdentifier As Integer, ByVal pi_strTitle As String, ByVal pi_strDesc As String, ByVal piSteps As String, ByVal piAffProg As String, ByVal piProgVersion As String, ByVal piTestCaseID As String) As Boolean
 On Error GoTo UpdateUserProblem_Err
    Dim lDate As String
    Dim llast_mod As String
    Dim sql_str As String
    Dim recAfft

    EstablishConn
    lDate = FormatDateTime(Now(), vbShortDate)
    llast_mod = FormatDateTime(Now(), vbGeneralDate)

    sql_str = "Update PS_Reports Set " & _
                "BR_ShortDescription = '" & pi_strTitle & "'," & _
                "BR_LongDescription = '" & pi_strDesc & "'," & _
                "BR_StepsToRecreate = '" & piSteps & "'," & _
                "BR_AffectedProgram = '" & piAffProg & "'," & _
                "BR_VersionBeforeFix = '" & piProgVersion & "'," & _
                "BR_TestCaseID = '" & piTestCaseID & "'," & _
                "BR_LastModified = '" & llast_mod & "'"
    
    sql_str = sql_str & " Where BR_Identifier = " & piIdentifier & _
                        " And G_GroupID = " & piProjectID & _
                        " And BD_DatabaseID = " & piDatabaseID
    
    cnn.Execute sql_str, recAfft
    If (recAfft > 0) Then
        UpdateUserProblem = True
    Else
        UpdateUserProblem = False
    End If
    If cnn.State = 1 Then CloseConnection
    GoTo UpdateUserProblem_Exit:
UpdateUserProblem_Err:
    UpdateUserProblem = False
UpdateUserProblem_Exit:
End Function


