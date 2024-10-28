VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 1  'NoTransaction
END
Attribute VB_Name = "clsTimeSheet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Public Function CheckIfMonday(ByVal piDate As Date)
    If Weekday(piDate) = vbMonday Then
        CheckIfMonday = True
    Else
        CheckIfMonday = False
    End If
End Function

Public Function GetProjects() As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select P_ProjectID, P_ProjectName from TS_Projects Order by P_ProjectName"
    Set lRs = lCnn.Execute(lSql)

    Set GetProjects = lRs
    
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetCodes() As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select AC_Description from TS_ActivityCodes Order By AC_Description"
    Set lRs = lCnn.Execute(lSql)

    Set GetCodes = lRs
    
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function InsertWTSDay(ByVal piUserID As Integer, ByVal piDate As Date, ByVal piProject As String, ByVal piCode As String, ByVal piMon As Double, ByVal piTue As Double, ByVal piWed As Double, ByVal piThu As Double, ByVal piFri As Double, ByVal piSat As Double, ByVal piSun As Double) As Boolean
On Error GoTo InsertWTSDay_Err

    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    Dim lProjectID As Integer
    Dim lCodeID As Integer
    
    If (piMon = 0 And piTue = 0 And piWed = 0 And piThu = 0 And piFri = 0 And piSat = 0 And piSun = 0) Then
        InsertWTSDay = True
        GoTo InsertWTSDay_Exit
    End If
    
    Set lCnn = CreateObject("ADODB.Connection")
    Call lCnn.Open("TimeSheet", "sa", "")
    Set lRs = CreateObject("ADODB.Recordset")
    
    ' Get the Project ID, CodeID
    lSql = "Select P_ProjectID from TS_Projects Where P_ProjectName='" & piProject & "'"
    Set lRs = lCnn.Execute(lSql)
    lProjectID = Trim(lRs("P_ProjectID"))
   
    lSql = "Select AC_Code from TS_ActivityCodes Where AC_Description='" & piCode & "'"
    Set lRs = lCnn.Execute(lSql)
    lCodeID = Trim(lRs("AC_Code"))
    
    ' Create the SQL statement for insert into TS_WeeklyTimeSheet table
    lSql = "Insert Into TS_WeeklyTimeSheet Values(" & lCodeID & "," & lProjectID & "," & piUserID & ",'" & piDate & "'," & piMon & "," & piTue & "," & piWed & "," & piThu & "," & piFri & "," & piSat & "," & piSun & ")"
    lCnn.Execute (lSql)
    InsertWTSDay = True
    GoTo InsertWTSDay_Exit
    
InsertWTSDay_Err:
    InsertWTSDay = False
InsertWTSDay_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function


Public Function GetTS(ByVal piUserID As Integer, ByVal piMonDate As Date) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get the record set
    lSql = "SELECT P_ProjectID, AC_Code, WTS_StartDate, WTS_MonHrs, WTS_TueHrs, WTS_WedHrs, WTS_ThuHrs, WTS_FriHrs, WTS_SatHrs, WTS_SunHrs From TS_WeeklyTimeSheet Where " & _
           " WTS_StartDate = '" & piMonDate & "' AND U_Employee_ID = " & piUserID
        
    Set lRs = lCnn.Execute(lSql)
    
    Set GetTS = lRs
    
    Set lCnn = Nothing
    Set lRs = Nothing
End Function


Public Function UpdateWTSDay(ByVal piUserID As Integer, ByVal piDate As Date, ByVal piProject As String, ByVal piCode As String, ByVal piMon As Double, ByVal piTue As Double, ByVal piWed As Double, ByVal piThu As Double, ByVal piFri As Double, ByVal piSat As Double, ByVal piSun As Double, ByVal piOrgCode As String, ByVal piOrgProject As String) As Boolean
On Error GoTo UpdateWTSDay_Err
    
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    Dim lRs1 As ADODB.Recordset
    Dim lProjectID As Integer
    Dim lCodeID As Integer
    Dim lOrgProjectID As Integer
    Dim lOrgCodeID As Integer
    
    Dim lInsertFlag As Boolean
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRs1 = CreateObject("ADODB.Recordset")
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get the Project ID, CodeID
    lSql = "Select P_ProjectID from TS_Projects Where P_ProjectName='" & piProject & "'"
    Set lRs = lCnn.Execute(lSql)
    lProjectID = Trim(lRs("P_ProjectID"))
   
    lSql = "Select AC_Code from TS_ActivityCodes Where AC_Description='" & piCode & "'"
    Set lRs = lCnn.Execute(lSql)
    lCodeID = Trim(lRs("AC_Code"))

    ' Get the Original Project ID, CodeID
    If piOrgProject <> "" Then
        lSql = "Select P_ProjectID from TS_Projects Where P_ProjectName='" & piOrgProject & "'"
        Set lRs = lCnn.Execute(lSql)
        lOrgProjectID = Trim(lRs("P_ProjectID"))
    End If
   
    If piOrgCode <> "" Then
        lSql = "Select AC_Code from TS_ActivityCodes Where AC_Description='" & piOrgCode & "'"
        Set lRs = lCnn.Execute(lSql)
        lOrgCodeID = Trim(lRs("AC_Code"))
    End If
    
    ' Check whether a record exists for this user,code, project and date
    If (piOrgCode = "" Or piOrgProject = "") Then
        ' Just call insert
        lInsertFlag = InsertWTSDay(piUserID, piDate, piProject, piCode, piMon, piTue, piWed, piThu, piFri, piSat, piSun)
        UpdateWTSDay = lInsertFlag
        GoTo UpdateWTSDay_Exit
    End If
    
    ' Check if all the hours are 0, then delete
    If (piMon = 0 And piTue = 0 And piWed = 0 And piThu = 0 And piFri = 0 And piSat = 0 And piSun = 0) Then
        lSql = "Delete From TS_WeeklyTimeSheet Where " & _
            " U_Employee_ID = " & piUserID & _
            " And AC_Code = " & lOrgCodeID & _
            " And P_ProjectID = " & lOrgProjectID & _
            " And WTS_StartDate = '" & piDate & "'"
        Call lCnn.Execute(lSql)
        UpdateWTSDay = True
        GoTo UpdateWTSDay_Exit
    End If

    ' Update should be done here
    lSql = "Update TS_WeeklyTimeSheet Set " & _
           " AC_Code = " & lCodeID & _
           " ,P_ProjectID = " & lProjectID & _
           " ,WTS_MonHrs = " & piMon & _
           " ,WTS_TueHrs = " & piTue & _
           " ,WTS_WedHrs = " & piWed & _
           " ,WTS_ThuHrs = " & piThu & _
           " ,WTS_FriHrs = " & piFri & _
           " ,WTS_SatHrs = " & piSat & _
           " ,WTS_SunHrs = " & piSun & _
           " Where" & _
            " U_Employee_ID = " & piUserID & _
            " And AC_Code = " & lOrgCodeID & _
            " And P_ProjectID = " & lOrgProjectID & _
            " And WTS_StartDate = '" & piDate & "'"
    
    lCnn.Execute (lSql)
    UpdateWTSDay = True
    GoTo UpdateWTSDay_Exit
    
UpdateWTSDay_Err:
    UpdateWTSDay = False
UpdateWTSDay_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
    Set lRs1 = Nothing
End Function

Public Function CheckIfTSExists(ByVal piUserID As Integer, ByVal piDate As Date) As Boolean
On Error GoTo CheckIfTSExists_Err
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_WeeklyTimeSheet Where " & _
           " U_Employee_ID = " & piUserID & _
           " And WTS_StartDate = '" & piDate & "'"
    Set lRs = lCnn.Execute(lSql)
    If (lRs.RecordCount = 0) Then
        CheckIfTSExists = False
    Else
        CheckIfTSExists = True
    End If
    GoTo CheckIfTSExists_Exit
    
CheckIfTSExists_Err:
    CheckIfTSExists = False
CheckIfTSExists_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function CheckIfValidLogin(ByVal piEmpID As Integer, ByVal piPassword As String) As Boolean
On Error GoTo CheckIfValidLogin_Err
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_Users Where " & _
           " U_Employee_ID = " & piEmpID & _
           " And U_Password = '" & piPassword & "'"
    Set lRs = lCnn.Execute(lSql)
    
    If (lRs.RecordCount = 0) Then
        CheckIfValidLogin = False
    Else
        CheckIfValidLogin = True
    End If
    GoTo CheckIfValidLogin_Exit
    
CheckIfValidLogin_Err:
    CheckIfValidLogin = False
CheckIfValidLogin_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GenTSForUser(ByVal piFileName As String, ByVal piEmpID As Integer, ByVal piDate As Date) As Boolean
On Error GoTo GenTSForUser_Err
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lRsName As ADODB.Recordset
    Dim lSql As String
    Dim lobjXlApp As Excel.Application
    Dim lobjXlWb As Excel.Workbook
    Dim lobjXlWs As Excel.Worksheet
    Dim lSunDate As Date
    Dim lProjectName As String
    Dim lIdx As Integer
    Dim lCodeTotal As Double
    Dim lMonTotal As Double
    Dim lTueTotal As Double
    Dim lWedTotal As Double
    Dim lThuTotal As Double
    Dim lFriTotal As Double
    Dim lSatTotal As Double
    Dim lSunTotal As Double
    Dim lTotal As Double
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRsName = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get the record set for the given input arguments
    lSql = "Select * from TS_WeeklyTimeSheet Where " & _
           " U_Employee_ID = " & piEmpID & _
           " And WTS_StartDate = '" & piDate & "'"
    
    Set lRs = lCnn.Execute(lSql)
    
    If (lRs.RecordCount = 0) Then
        GenTSForUser = False
        GoTo GenTSForUser_Err
    Else
        GenTSForUser = True
    End If
   
    ' Create the excel sheet
    Set lobjXlApp = CreateObject("Excel.Application")
    Set lobjXlWb = lobjXlApp.Workbooks.Add() ' Adding the workbooks to the Xl Application
    Set lobjXlWs = lobjXlApp.Worksheets.Add() ' Adding the worksheet to the work book
    
    lobjXlApp.Visible = False
    lobjXlApp.Worksheets("Sheet1").Activate
    lobjXlApp.Worksheets("Sheet1").Name = "Time Sheet"
    
    Application.DisplayAlerts = False
    lobjXlApp.Worksheets("Sheet2").Delete
    lobjXlApp.Worksheets("Sheet3").Delete
    lobjXlApp.Worksheets("Sheet4").Delete
    
    ' Fill the title
    lobjXlApp.Range("A1:I1").MergeCells = True
    lobjXlApp.Range("A1").Value = "Time Sheet"
    lobjXlApp.Range("A1").Font.Name = "Times New Roman"
    lobjXlApp.Range("A1").Font.Bold = True
    lobjXlApp.Range("A1").Font.Size = 14
    lobjXlApp.Range("A1").HorizontalAlignment = xlCenter
    Rows("1:1").RowHeight = 20.25
    lobjXlApp.Range("A1:I1").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    ' Fill the Heading rows
    lobjXlApp.Range("4:4").RowHeight = 25.5
    lobjXlApp.Range("8:8").RowHeight = 25.5
    lobjXlApp.Range("A:A").ColumnWidth = 7.14
    lobjXlApp.Range("B:B").ColumnWidth = 31.4
    lobjXlApp.Range("J:J").ColumnWidth = 28.4
    
    lobjXlApp.Range("A4").Value = "Name"
    lobjXlApp.Range("A4").Font.Name = "Times New Roman"
    lobjXlApp.Range("A4").Font.Bold = True
    lobjXlApp.Range("A4").Font.Size = 10
    lobjXlApp.Range("A4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeRight).LineStyle = xlContinuous

    ' Get the name and display
    lSql = "Select U_Name From TS_Users Where " & _
           "U_Employee_ID = " & piEmpID
    Set lRsName = lCnn.Execute(lSql)
    If (lRsName.RecordCount = 0) Then
        GoTo GenTSForUser_Err
    End If
    
    lobjXlApp.Range("B4").Value = Trim(lRsName("U_Name"))
    lobjXlApp.Range("B4").Font.Name = "Times New Roman"
    lobjXlApp.Range("B4").Font.Size = 10
    lobjXlApp.Range("B4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeRight).LineStyle = xlContinuous
        
    lobjXlApp.Range("C4:D4").MergeCells = True
    lobjXlApp.Range("C4").Value = "From (date)"
    lobjXlApp.Range("C4").Font.Name = "Times New Roman"
    lobjXlApp.Range("C4").Font.Bold = True
    lobjXlApp.Range("C4").Font.Size = 10
    lobjXlApp.Range("C4:D4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    
    lobjXlApp.Range("E4").Value = piDate
    lobjXlApp.Range("E4").Font.Name = "Times New Roman"
    lobjXlApp.Range("E4").Font.Size = 10
    lobjXlApp.Range("E4:F4").MergeCells = True
    lobjXlApp.Range("E4:F4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G4").Value = "Emp. Code"
    lobjXlApp.Range("G4").Font.Name = "Times New Roman"
    lobjXlApp.Range("G4").Font.Bold = True
    lobjXlApp.Range("G4").Font.Size = 10
    lobjXlApp.Range("G4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H4:I4").MergeCells = True
    lobjXlApp.Range("H4").Value = piEmpID
    lobjXlApp.Range("H4").Font.Name = "Times New Roman"
    lobjXlApp.Range("H4:I4").Font.Size = 10
    lobjXlApp.Range("H4:I4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("A5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("C5:D5").MergeCells = True
    lobjXlApp.Range("C5").Value = "To(date)"
    lobjXlApp.Range("C5").Font.Name = "Times New Roman"
    lobjXlApp.Range("C5").Font.Bold = True
    lobjXlApp.Range("C5").Font.Size = 10
    lobjXlApp.Range("C5:D5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    ' Get the to date
    lSunDate = piDate + 6
    
    lobjXlApp.Range("E5:F5").MergeCells = True
    lobjXlApp.Range("E5").Value = lSunDate
    lobjXlApp.Range("E5").Font.Name = "Times New Roman"
    lobjXlApp.Range("E5").Font.Size = 10
    lobjXlApp.Range("E5:F5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("G5").Value = "Dept."
    lobjXlApp.Range("G5").Font.Name = "Times New Roman"
    lobjXlApp.Range("G5").Font.Bold = True
    lobjXlApp.Range("G5").Font.Size = 10
    lobjXlApp.Range("G5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H5:I5").MergeCells = True
    lobjXlApp.Range("H5:I5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    ' Timesheet table
    lobjXlApp.Range("A8").Value = "Activity Code"
    lobjXlApp.Range("A8").WrapText = True
    lobjXlApp.Range("A8").Font.Name = "Times New Roman"
    lobjXlApp.Range("A8").Font.Bold = True
    lobjXlApp.Range("A8").Font.Size = 10
    lobjXlApp.Range("A8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B8").Value = "Project"
    lobjXlApp.Range("B8").Font.Name = "Times New Roman"
    lobjXlApp.Range("B8").Font.Bold = True
    lobjXlApp.Range("B8").Font.Size = 10
    lobjXlApp.Range("B8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("C8:I8").MergeCells = True
    lobjXlApp.Range("C8").Value = "Time spent (in hours)"
    lobjXlApp.Range("C8").Font.Name = "Times New Roman"
    lobjXlApp.Range("C8").Font.Bold = True
    lobjXlApp.Range("C8").Font.Size = 10
    lobjXlApp.Range("C8").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C8:I8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("A9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    'lobjXlApp.Range("B9").Interior.ColorIndex = 15
    'lobjXlApp.Range("B9").Interior.Pattern = xlSolid
    
    lobjXlApp.Range("C9").Value = "Mon"
    lobjXlApp.Range("C9").Font.Name = "Times New Roman"
    lobjXlApp.Range("C9").Font.Bold = True
    lobjXlApp.Range("C9").Font.Size = 10
    lobjXlApp.Range("C9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("D9").Value = "Tue"
    lobjXlApp.Range("D9").Font.Name = "Times New Roman"
    lobjXlApp.Range("D9").Font.Bold = True
    lobjXlApp.Range("D9").Font.Size = 10
    lobjXlApp.Range("D9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("D9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E9").Value = "Wed"
    lobjXlApp.Range("E9").Font.Name = "Times New Roman"
    lobjXlApp.Range("E9").Font.Bold = True
    lobjXlApp.Range("E9").Font.Size = 10
    lobjXlApp.Range("E9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("E9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("F9").Value = "Thu"
    lobjXlApp.Range("F9").Font.Name = "Times New Roman"
    lobjXlApp.Range("F9").Font.Bold = True
    lobjXlApp.Range("F9").Font.Size = 10
    lobjXlApp.Range("F9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("F9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G9").Value = "Fri"
    lobjXlApp.Range("G9").Font.Name = "Times New Roman"
    lobjXlApp.Range("G9").Font.Bold = True
    lobjXlApp.Range("G9").Font.Size = 10
    lobjXlApp.Range("G9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("G9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H9").Value = "Sat"
    lobjXlApp.Range("H9").Font.Name = "Times New Roman"
    lobjXlApp.Range("H9").Font.Bold = True
    lobjXlApp.Range("H9").Font.Size = 10
    lobjXlApp.Range("H9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("H9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("I9").Value = "Sun"
    lobjXlApp.Range("I9").Font.Name = "Times New Roman"
    lobjXlApp.Range("I9").Font.Bold = True
    lobjXlApp.Range("I9").Font.Size = 10
    lobjXlApp.Range("I9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("I9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("J9").Value = "Net Time for each activity"
    lobjXlApp.Range("J9").Font.Name = "Times New Roman"
    lobjXlApp.Range("J9").Font.Bold = True
    lobjXlApp.Range("J9").Font.Size = 10
    lobjXlApp.Range("J9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("J9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    ' Now file the hours from the table
    lTotal = 0
    lMonTotal = 0
    lTueTotal = 0
    lWedTotal = 0
    lThuTotal = 0
    lFriTotal = 0
    lSatTotal = 0
    lSunTotal = 0
    
    lIdx = 0
    While Not lRs.EOF
        lIdx = lIdx + 1
        
        ' Get the project name from project id
        lProjectName = GetProjectName(Trim(lRs("P_ProjectID")))
    
        lobjXlApp.Range("A" & (9 + lIdx)).Value = Trim(lRs("AC_Code"))
        lobjXlApp.Range("A" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("A" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("B" & (9 + lIdx)).Value = lProjectName
        lobjXlApp.Range("B" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("B" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("C" & (9 + lIdx)).Value = Trim(lRs("WTS_MonHrs"))
        lobjXlApp.Range("C" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("C" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("D" & (9 + lIdx)).Value = Trim(lRs("WTS_TueHrs"))
        lobjXlApp.Range("D" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("D" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("E" & (9 + lIdx)).Value = Trim(lRs("WTS_WedHrs"))
        lobjXlApp.Range("E" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("E" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("F" & (9 + lIdx)).Value = Trim(lRs("WTS_ThuHrs"))
        lobjXlApp.Range("F" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("F" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("G" & (9 + lIdx)).Value = Trim(lRs("WTS_FriHrs"))
        lobjXlApp.Range("G" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("G" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("H" & (9 + lIdx)).Value = Trim(lRs("WTS_SatHrs"))
        lobjXlApp.Range("H" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("H" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("I" & (9 + lIdx)).Value = Trim(lRs("WTS_SunHrs"))
        lobjXlApp.Range("I" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("I" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
 
        ' Row total
        lCodeTotal = Val(Trim(lRs("WTS_MonHrs"))) + _
                     Val(Trim(lRs("WTS_TueHrs"))) + _
                     Val(Trim(lRs("WTS_WedHrs"))) + _
                     Val(Trim(lRs("WTS_ThuHrs"))) + _
                     Val(Trim(lRs("WTS_FriHrs"))) + _
                     Val(Trim(lRs("WTS_SatHrs"))) + _
                     Val(Trim(lRs("WTS_SunHrs")))
       
        lobjXlApp.Range("J" & (9 + lIdx)).Value = lCodeTotal
        lobjXlApp.Range("J" & (9 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("J" & (9 + lIdx)).Font.Size = 10
        lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
        lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
        lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        lobjXlApp.Range("J" & (9 + lIdx)).Interior.ColorIndex = 15
        lobjXlApp.Range("J" & (9 + lIdx)).Interior.Pattern = xlSolid
        
        ' Column Total
        lMonTotal = lMonTotal + Val(Trim(lRs("WTS_MonHrs")))
        lTueTotal = lTueTotal + Val(Trim(lRs("WTS_TueHrs")))
        lWedTotal = lWedTotal + Val(Trim(lRs("WTS_WedHrs")))
        lThuTotal = lThuTotal + Val(Trim(lRs("WTS_ThuHrs")))
        lFriTotal = lFriTotal + Val(Trim(lRs("WTS_FriHrs")))
        lSatTotal = lSatTotal + Val(Trim(lRs("WTS_SatHrs")))
        lSunTotal = lSunTotal + Val(Trim(lRs("WTS_SunHrs")))
        
        ' Grand total
        lTotal = lTotal + lCodeTotal
        lRs.MoveNext
    Wend
    
    lobjXlApp.Range("A" & (10 + lIdx)).Value = "Total"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Generate column total cells
    lobjXlApp.Range("C" & (10 + lIdx)).Value = lMonTotal
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("D" & (10 + lIdx)).Value = lTueTotal
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("E" & (10 + lIdx)).Value = lWedTotal
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("F" & (10 + lIdx)).Value = lThuTotal
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("G" & (10 + lIdx)).Value = lFriTotal
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("H" & (10 + lIdx)).Value = lSatTotal
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("I" & (10 + lIdx)).Value = lSunTotal
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("J" & (10 + lIdx)).Value = lTotal
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Display the list of codes and their description
    Dim lAllCodesRs As ADODB.Recordset
    Dim lCodeID As Integer
    Dim lCodeDesc As String
    
    Set lAllCodesRs = CreateObject("ADODB.RecordSet")
    Set lAllCodesRs = GetAllCodes()
    
    lobjXlApp.Range("A" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("B" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).HorizontalAlignment = xlCenter
    
    lobjXlApp.Range("D" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("E" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).HorizontalAlignment = xlCenter

    While Not lAllCodesRs.EOF
        lIdx = lIdx + 1
        
        lCodeID = Val(Trim(lAllCodesRs("AC_Code")))
        lCodeDesc = Trim(lAllCodesRs("AC_Description"))
        
        lobjXlApp.Range("A" & (12 + lIdx)).Value = lCodeID
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        lobjXlApp.Range("B" & (12 + lIdx)).Value = lCodeDesc
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        
        lAllCodesRs.MoveNext
        If Not lAllCodesRs.EOF Then
            lCodeID = Val(Trim(lAllCodesRs("AC_Code")))
            lCodeDesc = Trim(lAllCodesRs("AC_Description"))
            
            lobjXlApp.Range("D" & (12 + lIdx)).Value = lCodeID
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            lobjXlApp.Range("E" & (12 + lIdx)).Value = lCodeDesc
            lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            
            lAllCodesRs.MoveNext
        End If
    Wend
    
    lobjXlApp.Range("A" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    
    ' Save the workbook
    lobjXlWb.SaveAs FileName:=piFileName, FileFormat:=xlNormal

    lobjXlApp.Visible = False
    lobjXlWb.Close
        
    GenTSForUser = True
    GoTo GenTSForUser_Exit

GenTSForUser_Err:
    GenTSForUser = False
GenTSForUser_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
    Set lobjXlApp = Nothing
    Set lobjXlWb = Nothing
    Set lobjXlWs = Nothing
End Function

Public Function GetProjectName(ByVal piProjectID As Integer) As String
    On Error GoTo GetProjectName_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select P_ProjectName from TS_Projects Where P_ProjectID = " & piProjectID
    Set lRs = lCnn.Execute(lSql)

    GetProjectName = Trim(lRs("P_ProjectName"))
    GoTo GetProjectName_Exit
    
GetProjectName_Err:
    GetProjectName = ""
GetProjectName_Exit:
   Set lCnn = Nothing
   Set lRs = Nothing
End Function

Public Function GetReportsFileName(ByVal piEmpID As Integer, ByVal piDate As Date) As String
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
    
    lFileName = "TimeSheet_" & piEmpID & "_" & lTempDate & "_" & lTempTime & ".xls"
    GetReportsFileName = lFileName
End Function

Public Function RegisterUser(ByVal piEmpID As Integer, ByVal piEmpName As String, ByVal piPassword As String) As Boolean
On Error GoTo RegisterUser_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Insert Into TS_Users (U_Employee_ID, U_Name, U_Password)  Values (" & _
           piEmpID & ",'" & piEmpName & "','" & piPassword & "')"
    Set lRs = lCnn.Execute(lSql)
    RegisterUser = True
    GoTo RegisterUser_Exit
    
RegisterUser_Err:
    RegisterUser = False
RegisterUser_Exit:
   Set lCnn = Nothing
   Set lRs = Nothing
End Function

Public Function ChangePwd(ByVal piEmpID As Integer, ByVal piNewPwd As String) As Boolean
On Error GoTo ChangePwd_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Update TS_Users Set " & _
           "U_Password = '" & piNewPwd & "'" & _
           " Where U_Employee_ID = " & piEmpID
    Set lRs = lCnn.Execute(lSql)
    ChangePwd = True
    GoTo ChangePwd_Exit
    
ChangePwd_Err:
    ChangePwd = False
ChangePwd_Exit:
   Set lCnn = Nothing
   Set lRs = Nothing
End Function

Public Function GetUserList() As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select U_Name from TS_Users Order By U_Name"
    Set lRs = lCnn.Execute(lSql)

    Set GetUserList = lRs
   Set lCnn = Nothing
   Set lRs = Nothing
End Function

Public Function GetUserDetails(ByVal piEmpName As String) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_Users "
    If (piEmpName <> "") Then
        lSql = lSql & " Where U_Name = '" & piEmpName & "' "
    End If
    
    lSql = lSql & " Order By U_Name"
    Set lRs = lCnn.Execute(lSql)
    Set GetUserDetails = lRs
    
    Set lCnn = Nothing
    Set lRs = Nothing
 End Function

Public Function GetUserProfile(ByVal piEmpID As Integer) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_Users Where U_Employee_ID = " & piEmpID
    Set lRs = lCnn.Execute(lSql)
    
    Set GetUserProfile = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
 End Function

Public Function UpdateUserProfile(ByVal piEmpID As Integer, ByVal piEmpName As String, ByVal piAdmin As String) As Boolean
On Error GoTo UpdateUserProfile_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Update TS_Users Set " & _
           "U_Name = '" & piEmpName & "'" & _
           ", U_Administrator = '" & piAdmin & "'" & _
           " Where U_Employee_ID = " & piEmpID
    Set lRs = lCnn.Execute(lSql)
    UpdateUserProfile = True
    GoTo UpdateUserProfile_Exit
    
UpdateUserProfile_Err:
    UpdateUserProfile = False
UpdateUserProfile_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetUserIDList()
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select U_Employee_ID from TS_Users Order By U_Employee_ID"
    Set lRs = lCnn.Execute(lSql)

    Set GetUserIDList = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function DeleteUser(ByVal piEmpID As Integer) As Boolean
On Error GoTo DeleteUser_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Delete TS_Users Where U_Employee_ID = " & piEmpID
    Set lRs = lCnn.Execute(lSql)
    DeleteUser = True
    GoTo DeleteUser_Exit
    
DeleteUser_Err:
    DeleteUser = False
DeleteUser_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetGroupNameList() As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select G_GroupName from TS_Groups Order By G_GroupName"
    Set lRs = lCnn.Execute(lSql)

    Set GetGroupNameList = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetGroupIDList() As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select G_GroupID from TS_Groups Order By G_GroupID"
    Set lRs = lCnn.Execute(lSql)

    Set GetGroupIDList = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetGroupDetails(ByVal piGroupName As String) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_Groups "
    If (piGroupName <> "") Then
        lSql = lSql & " Where G_GroupName = '" & piGroupName & "'"
    End If
    Set lRs = lCnn.Execute(lSql)
    Set GetGroupDetails = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function InsertGroup(ByVal piGroupName As String, ByVal piGroupDesc As String, ByVal piGroupLead As Integer) As Boolean
On Error GoTo InsertGroup_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Insert Into TS_Groups (G_GroupName, G_GroupDescription, G_GroupLeader)  Values (" & _
           "'" & piGroupName & "','" & piGroupDesc & "'," & piGroupLead & ")"
    Set lRs = lCnn.Execute(lSql)
    InsertGroup = True
    GoTo InsertGroup_Exit
    
InsertGroup_Err:
    InsertGroup = False
InsertGroup_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetGroupProfile(ByVal piGroupID As Integer) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_Groups Where G_GroupID = " & piGroupID & " Order By G_GroupName"
    Set lRs = lCnn.Execute(lSql)
    
    Set GetGroupProfile = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function UpdateGroupProfile(ByVal piGroupID As Integer, ByVal piGroupName As String, ByVal piGroupDesc As String, ByVal piGroupLead As Integer) As Boolean
On Error GoTo UpdateGroupProfile_Err
   
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Update TS_Groups Set " & _
           "G_GroupName = '" & piGroupName & "'" & _
           ", G_GroupDescription = '" & piGroupDesc & "'" & _
           ", G_GroupLeader = " & piGroupLead & _
           " Where G_GroupID = " & piGroupID
    Set lRs = lCnn.Execute(lSql)
    UpdateGroupProfile = True
    GoTo UpdateGroupProfile_Exit
    
UpdateGroupProfile_Err:
    UpdateGroupProfile = False
UpdateGroupProfile_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function DeleteGroup(ByVal piGroupID As Integer) As Boolean
On Error GoTo DeleteGroup_Err
    
    Dim lCnn As ADODB.Connection
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Delete from TS_Groups
    lSql = "Delete TS_Groups Where G_GroupID = " & piGroupID
    Call lCnn.Execute(lSql)
    
    ' Delete from TS_GroupUsers
    lSql = "Delete TS_GroupUsers Where G_GroupID = " & piGroupID
    Call lCnn.Execute(lSql)
    
    DeleteGroup = True
    GoTo DeleteGroup_Exit
    
DeleteGroup_Err:
    DeleteGroup = False
DeleteGroup_Exit:
    Set lCnn = Nothing
End Function

Public Function GetGroupUsers(ByVal piGroupID As Integer) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select TS_GroupUsers.U_Employee_ID, U_Name, TS_GroupUsers.G_GroupDeveloper, TS_GroupUsers.G_GroupTester From TS_GroupUsers, TS_Users Where G_GroupID = " & piGroupID & _
           " And TS_Users.U_Employee_ID = TS_GroupUsers.U_Employee_ID"
    Set lRs = lCnn.Execute(lSql)
    
    Set GetGroupUsers = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function InsertGroupUsers(ByVal piGroupID As Integer, ByVal piUserList As String) As Boolean
On Error GoTo InsertGroupUsers_Err
    
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lUserList() As String
    Dim lIdx
    
    Set lCnn = CreateObject("ADODB.Connection")
    Call lCnn.Open("TimeSheet", "sa", "")
           
    lUserList = Split(piUserList, ",")
    For lIdx = 0 To UBound(lUserList)
        lSql = "Insert Into TS_GroupUsers(G_GroupID, U_Employee_ID) Values(" & piGroupID & "," & Val(lUserList(lIdx)) & ")"
        Call lCnn.Execute(lSql)
    Next
    
    InsertGroupUsers = True
    GoTo InsertGroupUsers_Exit
    
InsertGroupUsers_Err:
    InsertGroupUsers = False
InsertGroupUsers_Exit:
    Set lCnn = Nothing
End Function

Public Function DeleteGroupUsers(ByVal piGroupID As Integer, ByVal piGroupUsersList As String) As Boolean
On Error GoTo DeleteGroupUsers_Err
    
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lUserList() As String
    Dim lIdx
    
    Set lCnn = CreateObject("ADODB.Connection")
    Call lCnn.Open("TimeSheet", "sa", "")
           
    lUserList = Split(piGroupUsersList, ",")
    For lIdx = 0 To UBound(lUserList)
        lSql = "Delete From TS_GroupUsers Where G_GroupID = " & piGroupID & _
               " And U_Employee_ID = " & Val(lUserList(lIdx))
        Call lCnn.Execute(lSql)
    Next
    
    DeleteGroupUsers = True
    GoTo DeleteGroupUsers_Exit
    
DeleteGroupUsers_Err:
    DeleteGroupUsers = False
DeleteGroupUsers_Exit:
    Set lCnn = Nothing
End Function

Public Function GenTSForGroup(ByVal piFileName As String, ByVal piGroupID As Integer, ByVal piDate As Date) As Boolean
On Error GoTo GenTSForGroup_Err
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lRsName As ADODB.Recordset
    Dim lGroupUsersRs As ADODB.Recordset
    Dim lSql As String
    Dim UserIDString As String
    Dim UserNameString As String
    Dim lProjectsRs As ADODB.Recordset
    Dim lCodesRs As ADODB.Recordset
    Dim lUserProfileRs As ADODB.Recordset
    Dim lobjXlApp As Excel.Application
    Dim lobjXlWb As Excel.Workbook
    Dim lobjXlWs As Excel.Worksheet
    Dim lSunDate As Date
    Dim lProjectName As String
    Dim lIdx As Integer
    Dim lCodeTotal As Double
    Dim lMonTotal As Double
    Dim lTueTotal As Double
    Dim lWedTotal As Double
    Dim lThuTotal As Double
    Dim lFriTotal As Double
    Dim lSatTotal As Double
    Dim lSunTotal As Double
    Dim lTotal As Double
    Dim lProjectID As Integer
    Dim lCodeID As Integer
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRsName = CreateObject("ADODB.Recordset")
    Set lGroupUsersRs = CreateObject("ADODB.Recordset")
    Set lUserProfileRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get the group users
    lSql = "Select U_Employee_ID From TS_GroupUsers Where G_GroupID = " & piGroupID
    Set lGroupUsersRs = lCnn.Execute(lSql)
    
    If lGroupUsersRs.RecordCount > 0 Then
        While Not lGroupUsersRs.EOF
            UserIDString = UserIDString & lGroupUsersRs("U_Employee_ID") & ","
            lGroupUsersRs.MoveNext
        Wend
        
        UserIDString = Left$(UserIDString, Len(UserIDString) - 1)
    Else
        GenTSForGroup = False
        GoTo GenTSForGroup_Err
    End If
    
    ' Get Distinct projects
    Set lProjectsRs = CreateObject("ADODB.Recordset")
    lSql = "Select Distinct(P_ProjectID) From TS_WeeklyTimeSheet Where " & _
           " U_Employee_ID In (" & UserIDString & ")" & _
           " And WTS_StartDate = '" & piDate & "'"
    Set lProjectsRs = lCnn.Execute(lSql)
    If (lProjectsRs.RecordCount <= 0) Then
        GenTSForGroup = False
        GoTo GenTSForGroup_Err
    Else
        GenTSForGroup = True
    End If
    
    ' Get Distinct codes
    Set lCodesRs = CreateObject("ADODB.Recordset")
    lSql = "Select Distinct(AC_Code) From TS_WeeklyTimeSheet Where " & _
           " U_Employee_ID In (" & UserIDString & ")" & _
           " And WTS_StartDate = '" & piDate & "'"
    Set lCodesRs = lCnn.Execute(lSql)
    If (lCodesRs.RecordCount = 0) Then
        GenTSForGroup = False
        GoTo GenTSForGroup_Err
    Else
        GenTSForGroup = True
    End If
   
    ' Create the excel sheet
    Set lobjXlApp = CreateObject("Excel.Application")
    Set lobjXlWb = lobjXlApp.Workbooks.Add() ' Adding the workbooks to the Xl Application
    Set lobjXlWs = lobjXlApp.Worksheets.Add() ' Adding the worksheet to the work book
    
    lobjXlApp.Visible = False
    lobjXlApp.Worksheets("Sheet1").Activate
    lobjXlApp.Worksheets("Sheet1").Name = "Time Sheet"

    Application.DisplayAlerts = False
    lobjXlApp.Worksheets("Sheet2").Delete
    lobjXlApp.Worksheets("Sheet3").Delete
    lobjXlApp.Worksheets("Sheet4").Delete

    ' Fill the title
    lobjXlApp.Range("A1:I1").MergeCells = True
    lobjXlApp.Range("A1").Value = "Time Sheet"
    lobjXlApp.Range("A1").Font.Name = "Times New Roman"
    lobjXlApp.Range("A1").Font.Bold = True
    lobjXlApp.Range("A1").Font.Size = 14
    lobjXlApp.Range("A1").HorizontalAlignment = xlCenter
    Rows("1:1").RowHeight = 20.25
    lobjXlApp.Range("A1:I1").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeRight).LineStyle = xlContinuous
        
    ' Fill the Heading rows
    lobjXlApp.Range("4:4").RowHeight = 25.5
    lobjXlApp.Range("8:8").RowHeight = 25.5
    lobjXlApp.Range("A:A").ColumnWidth = 7.14
    lobjXlApp.Range("B:B").ColumnWidth = 31.4
    lobjXlApp.Range("J:J").ColumnWidth = 28.4
    
    lobjXlApp.Range("A4").Value = "Name"
    lobjXlApp.Range("A4").Font.Name = "Times New Roman"
    lobjXlApp.Range("A4").Font.Bold = True
    lobjXlApp.Range("A4").Font.Size = 10
    lobjXlApp.Range("A4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeRight).LineStyle = xlContinuous

    ' Get the group users names and display
    If lGroupUsersRs.RecordCount > 0 Then
        lGroupUsersRs.MoveFirst
        While Not lGroupUsersRs.EOF
            lSql = "Select U_Name From TS_Users Where U_Employee_ID = " & Val(Trim(lGroupUsersRs("U_Employee_ID")))
            Set lUserProfileRs = lCnn.Execute(lSql)

            UserNameString = UserNameString & lUserProfileRs("U_Name") & ", "
            lGroupUsersRs.MoveNext
        Wend
        UserNameString = Left$(UserNameString, Len(UserNameString) - 2)
    Else
        GenTSForGroup = False
        GoTo GenTSForGroup_Err
    End If
    
    lobjXlApp.Range("B4").Value = UserNameString
    lobjXlApp.Range("B4").WrapText = True
    lobjXlApp.Range("B4").Font.Name = "Times New Roman"
    lobjXlApp.Range("B4").Font.Size = 10
    lobjXlApp.Range("B4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeRight).LineStyle = xlContinuous
        
    lobjXlApp.Range("C4:D4").MergeCells = True
    lobjXlApp.Range("C4").Value = "From (date)"
    lobjXlApp.Range("C4").Font.Name = "Times New Roman"
    lobjXlApp.Range("C4").Font.Bold = True
    lobjXlApp.Range("C4").Font.Size = 10
    lobjXlApp.Range("C4:D4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    
    lobjXlApp.Range("E4").Value = piDate
    lobjXlApp.Range("E4").Font.Name = "Times New Roman"
    lobjXlApp.Range("E4").Font.Size = 10
    lobjXlApp.Range("E4:F4").MergeCells = True
    lobjXlApp.Range("E4:F4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G4").Value = "Emp. Code"
    lobjXlApp.Range("G4").Font.Name = "Times New Roman"
    lobjXlApp.Range("G4").Font.Bold = True
    lobjXlApp.Range("G4").Font.Size = 10
    lobjXlApp.Range("G4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H4:I4").MergeCells = True
    'lobjXlApp.Range("H4").Value =
    lobjXlApp.Range("H4").Font.Name = "Times New Roman"
    lobjXlApp.Range("H4:I4").Font.Size = 10
    lobjXlApp.Range("H4:I4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("A5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("C5:D5").MergeCells = True
    lobjXlApp.Range("C5").Value = "To(date)"
    lobjXlApp.Range("C5").Font.Name = "Times New Roman"
    lobjXlApp.Range("C5").Font.Bold = True
    lobjXlApp.Range("C5").Font.Size = 10
    lobjXlApp.Range("C5:D5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    ' Get the to date
    lSunDate = piDate + 6
    
    lobjXlApp.Range("E5:F5").MergeCells = True
    lobjXlApp.Range("E5").Value = lSunDate
    lobjXlApp.Range("E5").Font.Name = "Times New Roman"
    lobjXlApp.Range("E5").Font.Size = 10
    lobjXlApp.Range("E5:F5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("G5").Value = "Dept."
    lobjXlApp.Range("G5").Font.Name = "Times New Roman"
    lobjXlApp.Range("G5").Font.Bold = True
    lobjXlApp.Range("G5").Font.Size = 10
    lobjXlApp.Range("G5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H5:I5").MergeCells = True
    lobjXlApp.Range("H5:I5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeRight).LineStyle = xlContinuous

    ' Timesheet table
    lobjXlApp.Range("A8").Value = "Activity Code"
    lobjXlApp.Range("A8").WrapText = True
    lobjXlApp.Range("A8").Font.Name = "Times New Roman"
    lobjXlApp.Range("A8").Font.Bold = True
    lobjXlApp.Range("A8").Font.Size = 10
    lobjXlApp.Range("A8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B8").Value = "Project"
    lobjXlApp.Range("B8").Font.Name = "Times New Roman"
    lobjXlApp.Range("B8").Font.Bold = True
    lobjXlApp.Range("B8").Font.Size = 10
    lobjXlApp.Range("B8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("C8:I8").MergeCells = True
    lobjXlApp.Range("C8").Value = "Time spent (in hours)"
    lobjXlApp.Range("C8").Font.Name = "Times New Roman"
    lobjXlApp.Range("C8").Font.Bold = True
    lobjXlApp.Range("C8").Font.Size = 10
    lobjXlApp.Range("C8").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C8:I8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("A9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    'lobjXlApp.Range("B9").Interior.ColorIndex = 15
    'lobjXlApp.Range("B9").Interior.Pattern = xlSolid
    
    lobjXlApp.Range("C9").Value = "Mon"
    lobjXlApp.Range("C9").Font.Name = "Times New Roman"
    lobjXlApp.Range("C9").Font.Bold = True
    lobjXlApp.Range("C9").Font.Size = 10
    lobjXlApp.Range("C9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("D9").Value = "Tue"
    lobjXlApp.Range("D9").Font.Name = "Times New Roman"
    lobjXlApp.Range("D9").Font.Bold = True
    lobjXlApp.Range("D9").Font.Size = 10
    lobjXlApp.Range("D9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("D9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E9").Value = "Wed"
    lobjXlApp.Range("E9").Font.Name = "Times New Roman"
    lobjXlApp.Range("E9").Font.Bold = True
    lobjXlApp.Range("E9").Font.Size = 10
    lobjXlApp.Range("E9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("E9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("F9").Value = "Thu"
    lobjXlApp.Range("F9").Font.Name = "Times New Roman"
    lobjXlApp.Range("F9").Font.Bold = True
    lobjXlApp.Range("F9").Font.Size = 10
    lobjXlApp.Range("F9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("F9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G9").Value = "Fri"
    lobjXlApp.Range("G9").Font.Name = "Times New Roman"
    lobjXlApp.Range("G9").Font.Bold = True
    lobjXlApp.Range("G9").Font.Size = 10
    lobjXlApp.Range("G9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("G9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H9").Value = "Sat"
    lobjXlApp.Range("H9").Font.Name = "Times New Roman"
    lobjXlApp.Range("H9").Font.Bold = True
    lobjXlApp.Range("H9").Font.Size = 10
    lobjXlApp.Range("H9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("H9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("I9").Value = "Sun"
    lobjXlApp.Range("I9").Font.Name = "Times New Roman"
    lobjXlApp.Range("I9").Font.Bold = True
    lobjXlApp.Range("I9").Font.Size = 10
    lobjXlApp.Range("I9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("I9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("J9").Value = "Net Time for each activity"
    lobjXlApp.Range("J9").Font.Name = "Times New Roman"
    lobjXlApp.Range("J9").Font.Bold = True
    lobjXlApp.Range("J9").Font.Size = 10
    lobjXlApp.Range("J9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("J9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lIdx = 0
    While Not lProjectsRs.EOF
        ' Get the project name from project id
        lProjectID = Val(Trim(lProjectsRs("P_ProjectID")))
        lProjectName = GetProjectName(lProjectID)
        
        lCodesRs.MoveFirst
        While Not lCodesRs.EOF
            lCodeID = Val(Trim(lCodesRs("AC_Code")))
            
            ' Get the record set for the given input arguments
            lSql = "Select Sum(WTS_MonHrs), Sum(WTS_TueHrs), Sum(WTS_WedHrs), Sum(WTS_ThuHrs), Sum(WTS_FriHrs), Sum(WTS_SatHrs), Sum(WTS_SunHrs) From TS_WeeklyTimeSheet Where " & _
                   " U_Employee_ID In (" & UserIDString & ")" & _
                   " And WTS_StartDate = '" & piDate & "'" & _
                   " And AC_Code = " & lCodeID & _
                   " And P_ProjectID = " & lProjectID
            Set lRs = lCnn.Execute(lSql)
            If lRs.RecordCount > 0 And Not IsNull(lRs(0)) Then
                lIdx = lIdx + 1
                
                ' Generate the values
               lobjXlApp.Range("A" & (9 + lIdx)).Value = lCodeID
               lobjXlApp.Range("A" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("A" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("B" & (9 + lIdx)).Value = lProjectName
               lobjXlApp.Range("B" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("B" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("C" & (9 + lIdx)).Value = Trim(lRs(0))
               lobjXlApp.Range("C" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("C" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("D" & (9 + lIdx)).Value = Trim(lRs(1))
               lobjXlApp.Range("D" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("D" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("E" & (9 + lIdx)).Value = Trim(lRs(2))
               lobjXlApp.Range("E" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("E" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("F" & (9 + lIdx)).Value = Trim(lRs(3))
               lobjXlApp.Range("F" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("F" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("G" & (9 + lIdx)).Value = Trim(lRs(4))
               lobjXlApp.Range("G" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("G" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("H" & (9 + lIdx)).Value = Trim(lRs(5))
               lobjXlApp.Range("H" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("H" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("I" & (9 + lIdx)).Value = Trim(lRs(6))
               lobjXlApp.Range("I" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("I" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
               ' Row total
               lCodeTotal = Val(Trim(lRs(0))) + _
                            Val(Trim(lRs(1))) + _
                            Val(Trim(lRs(2))) + _
                            Val(Trim(lRs(3))) + _
                            Val(Trim(lRs(4))) + _
                            Val(Trim(lRs(5))) + _
                            Val(Trim(lRs(6)))
              
               lobjXlApp.Range("J" & (9 + lIdx)).Value = lCodeTotal
               lobjXlApp.Range("J" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("J" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Interior.ColorIndex = 15
               lobjXlApp.Range("J" & (9 + lIdx)).Interior.Pattern = xlSolid
               
               ' Column Total
               lMonTotal = lMonTotal + Val(Trim(lRs(0)))
               lTueTotal = lTueTotal + Val(Trim(lRs(1)))
               lWedTotal = lWedTotal + Val(Trim(lRs(2)))
               lThuTotal = lThuTotal + Val(Trim(lRs(3)))
               lFriTotal = lFriTotal + Val(Trim(lRs(4)))
               lSatTotal = lSatTotal + Val(Trim(lRs(5)))
               lSunTotal = lSunTotal + Val(Trim(lRs(6)))
               
               ' Grand total
               lTotal = lTotal + lCodeTotal
            End If
            lCodesRs.MoveNext
        Wend
        lProjectsRs.MoveNext
    Wend
    
    lobjXlApp.Range("A" & (10 + lIdx)).Value = "Total"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Generate column total cells
    lobjXlApp.Range("C" & (10 + lIdx)).Value = lMonTotal
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("D" & (10 + lIdx)).Value = lTueTotal
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("E" & (10 + lIdx)).Value = lWedTotal
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("F" & (10 + lIdx)).Value = lThuTotal
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("G" & (10 + lIdx)).Value = lFriTotal
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("H" & (10 + lIdx)).Value = lSatTotal
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("I" & (10 + lIdx)).Value = lSunTotal
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("J" & (10 + lIdx)).Value = lTotal
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Display the list of codes and their description
    Dim lAllCodesRs As ADODB.Recordset
    Dim lCodeID1 As Integer
    Dim lCodeDesc As String
    
    Set lAllCodesRs = CreateObject("ADODB.RecordSet")
    Set lAllCodesRs = GetAllCodes()
    
    lobjXlApp.Range("A" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("B" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).HorizontalAlignment = xlCenter
    
    lobjXlApp.Range("D" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("E" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).HorizontalAlignment = xlCenter

    While Not lAllCodesRs.EOF
        lIdx = lIdx + 1
        
        lCodeID1 = Val(Trim(lAllCodesRs("AC_Code")))
        lCodeDesc = Trim(lAllCodesRs("AC_Description"))
        
        lobjXlApp.Range("A" & (12 + lIdx)).Value = lCodeID1
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        lobjXlApp.Range("B" & (12 + lIdx)).Value = lCodeDesc
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        
        lAllCodesRs.MoveNext
        If Not lAllCodesRs.EOF Then
            lCodeID1 = Val(Trim(lAllCodesRs("AC_Code")))
            lCodeDesc = Trim(lAllCodesRs("AC_Description"))
            
            lobjXlApp.Range("D" & (12 + lIdx)).Value = lCodeID1
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            lobjXlApp.Range("E" & (12 + lIdx)).Value = lCodeDesc
            lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            lAllCodesRs.MoveNext
        End If
    Wend
    
    lobjXlApp.Range("A" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    
    ' Save the workbook
    lobjXlWb.SaveAs FileName:=piFileName, FileFormat:=xlNormal

    lobjXlApp.Visible = False
    lobjXlWb.Close
        
    GenTSForGroup = True
    GoTo GenTSForGroup_Exit

GenTSForGroup_Err:
    GenTSForGroup = False
GenTSForGroup_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
    Set lRsName = Nothing
    Set lobjXlApp = Nothing
    Set lobjXlWb = Nothing
    Set lobjXlWs = Nothing
End Function

Public Function GetAllCodes() As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_ActivityCodes Order by AC_Code"
    Set lRs = lCnn.Execute(lSql)

    Set GetAllCodes = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function InsertCode(ByVal piCode As Integer, ByVal piCodeDesc As String) As Boolean
On Error GoTo InsertCode_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Insert Into TS_ActivityCodes Values (" & _
           piCode & ",'" & piCodeDesc & "')"
    Set lRs = lCnn.Execute(lSql)
    InsertCode = True
    GoTo InsertCode_Exit
    
InsertCode_Err:
    InsertCode = False
InsertCode_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function DeleteCode(ByVal piCode As Integer) As Boolean
On Error GoTo DeleteCode_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Delete TS_ActivityCodes Where AC_Code = " & piCode
    Set lRs = lCnn.Execute(lSql)
    DeleteCode = True
    GoTo DeleteCode_Exit
    
DeleteCode_Err:
    DeleteCode = False
DeleteCode_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetAllProjects() As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_Projects Order by P_ProjectID"
    Set lRs = lCnn.Execute(lSql)

    Set GetAllProjects = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function InsertProject(ByVal piProjectName As String, ByVal piProjectDesc As String) As Boolean
On Error GoTo InsertProject_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Insert Into TS_Projects (P_ProjectName, P_ProjectDescription) Values (" & _
           "'" & piProjectName & "','" & piProjectDesc & "')"
    Set lRs = lCnn.Execute(lSql)
    InsertProject = True
    GoTo InsertProject_Exit
    
InsertProject_Err:
    InsertProject = False
InsertProject_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function DeleteProject(ByVal piProjectID As Integer) As Boolean
On Error GoTo DeleteProject_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Delete TS_Projects Where P_ProjectID = " & piProjectID
    Set lRs = lCnn.Execute(lSql)
    
    DeleteProject = True
    GoTo DeleteProject_Exit
DeleteProject_Err:
    DeleteProject = False
DeleteProject_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetProjectProfile(ByVal piProjectID As Integer) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_Projects Where P_ProjectID = " & piProjectID
    Set lRs = lCnn.Execute(lSql)
    
    Set GetProjectProfile = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function UpdateProjectProfile(ByVal piProjectID As Integer, ByVal piProjectName As String, ByVal piProjectDesc As String) As Boolean
On Error GoTo UpdateProjectProfile_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Update TS_Projects Set " & _
           "P_ProjectName = '" & piProjectName & "'" & _
           ", P_ProjectDescription = '" & piProjectDesc & "'" & _
           " Where P_ProjectID = " & piProjectID
    Set lRs = lCnn.Execute(lSql)
    UpdateProjectProfile = True
    GoTo UpdateProjectProfile_Exit
    
UpdateProjectProfile_Err:
    UpdateProjectProfile = False
UpdateProjectProfile_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetCodeProfile(ByVal piCode As Integer) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select AC_Description from TS_ActivityCodes Where AC_Code = " & piCode
    Set lRs = lCnn.Execute(lSql)

    Set GetCodeProfile = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function UpdateCodeProfile(ByVal piCode As Integer, ByVal piCodeDesc As String) As Boolean
On Error GoTo UpdateCodeProfile_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Update TS_ActivityCodes Set " & _
           "AC_Description = '" & piCodeDesc & "'" & _
           " Where AC_Code = " & piCode
    Set lRs = lCnn.Execute(lSql)
    UpdateCodeProfile = True
    GoTo UpdateCodeProfile_Exit
    
UpdateCodeProfile_Err:
    UpdateCodeProfile = False
UpdateCodeProfile_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function CheckIfAdministrator(ByVal piEmpID As Integer) As Boolean
On Error GoTo CheckIfAdministrator_Err
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select U_Administrator From TS_Users Where U_Employee_ID = " & piEmpID
    Set lRs = lCnn.Execute(lSql)
    If (lRs.RecordCount > 0) Then
        If (Trim(lRs("U_Administrator")) = "Y") Then
            CheckIfAdministrator = True
        Else
            CheckIfAdministrator = False
        End If
    Else
        CheckIfAdministrator = False
    End If
    GoTo CheckIfAdministrator_Exit
    
CheckIfAdministrator_Err:
    CheckIfAdministrator = False
CheckIfAdministrator_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function CheckIfGroupLead(ByVal piEmpID As Integer, ByVal piProjectID As Integer) As Boolean
On Error GoTo CheckIfGroupLead_Err

    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select G_GroupLeader From TS_Groups Where G_GroupLeader = " & piEmpID
    If piProjectID <> 0 Then
        lSql = lSql & " And G_GroupID = " & piProjectID
    End If
    
    Set lRs = lCnn.Execute(lSql)
    If (lRs.RecordCount > 0) Then
        CheckIfGroupLead = True
    Else
        CheckIfGroupLead = False
    End If
    GoTo CheckIfGroupLead_Exit
    
CheckIfGroupLead_Err:
    CheckIfGroupLead = False
CheckIfGroupLead_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetGroupIDListForLeader(ByVal piEmpID As Integer) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select G_GroupName, G_GroupID From TS_Groups Where G_GroupLeader = " & piEmpID
    Set lRs = lCnn.Execute(lSql)
    Set GetGroupIDListForLeader = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetGroupUsersForLead(ByVal piGroupLead As Integer) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select TS_Users.U_Employee_ID, TS_Users.U_Name " & _
           "From TS_Users, TS_GroupUsers Where TS_GroupUsers.G_GroupID In " & _
           "(select G_GroupID From TS_Groups Where G_GroupLeader = " & piGroupLead & " )" & _
           " And TS_Users.U_Employee_ID = TS_GRoupUsers.U_Employee_ID"

    Set lRs = lCnn.Execute(lSql)
    
    Set GetGroupUsersForLead = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GenConsTSForUser(ByVal piFileName As String, ByVal piEmpID As Integer, ByVal piStartDate As Date, ByVal piEndDate) As Boolean
On Error GoTo GenConsTSForUser_Err
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lRsName As ADODB.Recordset
    Dim lSql As String
    Dim lProjectsRs As ADODB.Recordset
    Dim lCodesRs As ADODB.Recordset
    Dim lUserProfileRs As ADODB.Recordset
    Dim UserNameString As String
    Dim lobjXlApp As Excel.Application
    Dim lobjXlWb As Excel.Workbook
    Dim lobjXlWs As Excel.Worksheet
    Dim lSunDate As Date
    Dim lProjectName As String
    Dim lIdx As Integer
    Dim lCodeTotal As Double
    Dim lMonTotal As Double
    Dim lTueTotal As Double
    Dim lWedTotal As Double
    Dim lThuTotal As Double
    Dim lFriTotal As Double
    Dim lSatTotal As Double
    Dim lSunTotal As Double
    Dim lTotal As Double
    Dim lProjectID As Integer
    Dim lCodeID As Integer
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRsName = CreateObject("ADODB.Recordset")
    Set lUserProfileRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get Distinct projects
    Set lProjectsRs = CreateObject("ADODB.Recordset")
    lSql = "Select Distinct(P_ProjectID) From TS_WeeklyTimeSheet Where " & _
           " U_Employee_ID = " & piEmpID & _
           " And WTS_StartDate >= '" & piStartDate & "'" & _
           " And WTS_StartDate <= '" & piEndDate & "'"
    Set lProjectsRs = lCnn.Execute(lSql)
    If (lProjectsRs.RecordCount <= 0) Then
        GenConsTSForUser = False
        GoTo GenConsTSForUser_Err
    Else
        GenConsTSForUser = True
    End If
    
    ' Get Distinct codes
    Set lCodesRs = CreateObject("ADODB.Recordset")
    lSql = "Select Distinct(AC_Code) From TS_WeeklyTimeSheet Where " & _
           " U_Employee_ID = " & piEmpID & _
           " And WTS_StartDate >= '" & piStartDate & "'" & _
           " And WTS_StartDate <= '" & piEndDate & "'"
    Set lCodesRs = lCnn.Execute(lSql)
    If (lCodesRs.RecordCount = 0) Then
        GenConsTSForUser = False
        GoTo GenConsTSForUser_Err
    Else
        GenConsTSForUser = True
    End If
   
    ' Create the excel sheet
    Set lobjXlApp = CreateObject("Excel.Application")
    Set lobjXlWb = lobjXlApp.Workbooks.Add() ' Adding the workbooks to the Xl Application
    Set lobjXlWs = lobjXlApp.Worksheets.Add() ' Adding the worksheet to the work book
    
    lobjXlApp.Visible = False
    lobjXlApp.Worksheets("Sheet1").Activate
    lobjXlApp.Worksheets("Sheet1").Name = "Time Sheet"

    Application.DisplayAlerts = False
    lobjXlApp.Worksheets("Sheet2").Delete
    lobjXlApp.Worksheets("Sheet3").Delete
    lobjXlApp.Worksheets("Sheet4").Delete

    ' Fill the title
    lobjXlApp.Range("A1:I1").MergeCells = True
    lobjXlApp.Range("A1").Value = "Time Sheet"
    lobjXlApp.Range("A1").Font.Name = "Times New Roman"
    lobjXlApp.Range("A1").Font.Bold = True
    lobjXlApp.Range("A1").Font.Size = 14
    lobjXlApp.Range("A1").HorizontalAlignment = xlCenter
    Rows("1:1").RowHeight = 20.25
    lobjXlApp.Range("A1:I1").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeRight).LineStyle = xlContinuous
        
    ' Fill the Heading rows
    lobjXlApp.Range("4:4").RowHeight = 25.5
    lobjXlApp.Range("8:8").RowHeight = 25.5
    lobjXlApp.Range("A:A").ColumnWidth = 7.14
    lobjXlApp.Range("B:B").ColumnWidth = 31.4
    lobjXlApp.Range("J:J").ColumnWidth = 28.4
    
    lobjXlApp.Range("A4").Value = "Name"
    lobjXlApp.Range("A4").Font.Name = "Times New Roman"
    lobjXlApp.Range("A4").Font.Bold = True
    lobjXlApp.Range("A4").Font.Size = 10
    lobjXlApp.Range("A4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeRight).LineStyle = xlContinuous

    ' Get the group users names and display
    lSql = "Select U_Name From TS_Users Where U_Employee_ID = " & piEmpID
    Set lUserProfileRs = lCnn.Execute(lSql)
    If lUserProfileRs.RecordCount > 0 Then
        UserNameString = UserNameString & lUserProfileRs("U_Name")
    Else
        GenConsTSForUser = False
        GoTo GenConsTSForUser_Err
    End If
    
    lobjXlApp.Range("B4").Value = UserNameString
    lobjXlApp.Range("B4").WrapText = True
    lobjXlApp.Range("B4").Font.Name = "Times New Roman"
    lobjXlApp.Range("B4").Font.Size = 10
    lobjXlApp.Range("B4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeRight).LineStyle = xlContinuous
        
    lobjXlApp.Range("C4:D4").MergeCells = True
    lobjXlApp.Range("C4").Value = "From (date)"
    lobjXlApp.Range("C4").Font.Name = "Times New Roman"
    lobjXlApp.Range("C4").Font.Bold = True
    lobjXlApp.Range("C4").Font.Size = 10
    lobjXlApp.Range("C4:D4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    
    lobjXlApp.Range("E4").Value = piStartDate
    lobjXlApp.Range("E4").Font.Name = "Times New Roman"
    lobjXlApp.Range("E4").Font.Size = 10
    lobjXlApp.Range("E4:F4").MergeCells = True
    lobjXlApp.Range("E4:F4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G4").Value = "Emp. Code"
    lobjXlApp.Range("G4").Font.Name = "Times New Roman"
    lobjXlApp.Range("G4").Font.Bold = True
    lobjXlApp.Range("G4").Font.Size = 10
    lobjXlApp.Range("G4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H4:I4").MergeCells = True
    lobjXlApp.Range("H4").Value = piEmpID
    lobjXlApp.Range("H4").Font.Name = "Times New Roman"
    lobjXlApp.Range("H4:I4").Font.Size = 10
    lobjXlApp.Range("H4:I4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("A5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("C5:D5").MergeCells = True
    lobjXlApp.Range("C5").Value = "To(date)"
    lobjXlApp.Range("C5").Font.Name = "Times New Roman"
    lobjXlApp.Range("C5").Font.Bold = True
    lobjXlApp.Range("C5").Font.Size = 10
    lobjXlApp.Range("C5:D5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E5:F5").MergeCells = True
    lobjXlApp.Range("E5").Value = piEndDate + 6
    lobjXlApp.Range("E5").Font.Name = "Times New Roman"
    lobjXlApp.Range("E5").Font.Size = 10
    lobjXlApp.Range("E5:F5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("G5").Value = "Dept."
    lobjXlApp.Range("G5").Font.Name = "Times New Roman"
    lobjXlApp.Range("G5").Font.Bold = True
    lobjXlApp.Range("G5").Font.Size = 10
    lobjXlApp.Range("G5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H5:I5").MergeCells = True
    lobjXlApp.Range("H5:I5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeRight).LineStyle = xlContinuous

    ' Timesheet table
    lobjXlApp.Range("A8").Value = "Activity Code"
    lobjXlApp.Range("A8").WrapText = True
    lobjXlApp.Range("A8").Font.Name = "Times New Roman"
    lobjXlApp.Range("A8").Font.Bold = True
    lobjXlApp.Range("A8").Font.Size = 10
    lobjXlApp.Range("A8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B8").Value = "Project"
    lobjXlApp.Range("B8").Font.Name = "Times New Roman"
    lobjXlApp.Range("B8").Font.Bold = True
    lobjXlApp.Range("B8").Font.Size = 10
    lobjXlApp.Range("B8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("C8:I8").MergeCells = True
    lobjXlApp.Range("C8").Value = "Time spent (in hours)"
    lobjXlApp.Range("C8").Font.Name = "Times New Roman"
    lobjXlApp.Range("C8").Font.Bold = True
    lobjXlApp.Range("C8").Font.Size = 10
    lobjXlApp.Range("C8").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C8:I8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("A9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    'lobjXlApp.Range("B9").Interior.ColorIndex = 15
    'lobjXlApp.Range("B9").Interior.Pattern = xlSolid
    
    lobjXlApp.Range("C9").Value = "Mon"
    lobjXlApp.Range("C9").Font.Name = "Times New Roman"
    lobjXlApp.Range("C9").Font.Bold = True
    lobjXlApp.Range("C9").Font.Size = 10
    lobjXlApp.Range("C9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("D9").Value = "Tue"
    lobjXlApp.Range("D9").Font.Name = "Times New Roman"
    lobjXlApp.Range("D9").Font.Bold = True
    lobjXlApp.Range("D9").Font.Size = 10
    lobjXlApp.Range("D9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("D9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E9").Value = "Wed"
    lobjXlApp.Range("E9").Font.Name = "Times New Roman"
    lobjXlApp.Range("E9").Font.Bold = True
    lobjXlApp.Range("E9").Font.Size = 10
    lobjXlApp.Range("E9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("E9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("F9").Value = "Thu"
    lobjXlApp.Range("F9").Font.Name = "Times New Roman"
    lobjXlApp.Range("F9").Font.Bold = True
    lobjXlApp.Range("F9").Font.Size = 10
    lobjXlApp.Range("F9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("F9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G9").Value = "Fri"
    lobjXlApp.Range("G9").Font.Name = "Times New Roman"
    lobjXlApp.Range("G9").Font.Bold = True
    lobjXlApp.Range("G9").Font.Size = 10
    lobjXlApp.Range("G9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("G9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H9").Value = "Sat"
    lobjXlApp.Range("H9").Font.Name = "Times New Roman"
    lobjXlApp.Range("H9").Font.Bold = True
    lobjXlApp.Range("H9").Font.Size = 10
    lobjXlApp.Range("H9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("H9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("I9").Value = "Sun"
    lobjXlApp.Range("I9").Font.Name = "Times New Roman"
    lobjXlApp.Range("I9").Font.Bold = True
    lobjXlApp.Range("I9").Font.Size = 10
    lobjXlApp.Range("I9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("I9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("J9").Value = "Net Time for each activity"
    lobjXlApp.Range("J9").Font.Name = "Times New Roman"
    lobjXlApp.Range("J9").Font.Bold = True
    lobjXlApp.Range("J9").Font.Size = 10
    lobjXlApp.Range("J9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("J9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lIdx = 0
    While Not lProjectsRs.EOF
        ' Get the project name from project id
        lProjectID = Val(Trim(lProjectsRs("P_ProjectID")))
        lProjectName = GetProjectName(lProjectID)
        
        lCodesRs.MoveFirst
        While Not lCodesRs.EOF
            lCodeID = Val(Trim(lCodesRs("AC_Code")))
            
            ' Get the record set for the given input arguments
            lSql = "Select Sum(WTS_MonHrs), Sum(WTS_TueHrs), Sum(WTS_WedHrs), Sum(WTS_ThuHrs), Sum(WTS_FriHrs), Sum(WTS_SatHrs), Sum(WTS_SunHrs) From TS_WeeklyTimeSheet Where " & _
                   " U_Employee_ID = " & piEmpID & _
                   " And WTS_StartDate >= '" & piStartDate & "'" & _
                   " And WTS_StartDate <= '" & piEndDate & "'" & _
                   " And AC_Code = " & lCodeID & _
                   " And P_ProjectID = " & lProjectID
            Set lRs = lCnn.Execute(lSql)
            If lRs.RecordCount > 0 And Not IsNull(lRs(0)) Then
                lIdx = lIdx + 1
                
                ' Generate the values
               lobjXlApp.Range("A" & (9 + lIdx)).Value = lCodeID
               lobjXlApp.Range("A" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("A" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("B" & (9 + lIdx)).Value = lProjectName
               lobjXlApp.Range("B" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("B" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("C" & (9 + lIdx)).Value = Trim(lRs(0))
               lobjXlApp.Range("C" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("C" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("D" & (9 + lIdx)).Value = Trim(lRs(1))
               lobjXlApp.Range("D" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("D" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("E" & (9 + lIdx)).Value = Trim(lRs(2))
               lobjXlApp.Range("E" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("E" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("F" & (9 + lIdx)).Value = Trim(lRs(3))
               lobjXlApp.Range("F" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("F" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("G" & (9 + lIdx)).Value = Trim(lRs(4))
               lobjXlApp.Range("G" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("G" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("H" & (9 + lIdx)).Value = Trim(lRs(5))
               lobjXlApp.Range("H" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("H" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("I" & (9 + lIdx)).Value = Trim(lRs(6))
               lobjXlApp.Range("I" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("I" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
               ' Row total
               lCodeTotal = Val(Trim(lRs(0))) + _
                            Val(Trim(lRs(1))) + _
                            Val(Trim(lRs(2))) + _
                            Val(Trim(lRs(3))) + _
                            Val(Trim(lRs(4))) + _
                            Val(Trim(lRs(5))) + _
                            Val(Trim(lRs(6)))
              
               lobjXlApp.Range("J" & (9 + lIdx)).Value = lCodeTotal
               lobjXlApp.Range("J" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("J" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Interior.ColorIndex = 15
               lobjXlApp.Range("J" & (9 + lIdx)).Interior.Pattern = xlSolid
               
               ' Column Total
               lMonTotal = lMonTotal + Val(Trim(lRs(0)))
               lTueTotal = lTueTotal + Val(Trim(lRs(1)))
               lWedTotal = lWedTotal + Val(Trim(lRs(2)))
               lThuTotal = lThuTotal + Val(Trim(lRs(3)))
               lFriTotal = lFriTotal + Val(Trim(lRs(4)))
               lSatTotal = lSatTotal + Val(Trim(lRs(5)))
               lSunTotal = lSunTotal + Val(Trim(lRs(6)))
               
               ' Grand total
               lTotal = lTotal + lCodeTotal
            End If
            lCodesRs.MoveNext
        Wend
        lProjectsRs.MoveNext
    Wend
    
    lobjXlApp.Range("A" & (10 + lIdx)).Value = "Total"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Generate column total cells
    lobjXlApp.Range("C" & (10 + lIdx)).Value = lMonTotal
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("D" & (10 + lIdx)).Value = lTueTotal
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("E" & (10 + lIdx)).Value = lWedTotal
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("F" & (10 + lIdx)).Value = lThuTotal
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("G" & (10 + lIdx)).Value = lFriTotal
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("H" & (10 + lIdx)).Value = lSatTotal
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("I" & (10 + lIdx)).Value = lSunTotal
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("J" & (10 + lIdx)).Value = lTotal
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Display the list of codes and their description
    Dim lAllCodesRs As ADODB.Recordset
    Dim lCodeID1 As Integer
    Dim lCodeDesc As String
    
    Set lAllCodesRs = CreateObject("ADODB.RecordSet")
    Set lAllCodesRs = GetAllCodes()
    
    lobjXlApp.Range("A" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("B" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).HorizontalAlignment = xlCenter
    
    lobjXlApp.Range("D" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("E" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).HorizontalAlignment = xlCenter

    While Not lAllCodesRs.EOF
        lIdx = lIdx + 1
        
        lCodeID1 = Val(Trim(lAllCodesRs("AC_Code")))
        lCodeDesc = Trim(lAllCodesRs("AC_Description"))
        
        lobjXlApp.Range("A" & (12 + lIdx)).Value = lCodeID1
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        lobjXlApp.Range("B" & (12 + lIdx)).Value = lCodeDesc
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        
        lAllCodesRs.MoveNext
        If Not lAllCodesRs.EOF Then
            lCodeID1 = Val(Trim(lAllCodesRs("AC_Code")))
            lCodeDesc = Trim(lAllCodesRs("AC_Description"))
            
            lobjXlApp.Range("D" & (12 + lIdx)).Value = lCodeID1
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            lobjXlApp.Range("E" & (12 + lIdx)).Value = lCodeDesc
            lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            lAllCodesRs.MoveNext
        End If
    Wend
    
    lobjXlApp.Range("A" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    
    ' Save the workbook
    lobjXlWb.SaveAs FileName:=piFileName, FileFormat:=xlNormal

    lobjXlApp.Visible = False
    lobjXlWb.Close
        
    GenConsTSForUser = True
    GoTo GenConsTSForUser_Exit

GenConsTSForUser_Err:
    GenConsTSForUser = False
GenConsTSForUser_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
    Set lRsName = Nothing
    Set lobjXlApp = Nothing
    Set lobjXlWb = Nothing
    Set lobjXlWs = Nothing
End Function

Public Function GenConsTSForGroup(ByVal piFileName As String, ByVal piGroupID As Integer, ByVal piStartDate As Date, ByVal piEndDate) As Boolean
On Error GoTo GenConsTSForGroup_Err
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lRsName As ADODB.Recordset
    Dim lSql As String
    Dim lGroupUsersRs As ADODB.Recordset
    Dim UserIDString As String
    Dim lProjectsRs As ADODB.Recordset
    Dim lCodesRs As ADODB.Recordset
    Dim lUserProfileRs As ADODB.Recordset
    Dim UserNameString As String
    Dim lobjXlApp As Excel.Application
    Dim lobjXlWb As Excel.Workbook
    Dim lobjXlWs As Excel.Worksheet
    Dim lSunDate As Date
    Dim lProjectName As String
    Dim lIdx As Integer
    Dim lCodeTotal As Double
    Dim lMonTotal As Double
    Dim lTueTotal As Double
    Dim lWedTotal As Double
    Dim lThuTotal As Double
    Dim lFriTotal As Double
    Dim lSatTotal As Double
    Dim lSunTotal As Double
    Dim lTotal As Double
    Dim lProjectID As Integer
    Dim lCodeID As Integer
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRsName = CreateObject("ADODB.Recordset")
    Set lGroupUsersRs = CreateObject("ADODB.Recordset")
    Set lUserProfileRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get the group users
    lSql = "Select U_Employee_ID From TS_GroupUsers Where G_GroupID = " & piGroupID
    Set lGroupUsersRs = lCnn.Execute(lSql)
    
    If lGroupUsersRs.RecordCount > 0 Then
        While Not lGroupUsersRs.EOF
            UserIDString = UserIDString & lGroupUsersRs("U_Employee_ID") & ","
            lGroupUsersRs.MoveNext
        Wend
        
        UserIDString = Left$(UserIDString, Len(UserIDString) - 1)
    Else
        GenConsTSForGroup = False
        GoTo GenConsTSForGroup_Err
    End If
    
    ' Get Distinct projects
    Set lProjectsRs = CreateObject("ADODB.Recordset")
    lSql = "Select Distinct(P_ProjectID) From TS_WeeklyTimeSheet Where " & _
           " U_Employee_ID In (" & UserIDString & ")" & _
           " And WTS_StartDate >= '" & piStartDate & "'" & _
           " And WTS_StartDate <= '" & piEndDate & "'"
    Set lProjectsRs = lCnn.Execute(lSql)
    If (lProjectsRs.RecordCount <= 0) Then
        GenConsTSForGroup = False
        GoTo GenConsTSForGroup_Err
    Else
        GenConsTSForGroup = True
    End If
    
    ' Get Distinct codes
    Set lCodesRs = CreateObject("ADODB.Recordset")
    lSql = "Select Distinct(AC_Code) From TS_WeeklyTimeSheet Where " & _
           " U_Employee_ID In (" & UserIDString & ")" & _
           " And WTS_StartDate >= '" & piStartDate & "'" & _
           " And WTS_StartDate <= '" & piEndDate & "'"
    Set lCodesRs = lCnn.Execute(lSql)
    If (lCodesRs.RecordCount = 0) Then
        GenConsTSForGroup = False
        GoTo GenConsTSForGroup_Err
    Else
        GenConsTSForGroup = True
    End If
   
    ' Create the excel sheet
    Set lobjXlApp = CreateObject("Excel.Application")
    Set lobjXlWb = lobjXlApp.Workbooks.Add() ' Adding the workbooks to the Xl Application
    Set lobjXlWs = lobjXlApp.Worksheets.Add() ' Adding the worksheet to the work book
    
    lobjXlApp.Visible = False
    lobjXlApp.Worksheets("Sheet1").Activate
    lobjXlApp.Worksheets("Sheet1").Name = "Time Sheet"

    Application.DisplayAlerts = False
    lobjXlApp.Worksheets("Sheet2").Delete
    lobjXlApp.Worksheets("Sheet3").Delete
    lobjXlApp.Worksheets("Sheet4").Delete

    ' Fill the title
    lobjXlApp.Range("A1:I1").MergeCells = True
    lobjXlApp.Range("A1").Value = "Time Sheet"
    lobjXlApp.Range("A1").Font.Name = "Times New Roman"
    lobjXlApp.Range("A1").Font.Bold = True
    lobjXlApp.Range("A1").Font.Size = 14
    lobjXlApp.Range("A1").HorizontalAlignment = xlCenter
    Rows("1:1").RowHeight = 20.25
    lobjXlApp.Range("A1:I1").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeRight).LineStyle = xlContinuous
        
    ' Fill the Heading rows
    lobjXlApp.Range("4:4").RowHeight = 25.5
    lobjXlApp.Range("8:8").RowHeight = 25.5
    lobjXlApp.Range("A:A").ColumnWidth = 7.14
    lobjXlApp.Range("B:B").ColumnWidth = 31.4
    lobjXlApp.Range("J:J").ColumnWidth = 28.4
    
    lobjXlApp.Range("A4").Value = "Name"
    lobjXlApp.Range("A4").Font.Name = "Times New Roman"
    lobjXlApp.Range("A4").Font.Bold = True
    lobjXlApp.Range("A4").Font.Size = 10
    lobjXlApp.Range("A4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeRight).LineStyle = xlContinuous

    ' Get the group users names and display
    If lGroupUsersRs.RecordCount > 0 Then
        lGroupUsersRs.MoveFirst
        While Not lGroupUsersRs.EOF
            lSql = "Select U_Name From TS_Users Where U_Employee_ID = " & Val(Trim(lGroupUsersRs("U_Employee_ID")))
            Set lUserProfileRs = lCnn.Execute(lSql)

            UserNameString = UserNameString & lUserProfileRs("U_Name") & ", "
            lGroupUsersRs.MoveNext
        Wend
        UserNameString = Left$(UserNameString, Len(UserNameString) - 2)
    Else
        GenConsTSForGroup = False
        GoTo GenConsTSForGroup_Err
    End If
    
    lobjXlApp.Range("B4").Value = UserNameString
    lobjXlApp.Range("B4").WrapText = True
    lobjXlApp.Range("B4").Font.Name = "Times New Roman"
    lobjXlApp.Range("B4").Font.Size = 10
    lobjXlApp.Range("B4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeRight).LineStyle = xlContinuous
        
    lobjXlApp.Range("C4:D4").MergeCells = True
    lobjXlApp.Range("C4").Value = "From (date)"
    lobjXlApp.Range("C4").Font.Name = "Times New Roman"
    lobjXlApp.Range("C4").Font.Bold = True
    lobjXlApp.Range("C4").Font.Size = 10
    lobjXlApp.Range("C4:D4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    
    lobjXlApp.Range("E4").Value = piStartDate
    lobjXlApp.Range("E4").Font.Name = "Times New Roman"
    lobjXlApp.Range("E4").Font.Size = 10
    lobjXlApp.Range("E4:F4").MergeCells = True
    lobjXlApp.Range("E4:F4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G4").Value = "Emp. Code"
    lobjXlApp.Range("G4").Font.Name = "Times New Roman"
    lobjXlApp.Range("G4").Font.Bold = True
    lobjXlApp.Range("G4").Font.Size = 10
    lobjXlApp.Range("G4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H4:I4").MergeCells = True
    lobjXlApp.Range("H4").Value = ""
    lobjXlApp.Range("H4").Font.Name = "Times New Roman"
    lobjXlApp.Range("H4:I4").Font.Size = 10
    lobjXlApp.Range("H4:I4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("A5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("C5:D5").MergeCells = True
    lobjXlApp.Range("C5").Value = "To(date)"
    lobjXlApp.Range("C5").Font.Name = "Times New Roman"
    lobjXlApp.Range("C5").Font.Bold = True
    lobjXlApp.Range("C5").Font.Size = 10
    lobjXlApp.Range("C5:D5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E5:F5").MergeCells = True
    lobjXlApp.Range("E5").Value = piEndDate + 6
    lobjXlApp.Range("E5").Font.Name = "Times New Roman"
    lobjXlApp.Range("E5").Font.Size = 10
    lobjXlApp.Range("E5:F5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("G5").Value = "Dept."
    lobjXlApp.Range("G5").Font.Name = "Times New Roman"
    lobjXlApp.Range("G5").Font.Bold = True
    lobjXlApp.Range("G5").Font.Size = 10
    lobjXlApp.Range("G5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H5:I5").MergeCells = True
    lobjXlApp.Range("H5:I5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeRight).LineStyle = xlContinuous

    ' Timesheet table
    lobjXlApp.Range("A8").Value = "Activity Code"
    lobjXlApp.Range("A8").WrapText = True
    lobjXlApp.Range("A8").Font.Name = "Times New Roman"
    lobjXlApp.Range("A8").Font.Bold = True
    lobjXlApp.Range("A8").Font.Size = 10
    lobjXlApp.Range("A8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B8").Value = "Project"
    lobjXlApp.Range("B8").Font.Name = "Times New Roman"
    lobjXlApp.Range("B8").Font.Bold = True
    lobjXlApp.Range("B8").Font.Size = 10
    lobjXlApp.Range("B8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("C8:I8").MergeCells = True
    lobjXlApp.Range("C8").Value = "Time spent (in hours)"
    lobjXlApp.Range("C8").Font.Name = "Times New Roman"
    lobjXlApp.Range("C8").Font.Bold = True
    lobjXlApp.Range("C8").Font.Size = 10
    lobjXlApp.Range("C8").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C8:I8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("A9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    'lobjXlApp.Range("B9").Interior.ColorIndex = 15
    'lobjXlApp.Range("B9").Interior.Pattern = xlSolid
    
    lobjXlApp.Range("C9").Value = "Mon"
    lobjXlApp.Range("C9").Font.Name = "Times New Roman"
    lobjXlApp.Range("C9").Font.Bold = True
    lobjXlApp.Range("C9").Font.Size = 10
    lobjXlApp.Range("C9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("D9").Value = "Tue"
    lobjXlApp.Range("D9").Font.Name = "Times New Roman"
    lobjXlApp.Range("D9").Font.Bold = True
    lobjXlApp.Range("D9").Font.Size = 10
    lobjXlApp.Range("D9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("D9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E9").Value = "Wed"
    lobjXlApp.Range("E9").Font.Name = "Times New Roman"
    lobjXlApp.Range("E9").Font.Bold = True
    lobjXlApp.Range("E9").Font.Size = 10
    lobjXlApp.Range("E9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("E9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("F9").Value = "Thu"
    lobjXlApp.Range("F9").Font.Name = "Times New Roman"
    lobjXlApp.Range("F9").Font.Bold = True
    lobjXlApp.Range("F9").Font.Size = 10
    lobjXlApp.Range("F9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("F9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G9").Value = "Fri"
    lobjXlApp.Range("G9").Font.Name = "Times New Roman"
    lobjXlApp.Range("G9").Font.Bold = True
    lobjXlApp.Range("G9").Font.Size = 10
    lobjXlApp.Range("G9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("G9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H9").Value = "Sat"
    lobjXlApp.Range("H9").Font.Name = "Times New Roman"
    lobjXlApp.Range("H9").Font.Bold = True
    lobjXlApp.Range("H9").Font.Size = 10
    lobjXlApp.Range("H9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("H9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("I9").Value = "Sun"
    lobjXlApp.Range("I9").Font.Name = "Times New Roman"
    lobjXlApp.Range("I9").Font.Bold = True
    lobjXlApp.Range("I9").Font.Size = 10
    lobjXlApp.Range("I9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("I9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("J9").Value = "Net Time for each activity"
    lobjXlApp.Range("J9").Font.Name = "Times New Roman"
    lobjXlApp.Range("J9").Font.Bold = True
    lobjXlApp.Range("J9").Font.Size = 10
    lobjXlApp.Range("J9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("J9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lIdx = 0
    While Not lProjectsRs.EOF
        ' Get the project name from project id
        lProjectID = Val(Trim(lProjectsRs("P_ProjectID")))
        lProjectName = GetProjectName(lProjectID)
        
        lCodesRs.MoveFirst
        While Not lCodesRs.EOF
            lCodeID = Val(Trim(lCodesRs("AC_Code")))
            
            ' Get the record set for the given input arguments
            lSql = "Select Sum(WTS_MonHrs), Sum(WTS_TueHrs), Sum(WTS_WedHrs), Sum(WTS_ThuHrs), Sum(WTS_FriHrs), Sum(WTS_SatHrs), Sum(WTS_SunHrs) From TS_WeeklyTimeSheet Where " & _
                   " U_Employee_ID In (" & UserIDString & ")" & _
                   " And WTS_StartDate >= '" & piStartDate & "'" & _
                   " And WTS_StartDate <= '" & piEndDate & "'" & _
                   " And AC_Code = " & lCodeID & _
                   " And P_ProjectID = " & lProjectID
            Set lRs = lCnn.Execute(lSql)
            If lRs.RecordCount > 0 And Not IsNull(lRs(0)) Then
                lIdx = lIdx + 1
                
                ' Generate the values
               lobjXlApp.Range("A" & (9 + lIdx)).Value = lCodeID
               lobjXlApp.Range("A" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("A" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("B" & (9 + lIdx)).Value = lProjectName
               lobjXlApp.Range("B" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("B" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("C" & (9 + lIdx)).Value = Trim(lRs(0))
               lobjXlApp.Range("C" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("C" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("D" & (9 + lIdx)).Value = Trim(lRs(1))
               lobjXlApp.Range("D" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("D" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("E" & (9 + lIdx)).Value = Trim(lRs(2))
               lobjXlApp.Range("E" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("E" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("F" & (9 + lIdx)).Value = Trim(lRs(3))
               lobjXlApp.Range("F" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("F" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("G" & (9 + lIdx)).Value = Trim(lRs(4))
               lobjXlApp.Range("G" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("G" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("H" & (9 + lIdx)).Value = Trim(lRs(5))
               lobjXlApp.Range("H" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("H" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               
               lobjXlApp.Range("I" & (9 + lIdx)).Value = Trim(lRs(6))
               lobjXlApp.Range("I" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("I" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
               ' Row total
               lCodeTotal = Val(Trim(lRs(0))) + _
                            Val(Trim(lRs(1))) + _
                            Val(Trim(lRs(2))) + _
                            Val(Trim(lRs(3))) + _
                            Val(Trim(lRs(4))) + _
                            Val(Trim(lRs(5))) + _
                            Val(Trim(lRs(6)))
              
               lobjXlApp.Range("J" & (9 + lIdx)).Value = lCodeTotal
               lobjXlApp.Range("J" & (9 + lIdx)).Font.Name = "Times New Roman"
               lobjXlApp.Range("J" & (9 + lIdx)).Font.Size = 10
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
               lobjXlApp.Range("J" & (9 + lIdx)).Interior.ColorIndex = 15
               lobjXlApp.Range("J" & (9 + lIdx)).Interior.Pattern = xlSolid
               
               ' Column Total
               lMonTotal = lMonTotal + Val(Trim(lRs(0)))
               lTueTotal = lTueTotal + Val(Trim(lRs(1)))
               lWedTotal = lWedTotal + Val(Trim(lRs(2)))
               lThuTotal = lThuTotal + Val(Trim(lRs(3)))
               lFriTotal = lFriTotal + Val(Trim(lRs(4)))
               lSatTotal = lSatTotal + Val(Trim(lRs(5)))
               lSunTotal = lSunTotal + Val(Trim(lRs(6)))
               
               ' Grand total
               lTotal = lTotal + lCodeTotal
            End If
            lCodesRs.MoveNext
        Wend
        lProjectsRs.MoveNext
    Wend
    
    lobjXlApp.Range("A" & (10 + lIdx)).Value = "Total"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Generate column total cells
    lobjXlApp.Range("C" & (10 + lIdx)).Value = lMonTotal
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("D" & (10 + lIdx)).Value = lTueTotal
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("E" & (10 + lIdx)).Value = lWedTotal
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("F" & (10 + lIdx)).Value = lThuTotal
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("G" & (10 + lIdx)).Value = lFriTotal
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("H" & (10 + lIdx)).Value = lSatTotal
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("I" & (10 + lIdx)).Value = lSunTotal
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("J" & (10 + lIdx)).Value = lTotal
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Display the list of codes and their description
    Dim lAllCodesRs As ADODB.Recordset
    Dim lCodeID1 As Integer
    Dim lCodeDesc As String
    
    Set lAllCodesRs = CreateObject("ADODB.RecordSet")
    Set lAllCodesRs = GetAllCodes()
    
    lobjXlApp.Range("A" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("B" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).HorizontalAlignment = xlCenter
    
    lobjXlApp.Range("D" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("E" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).HorizontalAlignment = xlCenter

    While Not lAllCodesRs.EOF
        lIdx = lIdx + 1
        
        lCodeID1 = Val(Trim(lAllCodesRs("AC_Code")))
        lCodeDesc = Trim(lAllCodesRs("AC_Description"))
        
        lobjXlApp.Range("A" & (12 + lIdx)).Value = lCodeID1
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        lobjXlApp.Range("B" & (12 + lIdx)).Value = lCodeDesc
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        
        lAllCodesRs.MoveNext
        If Not lAllCodesRs.EOF Then
            lCodeID1 = Val(Trim(lAllCodesRs("AC_Code")))
            lCodeDesc = Trim(lAllCodesRs("AC_Description"))
            
            lobjXlApp.Range("D" & (12 + lIdx)).Value = lCodeID1
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            lobjXlApp.Range("E" & (12 + lIdx)).Value = lCodeDesc
            lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            lAllCodesRs.MoveNext
        End If
    Wend
    
    lobjXlApp.Range("A" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    
    ' Save the workbook
    lobjXlWb.SaveAs FileName:=piFileName, FileFormat:=xlNormal

    lobjXlApp.Visible = False
    lobjXlWb.Close
        
    GenConsTSForGroup = True
    GoTo GenConsTSForGroup_Exit

GenConsTSForGroup_Err:
    GenConsTSForGroup = False
GenConsTSForGroup_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
    Set lRsName = Nothing
    Set lobjXlApp = Nothing
    Set lobjXlWb = Nothing
    Set lobjXlWs = Nothing
End Function

Public Function GenConsTSForProject(ByVal piFileName As String, ByVal piProjectID As Integer, ByVal piStartDate As Date, ByVal piEndDate) As Boolean
On Error GoTo GenConsTSForProject_Err
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lRsName As ADODB.Recordset
    Dim lSql As String
    Dim lProjectsRs As ADODB.Recordset
    Dim lCodesRs As ADODB.Recordset
    Dim lUserProfileRs As ADODB.Recordset
    Dim lobjXlApp As Excel.Application
    Dim lobjXlWb As Excel.Workbook
    Dim lobjXlWs As Excel.Worksheet
    Dim lSunDate As Date
    Dim lProjectName As String
    Dim lIdx As Integer
    Dim lCodeTotal As Double
    Dim lMonTotal As Double
    Dim lTueTotal As Double
    Dim lWedTotal As Double
    Dim lThuTotal As Double
    Dim lFriTotal As Double
    Dim lSatTotal As Double
    Dim lSunTotal As Double
    Dim lTotal As Double
    Dim lProjectID As Integer
    Dim lCodeID As Integer
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRsName = CreateObject("ADODB.Recordset")
    Set lUserProfileRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get Distinct projects
    Set lProjectsRs = CreateObject("ADODB.Recordset")
    lSql = "Select * From TS_Projects Where " & _
           " P_ProjectID = " & piProjectID
    Set lProjectsRs = lCnn.Execute(lSql)
    If (lProjectsRs.RecordCount <= 0) Then
        GenConsTSForProject = False
        GoTo GenConsTSForProject_Err
    Else
        GenConsTSForProject = True
    End If
    
    ' Get Distinct codes
    Set lCodesRs = CreateObject("ADODB.Recordset")
    lSql = "Select Distinct(AC_Code) From TS_WeeklyTimeSheet Where " & _
           " P_ProjectID = " & piProjectID & _
           " And WTS_StartDate >= '" & piStartDate & "'" & _
           " And WTS_StartDate <= '" & piEndDate & "'"
    Set lCodesRs = lCnn.Execute(lSql)
    If (lCodesRs.RecordCount = 0) Then
        GenConsTSForProject = False
        GoTo GenConsTSForProject_Err
    Else
        GenConsTSForProject = True
    End If
   
    ' Create the excel sheet
    Set lobjXlApp = CreateObject("Excel.Application")
    Set lobjXlWb = lobjXlApp.Workbooks.Add() ' Adding the workbooks to the Xl Application
    Set lobjXlWs = lobjXlApp.Worksheets.Add() ' Adding the worksheet to the work book
    
    lobjXlApp.Visible = False
    lobjXlApp.Worksheets("Sheet1").Activate
    lobjXlApp.Worksheets("Sheet1").Name = "Time Sheet"

    Application.DisplayAlerts = False
    lobjXlApp.Worksheets("Sheet2").Delete
    lobjXlApp.Worksheets("Sheet3").Delete
    lobjXlApp.Worksheets("Sheet4").Delete

    ' Fill the title
    lobjXlApp.Range("A1:I1").MergeCells = True
    lobjXlApp.Range("A1").Value = "Time Sheet"
    lobjXlApp.Range("A1").Font.Name = "Times New Roman"
    lobjXlApp.Range("A1").Font.Bold = True
    lobjXlApp.Range("A1").Font.Size = 14
    lobjXlApp.Range("A1").HorizontalAlignment = xlCenter
    Rows("1:1").RowHeight = 20.25
    lobjXlApp.Range("A1:I1").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A1:I1").Borders(xlEdgeRight).LineStyle = xlContinuous
        
    ' Fill the Heading rows
    lobjXlApp.Range("4:4").RowHeight = 25.5
    lobjXlApp.Range("8:8").RowHeight = 25.5
    lobjXlApp.Range("A:A").ColumnWidth = 7.14
    lobjXlApp.Range("B:B").ColumnWidth = 31.4
    lobjXlApp.Range("J:J").ColumnWidth = 28.4
    
    lobjXlApp.Range("A4").Value = "Project"
    lobjXlApp.Range("A4").Font.Name = "Times New Roman"
    lobjXlApp.Range("A4").Font.Bold = True
    lobjXlApp.Range("A4").Font.Size = 10
    lobjXlApp.Range("A4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A4").Borders(xlEdgeRight).LineStyle = xlContinuous

    ' Get the group users names and display
    Dim lProjName As String
    
    lProjName = "Unknown"
    
    If lProjectsRs.RecordCount > 0 Then
        lProjName = Trim(lProjectsRs("P_ProjectName"))
    Else
        GenConsTSForProject = False
        GoTo GenConsTSForProject_Err
    End If
    
    lobjXlApp.Range("B4").Value = lProjName
    lobjXlApp.Range("B4").WrapText = True
    lobjXlApp.Range("B4").Font.Name = "Times New Roman"
    lobjXlApp.Range("B4").Font.Size = 10
    lobjXlApp.Range("B4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B4").Borders(xlEdgeRight).LineStyle = xlContinuous
        
    lobjXlApp.Range("C4:D4").MergeCells = True
    lobjXlApp.Range("C4").Value = "From (date)"
    lobjXlApp.Range("C4").Font.Name = "Times New Roman"
    lobjXlApp.Range("C4").Font.Bold = True
    lobjXlApp.Range("C4").Font.Size = 10
    lobjXlApp.Range("C4:D4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C4:D4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    
    lobjXlApp.Range("E4").Value = piStartDate
    lobjXlApp.Range("E4").Font.Name = "Times New Roman"
    lobjXlApp.Range("E4").Font.Size = 10
    lobjXlApp.Range("E4:F4").MergeCells = True
    lobjXlApp.Range("E4:F4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E4:F4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G4").Value = ""
    lobjXlApp.Range("G4").Font.Name = "Times New Roman"
    lobjXlApp.Range("G4").Font.Bold = True
    lobjXlApp.Range("G4").Font.Size = 10
    lobjXlApp.Range("G4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H4:I4").MergeCells = True
    lobjXlApp.Range("H4").Value = ""
    lobjXlApp.Range("H4").Font.Name = "Times New Roman"
    lobjXlApp.Range("H4:I4").Font.Size = 10
    lobjXlApp.Range("H4:I4").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H4:I4").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("A5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("C5:D5").MergeCells = True
    lobjXlApp.Range("C5").Value = "To(date)"
    lobjXlApp.Range("C5").Font.Name = "Times New Roman"
    lobjXlApp.Range("C5").Font.Bold = True
    lobjXlApp.Range("C5").Font.Size = 10
    lobjXlApp.Range("C5:D5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C5:D5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E5:F5").MergeCells = True
    lobjXlApp.Range("E5").Value = piEndDate + 6
    lobjXlApp.Range("E5").Font.Name = "Times New Roman"
    lobjXlApp.Range("E5").Font.Size = 10
    lobjXlApp.Range("E5:F5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E5:F5").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("G5").Value = "Dept."
    lobjXlApp.Range("G5").Font.Name = "Times New Roman"
    lobjXlApp.Range("G5").Font.Bold = True
    lobjXlApp.Range("G5").Font.Size = 10
    lobjXlApp.Range("G5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G5").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H5:I5").MergeCells = True
    lobjXlApp.Range("H5:I5").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H5:I5").Borders(xlEdgeRight).LineStyle = xlContinuous

    ' Timesheet table
    lobjXlApp.Range("A8").Value = "Activity Code"
    lobjXlApp.Range("A8").WrapText = True
    lobjXlApp.Range("A8").Font.Name = "Times New Roman"
    lobjXlApp.Range("A8").Font.Bold = True
    lobjXlApp.Range("A8").Font.Size = 10
    lobjXlApp.Range("A8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A8").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B8").Value = "Project"
    lobjXlApp.Range("B8").Font.Name = "Times New Roman"
    lobjXlApp.Range("B8").Font.Bold = True
    lobjXlApp.Range("B8").Font.Size = 10
    lobjXlApp.Range("B8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("C8:I8").MergeCells = True
    lobjXlApp.Range("C8").Value = "Time spent (in hours)"
    lobjXlApp.Range("C8").Font.Name = "Times New Roman"
    lobjXlApp.Range("C8").Font.Bold = True
    lobjXlApp.Range("C8").Font.Size = 10
    lobjXlApp.Range("C8").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C8:I8").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C8:I8").Borders(xlEdgeRight).LineStyle = xlContinuous

    lobjXlApp.Range("A9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    'lobjXlApp.Range("B9").Interior.ColorIndex = 15
    'lobjXlApp.Range("B9").Interior.Pattern = xlSolid
    
    lobjXlApp.Range("C9").Value = "Mon"
    lobjXlApp.Range("C9").Font.Name = "Times New Roman"
    lobjXlApp.Range("C9").Font.Bold = True
    lobjXlApp.Range("C9").Font.Size = 10
    lobjXlApp.Range("C9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("C9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("D9").Value = "Tue"
    lobjXlApp.Range("D9").Font.Name = "Times New Roman"
    lobjXlApp.Range("D9").Font.Bold = True
    lobjXlApp.Range("D9").Font.Size = 10
    lobjXlApp.Range("D9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("D9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E9").Value = "Wed"
    lobjXlApp.Range("E9").Font.Name = "Times New Roman"
    lobjXlApp.Range("E9").Font.Bold = True
    lobjXlApp.Range("E9").Font.Size = 10
    lobjXlApp.Range("E9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("E9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("F9").Value = "Thu"
    lobjXlApp.Range("F9").Font.Name = "Times New Roman"
    lobjXlApp.Range("F9").Font.Bold = True
    lobjXlApp.Range("F9").Font.Size = 10
    lobjXlApp.Range("F9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("F9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("G9").Value = "Fri"
    lobjXlApp.Range("G9").Font.Name = "Times New Roman"
    lobjXlApp.Range("G9").Font.Bold = True
    lobjXlApp.Range("G9").Font.Size = 10
    lobjXlApp.Range("G9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("G9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("H9").Value = "Sat"
    lobjXlApp.Range("H9").Font.Name = "Times New Roman"
    lobjXlApp.Range("H9").Font.Bold = True
    lobjXlApp.Range("H9").Font.Size = 10
    lobjXlApp.Range("H9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("H9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("I9").Value = "Sun"
    lobjXlApp.Range("I9").Font.Name = "Times New Roman"
    lobjXlApp.Range("I9").Font.Bold = True
    lobjXlApp.Range("I9").Font.Size = 10
    lobjXlApp.Range("I9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("I9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("J9").Value = "Net Time for each activity"
    lobjXlApp.Range("J9").Font.Name = "Times New Roman"
    lobjXlApp.Range("J9").Font.Bold = True
    lobjXlApp.Range("J9").Font.Size = 10
    lobjXlApp.Range("J9").HorizontalAlignment = xlCenter
    lobjXlApp.Range("J9").Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J9").Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lIdx = 0
    
    While Not lCodesRs.EOF
        lCodeID = Val(Trim(lCodesRs("AC_Code")))
        
        ' Get the record set for the given input arguments
        lSql = "Select Sum(WTS_MonHrs), Sum(WTS_TueHrs), Sum(WTS_WedHrs), Sum(WTS_ThuHrs), Sum(WTS_FriHrs), Sum(WTS_SatHrs), Sum(WTS_SunHrs) From TS_WeeklyTimeSheet Where " & _
               " WTS_StartDate >= '" & piStartDate & "'" & _
               " And WTS_StartDate <= '" & piEndDate & "'" & _
               " And AC_Code = " & lCodeID & _
               " And P_ProjectID = " & piProjectID
               
        Set lRs = lCnn.Execute(lSql)
        If lRs.RecordCount > 0 And Not IsNull(lRs(0)) Then
            lIdx = lIdx + 1
            
            ' Generate the values
           lobjXlApp.Range("A" & (9 + lIdx)).Value = lCodeID
           lobjXlApp.Range("A" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("A" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("A" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
           
           lobjXlApp.Range("B" & (9 + lIdx)).Value = lProjName
           lobjXlApp.Range("B" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("B" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("B" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
           
           lobjXlApp.Range("C" & (9 + lIdx)).Value = Trim(lRs(0))
           lobjXlApp.Range("C" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("C" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("C" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
           
           lobjXlApp.Range("D" & (9 + lIdx)).Value = Trim(lRs(1))
           lobjXlApp.Range("D" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("D" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("D" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
           
           lobjXlApp.Range("E" & (9 + lIdx)).Value = Trim(lRs(2))
           lobjXlApp.Range("E" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("E" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("E" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
           
           lobjXlApp.Range("F" & (9 + lIdx)).Value = Trim(lRs(3))
           lobjXlApp.Range("F" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("F" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("F" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
           
           lobjXlApp.Range("G" & (9 + lIdx)).Value = Trim(lRs(4))
           lobjXlApp.Range("G" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("G" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("G" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
           
           lobjXlApp.Range("H" & (9 + lIdx)).Value = Trim(lRs(5))
           lobjXlApp.Range("H" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("H" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("H" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
           
           lobjXlApp.Range("I" & (9 + lIdx)).Value = Trim(lRs(6))
           lobjXlApp.Range("I" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("I" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("I" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
           ' Row total
           lCodeTotal = Val(Trim(lRs(0))) + _
                        Val(Trim(lRs(1))) + _
                        Val(Trim(lRs(2))) + _
                        Val(Trim(lRs(3))) + _
                        Val(Trim(lRs(4))) + _
                        Val(Trim(lRs(5))) + _
                        Val(Trim(lRs(6)))
          
           lobjXlApp.Range("J" & (9 + lIdx)).Value = lCodeTotal
           lobjXlApp.Range("J" & (9 + lIdx)).Font.Name = "Times New Roman"
           lobjXlApp.Range("J" & (9 + lIdx)).Font.Size = 10
           lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
           lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
           lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
           lobjXlApp.Range("J" & (9 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
           lobjXlApp.Range("J" & (9 + lIdx)).Interior.ColorIndex = 15
           lobjXlApp.Range("J" & (9 + lIdx)).Interior.Pattern = xlSolid
           
           ' Column Total
           lMonTotal = lMonTotal + Val(Trim(lRs(0)))
           lTueTotal = lTueTotal + Val(Trim(lRs(1)))
           lWedTotal = lWedTotal + Val(Trim(lRs(2)))
           lThuTotal = lThuTotal + Val(Trim(lRs(3)))
           lFriTotal = lFriTotal + Val(Trim(lRs(4)))
           lSatTotal = lSatTotal + Val(Trim(lRs(5)))
           lSunTotal = lSunTotal + Val(Trim(lRs(6)))
           
           ' Grand total
           lTotal = lTotal + lCodeTotal
        End If
        lCodesRs.MoveNext
    Wend
   
    lobjXlApp.Range("A" & (10 + lIdx)).Value = "Total"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("A" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("B" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Generate column total cells
    lobjXlApp.Range("C" & (10 + lIdx)).Value = lMonTotal
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("C" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("C" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("D" & (10 + lIdx)).Value = lTueTotal
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("D" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("E" & (10 + lIdx)).Value = lWedTotal
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("E" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("F" & (10 + lIdx)).Value = lThuTotal
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("F" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("F" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("G" & (10 + lIdx)).Value = lFriTotal
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("G" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("G" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("H" & (10 + lIdx)).Value = lSatTotal
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("H" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("H" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("I" & (10 + lIdx)).Value = lSunTotal
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("I" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("I" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    lobjXlApp.Range("J" & (10 + lIdx)).Value = lTotal
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("J" & (10 + lIdx)).Font.Size = 10
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.ColorIndex = 15
    lobjXlApp.Range("J" & (10 + lIdx)).Interior.Pattern = xlSolid
    
    ' Display the list of codes and their description
    Dim lAllCodesRs As ADODB.Recordset
    Dim lCodeID1 As Integer
    Dim lCodeDesc As String
    
    Set lAllCodesRs = CreateObject("ADODB.RecordSet")
    Set lAllCodesRs = GetAllCodes()
    
    lobjXlApp.Range("A" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("B" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).HorizontalAlignment = xlCenter
    
    lobjXlApp.Range("D" & (12 + lIdx)).Value = "Code"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
    lobjXlApp.Range("E" & (12 + lIdx)).Value = "Code Description"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Bold = True
    lobjXlApp.Range("E" & (12 + lIdx)).Font.Size = 10
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeTop).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
    lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).HorizontalAlignment = xlCenter

    While Not lAllCodesRs.EOF
        lIdx = lIdx + 1
        
        lCodeID1 = Val(Trim(lAllCodesRs("AC_Code")))
        lCodeDesc = Trim(lAllCodesRs("AC_Description"))
        
        lobjXlApp.Range("A" & (12 + lIdx)).Value = lCodeID1
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("A" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("A" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        lobjXlApp.Range("B" & (12 + lIdx)).Value = lCodeDesc
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Name = "Times New Roman"
        lobjXlApp.Range("B" & (12 + lIdx)).Font.Size = 10
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
        lobjXlApp.Range("B" & (12 + lIdx) & ":C" & (12 + lIdx)).MergeCells = True
        
        lAllCodesRs.MoveNext
        If Not lAllCodesRs.EOF Then
            lCodeID1 = Val(Trim(lAllCodesRs("AC_Code")))
            lCodeDesc = Trim(lAllCodesRs("AC_Description"))
            
            lobjXlApp.Range("D" & (12 + lIdx)).Value = lCodeID1
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("D" & (12 + lIdx)).Font.Size = 10
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("D" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            lobjXlApp.Range("E" & (12 + lIdx)).Value = lCodeDesc
            lobjXlApp.Range("E" & (12 + lIdx)).Font.Name = "Times New Roman"
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeLeft).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeRight).LineStyle = xlContinuous
            lobjXlApp.Range("E" & (12 + lIdx) & ":I" & (12 + lIdx)).MergeCells = True
            lAllCodesRs.MoveNext
        End If
    Wend
    
    lobjXlApp.Range("A" & (12 + lIdx) & ":I" & (12 + lIdx)).Borders(xlEdgeBottom).LineStyle = xlContinuous
    
    ' Save the workbook
    lobjXlWb.SaveAs FileName:=piFileName, FileFormat:=xlNormal

    lobjXlApp.Visible = False
    lobjXlWb.Close
        
    GenConsTSForProject = True
    GoTo GenConsTSForProject_Exit

GenConsTSForProject_Err:
    GenConsTSForProject = False
GenConsTSForProject_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
    Set lRsName = Nothing
    Set lobjXlApp = Nothing
    Set lobjXlWb = Nothing
    Set lobjXlWs = Nothing
End Function

Public Function CheckIfPRExists(ByVal piUserID As Integer, ByVal piDate As Date, ByVal piProjectID As Integer) As Boolean
On Error GoTo CheckIfPRExists_Err
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_WeeklyProgressReportDates Where " & _
           " U_Employee_ID = " & piUserID & _
           " And WPR_StartDate = '" & piDate & "'" & _
           " And P_ProjectID = " & piProjectID
           
    Set lRs = lCnn.Execute(lSql)
    If (lRs.RecordCount = 0) Then
        CheckIfPRExists = False
    Else
        CheckIfPRExists = True
    End If
    GoTo CheckIfPRExists_Exit
    
CheckIfPRExists_Err:
    CheckIfPRExists = False
CheckIfPRExists_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function InsertWPRSectDates(ByVal piSectNo As Integer, ByVal piEmpID As Integer, ByVal piProjectID, ByVal piDate As Date, ByVal piTaskDesc As String, ByVal piTaskBaseStart As String, ByVal piTaskBaseEnd As String, ByVal piTaskActStart As String, ByVal piTaskActEnd As String) As Boolean
On Error GoTo InsertWPRSectDates_Err

    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    
    Set lCnn = CreateObject("ADODB.Connection")
    Call lCnn.Open("TimeSheet", "sa", "")
    Set lRs = CreateObject("ADODB.Recordset")
    
    ' Create the SQL statement for insert into TS_WeeklyProgressReportDates table
    lSql = "Insert Into TS_WeeklyProgressReportDates Values(" & _
           piEmpID & "," & _
           "'" & piDate & "'," & _
           piSectNo & "," & _
           "'" & piTaskDesc & "'," & _
           "'" & piTaskBaseStart & "'," & _
           "'" & piTaskBaseEnd & "'," & _
           "'" & piTaskActStart & "'," & _
           "'" & piTaskActEnd & "'," & _
           piProjectID & ")"

    lCnn.Execute (lSql)
    InsertWPRSectDates = True
    GoTo InsertWPRSectDates_Exit
    
InsertWPRSectDates_Err:
    InsertWPRSectDates = False
InsertWPRSectDates_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function InsertWPRSect45(ByVal piSectNo As Integer, ByVal piEmpID As Integer, ByVal piProjectID, ByVal piDate As Date, ByVal piIssue As String, ByVal piIssueStatus As String, ByVal piIssueRemarks As String) As Boolean
On Error GoTo InsertWPRSect45_Err

    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    
    Set lCnn = CreateObject("ADODB.Connection")
    Call lCnn.Open("TimeSheet", "sa", "")
    Set lRs = CreateObject("ADODB.Recordset")
    
    ' Create the SQL statement for insert into TS_WeeklyProgressReportDates table
    lSql = "Insert Into TS_WeeklyProgressReportSections45 Values(" & _
           piEmpID & "," & _
           "'" & piDate & "'," & _
           piSectNo & "," & _
           "'" & piIssue & "'," & _
           "'" & piIssueStatus & "'," & _
           "'" & piIssueRemarks & "'," & _
           piProjectID & ")"

    lCnn.Execute (lSql)
    InsertWPRSect45 = True
    GoTo InsertWPRSect45_Exit
    
InsertWPRSect45_Err:
    InsertWPRSect45 = False
InsertWPRSect45_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function InsertWPRNotes(ByVal piSectNo As Integer, ByVal piEmpID As Integer, ByVal piProjectID, ByVal piDate As Date, ByVal piNote As String) As Boolean
On Error GoTo InsertWPRNotes_Err

    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    
    Set lCnn = CreateObject("ADODB.Connection")
    Call lCnn.Open("TimeSheet", "sa", "")
    Set lRs = CreateObject("ADODB.Recordset")
    
    ' Create the SQL statement for insert into TS_WeeklyProgressReportDates table
    lSql = "Insert Into TS_WeeklyProgressReportNotes Values(" & _
           piEmpID & "," & _
           "'" & piDate & "'," & _
           piSectNo & "," & _
           "'" & piNote & "'," & _
           piProjectID & ")"

    lCnn.Execute (lSql)
    InsertWPRNotes = True
    GoTo InsertWPRNotes_Exit
    
InsertWPRNotes_Err:
    InsertWPRNotes = False
InsertWPRNotes_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetPRSectionDates(ByVal piUserID As Integer, ByVal piProjectID As Integer, ByVal piMonDate As Date) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get the record set
    lSql = "SELECT * From TS_WeeklyProgressReportDates Where " & _
           " WPR_StartDate = '" & piMonDate & "' AND U_Employee_ID = " & piUserID & _
           " And P_ProjectID = " & piProjectID
        
    Set lRs = lCnn.Execute(lSql)
    
    Set GetPRSectionDates = lRs
    
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetPRSection45(ByVal piUserID As Integer, ByVal piProjectID As Integer, ByVal piMonDate As Date) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get the record set
    lSql = "SELECT * From TS_WeeklyProgressReportSections45 Where " & _
           " WPR_StartDate = '" & piMonDate & "' AND U_Employee_ID = " & piUserID & _
           " And P_ProjectID = " & piProjectID
        
    Set lRs = lCnn.Execute(lSql)
    
    Set GetPRSection45 = lRs
    
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetPRSectionNotes(ByVal piUserID As Integer, ByVal piProjectID As Integer, ByVal piMonDate As Date) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Get the record set
    lSql = "SELECT * From TS_WeeklyProgressReportNotes Where " & _
           " WPR_StartDate = '" & piMonDate & "' AND U_Employee_ID = " & piUserID & _
           " And P_ProjectID = " & piProjectID
        
    Set lRs = lCnn.Execute(lSql)
    
    Set GetPRSectionNotes = lRs
    
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function UpdateWPRSectDates(ByVal piSectNo As Integer, ByVal piEmpID As Integer, ByVal piProjectID, ByVal piDate As Date, ByVal piTaskDesc As String, ByVal piTaskBaseStart As String, ByVal piTaskBaseEnd As String, ByVal piTaskActStart As String, ByVal piTaskActEnd As String, ByVal piOrgTask As String) As Boolean
On Error GoTo UpdateWPRSectDates_Err
    
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    Dim lRs1 As ADODB.Recordset
    Dim lInsertFlag As Boolean
    Dim lDeleteFlag As Boolean
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRs1 = CreateObject("ADODB.Recordset")
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Check whether a record exists for this user,code, project and date
    If (piOrgTask <> "" And piTaskDesc = "") Then
        ' Just call delete
        lDeleteFlag = DeleteWPRDates(piSectNo, piEmpID, piProjectID, piDate, piOrgTask)
        UpdateWPRSectDates = lDeleteFlag
        GoTo UpdateWPRSectDates_Exit
    End If
    
    If (piTaskDesc = "") Then
        ' Just call delete
        UpdateWPRSectDates = True
        GoTo UpdateWPRSectDates_Exit
    End If
    
    If (piOrgTask = "") Then
        ' just call insert
        lInsertFlag = InsertWPRSectDates(piSectNo, piEmpID, piProjectID, piDate, piTaskDesc, piTaskBaseStart, piTaskBaseEnd, piTaskActStart, piTaskActEnd)
        UpdateWPRSectDates = lInsertFlag
        GoTo UpdateWPRSectDates_Exit
    End If
    
    ' Update should be done here
    lSql = "Update TS_WeeklyProgressReportDates Set " & _
           " WPR_TaskDescription = '" & piTaskDesc & "'" & _
           ", WPR_BaseStartDate = '" & piTaskBaseStart & "'" & _
           ", WPR_BaseEndDate = '" & piTaskBaseEnd & "'" & _
           ", WPR_ActStartDate = '" & piTaskActStart & "'" & _
           ", WPR_ActEndDate = '" & piTaskActEnd & "'" & _
           " Where" & _
            " U_Employee_ID = " & piEmpID & _
            " And P_ProjectID = " & piProjectID & _
            " And WPR_StartDate = '" & piDate & "'" & _
            " And WPR_SectionNo = " & piSectNo & _
            " And WPR_TaskDescription = '" & piOrgTask & "'"
            
    lCnn.Execute (lSql)
    UpdateWPRSectDates = True
    GoTo UpdateWPRSectDates_Exit
    
UpdateWPRSectDates_Err:
    UpdateWPRSectDates = False
UpdateWPRSectDates_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
    Set lRs1 = Nothing
End Function

Public Function DeleteWPRDates(ByVal piSectNo As Integer, ByVal piEmpID As Integer, ByVal piProjectID, ByVal piDate As Date, ByVal piOrgTask As String) As Boolean
On Error GoTo DeleteWPRDates_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Delete TS_WeeklyProgressReportDates Where " & _
            " U_Employee_ID = " & piEmpID & _
            " And P_ProjectID = " & piProjectID & _
            " And WPR_StartDate = '" & piDate & "'" & _
            " And WPR_SectionNo = " & piSectNo & _
            " And WPR_TaskDescription = '" & piOrgTask & "'"

    Set lRs = lCnn.Execute(lSql)
    DeleteWPRDates = True
    GoTo DeleteWPRDates_Exit
    
DeleteWPRDates_Err:
    DeleteWPRDates = False
DeleteWPRDates_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function UpdateWPRSect45(ByVal piSectNo As Integer, ByVal piEmpID As Integer, ByVal piProjectID, ByVal piDate As Date, ByVal piIssue As String, ByVal piIssueStatus As String, ByVal piIssueRemarks As String, ByVal piOrgIssue As String) As Boolean
On Error GoTo UpdateWPRSect45_Err
    
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    Dim lRs1 As ADODB.Recordset
    Dim lInsertFlag As Boolean
    Dim lDeleteFlag As Boolean
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRs1 = CreateObject("ADODB.Recordset")
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Check whether a record exists for this user,code, project and date
    If (piOrgIssue <> "" And piIssue = "") Then
        ' Just call delete
        lDeleteFlag = DeleteWPR45(piSectNo, piEmpID, piProjectID, piDate, piOrgIssue)
        UpdateWPRSect45 = lDeleteFlag
        GoTo UpdateWPRSect45_Exit
    End If
    
    If (piIssue = "") Then
        UpdateWPRSect45 = True
        GoTo UpdateWPRSect45_Exit
    End If
    
    If (piOrgIssue = "") Then
        ' just call insert
        lInsertFlag = InsertWPRSect45(piSectNo, piEmpID, piProjectID, piDate, piIssue, piIssueStatus, piIssueRemarks)
        UpdateWPRSect45 = lInsertFlag
        GoTo UpdateWPRSect45_Exit
    End If
    
    ' Update should be done here
    lSql = "Update TS_WeeklyProgressReportSections45 Set " & _
           " WPR_SectionTask = '" & piIssue & "'" & _
           ", WPR_TaskStatus = '" & piIssueStatus & "'" & _
           ", WPR_TaskRemarks = '" & piIssueRemarks & "'" & _
           " Where" & _
           " U_Employee_ID = " & piEmpID & _
           " And P_ProjectID = " & piProjectID & _
           " And WPR_StartDate = '" & piDate & "'" & _
           " And WPR_SectionNo = " & piSectNo & _
           " And WPR_SectionTask = '" & piOrgIssue & "'"
            
    lCnn.Execute (lSql)
    UpdateWPRSect45 = True
    GoTo UpdateWPRSect45_Exit
    
UpdateWPRSect45_Err:
    UpdateWPRSect45 = False
UpdateWPRSect45_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
    Set lRs1 = Nothing
End Function

Public Function DeleteWPR45(ByVal piSectNo As Integer, ByVal piEmpID As Integer, ByVal piProjectID, ByVal piDate As Date, ByVal piOrgIssue As String) As Boolean
On Error GoTo DeleteWPR45_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Delete TS_WeeklyProgressReportSections45 Where " & _
            " U_Employee_ID = " & piEmpID & _
            " And P_ProjectID = " & piProjectID & _
            " And WPR_StartDate = '" & piDate & "'" & _
            " And WPR_SectionNo = " & piSectNo & _
            " And WPR_SectionTask = '" & piOrgIssue & "'"

    Set lRs = lCnn.Execute(lSql)
    DeleteWPR45 = True
    GoTo DeleteWPR45_Exit
    
DeleteWPR45_Err:
    DeleteWPR45 = False
DeleteWPR45_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function UpdateWPRSectNotes(ByVal piSectNo As Integer, ByVal piEmpID As Integer, ByVal piProjectID, ByVal piDate As Date, ByVal piNote As String, ByVal piOrgNote As String) As Boolean
On Error GoTo UpdateWPRSectNotes_Err
    
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset
    Dim lRs1 As ADODB.Recordset
    Dim lInsertFlag As Boolean
    Dim lDeleteFlag As Boolean
    
    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    Set lRs1 = CreateObject("ADODB.Recordset")
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    ' Check whether a record exists for this user,code, project and date
    If (piOrgNote <> "" And piNote = "") Then
        ' Just call delete
        lDeleteFlag = DeleteWPRNotes(piSectNo, piEmpID, piProjectID, piDate, piOrgNote)
        UpdateWPRSectNotes = lDeleteFlag
        GoTo UpdateWPRSectNotes_Exit
    End If
    
    If (piNote = "") Then
        UpdateWPRSectNotes = True
        GoTo UpdateWPRSectNotes_Exit
    End If
    
    If (piOrgNote = "") Then
        ' just call insert
        lInsertFlag = InsertWPRNotes(piSectNo, piEmpID, piProjectID, piDate, piNote)
        UpdateWPRSectNotes = lInsertFlag
        GoTo UpdateWPRSectNotes_Exit
    End If
    
    ' Update should be done here
    lSql = "Update TS_WeeklyProgressReportNotes Set " & _
           " WPR_TaskDescription = '" & piNote & "'" & _
           " Where" & _
           " U_Employee_ID = " & piEmpID & _
           " And P_ProjectID = " & piProjectID & _
           " And WPR_StartDate = '" & piDate & "'" & _
           " And WPR_SectionNo = " & piSectNo & _
           " And WPR_TaskDescription = '" & piOrgNote & "'"
            
    lCnn.Execute (lSql)
    UpdateWPRSectNotes = True
    GoTo UpdateWPRSectNotes_Exit
    
UpdateWPRSectNotes_Err:
    UpdateWPRSectNotes = False
UpdateWPRSectNotes_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
    Set lRs1 = Nothing
End Function

Public Function DeleteWPRNotes(ByVal piSectNo As Integer, ByVal piEmpID As Integer, ByVal piProjectID, ByVal piDate As Date, ByVal piOrgNote As String) As Boolean
On Error GoTo DeleteWPRNotes_Err
    
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Delete TS_WeeklyProgressReportNotes Where " & _
            " U_Employee_ID = " & piEmpID & _
            " And P_ProjectID = " & piProjectID & _
            " And WPR_StartDate = '" & piDate & "'" & _
            " And WPR_SectionNo = " & piSectNo & _
            " And WPR_TaskDescription = '" & piOrgNote & "'"

    Set lRs = lCnn.Execute(lSql)
    DeleteWPRNotes = True
    GoTo DeleteWPRNotes_Exit
    
DeleteWPRNotes_Err:
    DeleteWPRNotes = False
DeleteWPRNotes_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetProgressFileName(ByVal piEmpID As Integer, ByVal piDate As Date) As String
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
    
    lFileName = "Progress_" & piEmpID & "_" & lTempDate & "_" & lTempTime & ".doc"
    GetProgressFileName = lFileName
End Function

Public Function GenPRForUser(ByVal piFileName As String, ByVal piEmpID As Integer, ByVal piProjectID As Integer, ByVal piDate As Date) As Boolean
On Error GoTo GenPRForUser_Err
    Dim lRs As ADODB.Recordset
    Dim lSql As String
    Dim lobjWdApp As Word.Application
    Dim lobjWdDoc As Word.Document
    Dim lProjectName As String
    Dim lEmpName As String
    Dim lSunDate As Date
    
    Set lobjWdApp = CreateObject("Word.Application")
    Set lRs = CreateObject("ADODB.RecordSet")
    
    ' get project name
    lProjectName = GetProjectName(piProjectID)
    
    ' get employee name
    Set lRs = GetUserProfile(piEmpID)
    lEmpName = Trim(lRs("U_Name"))
    
    ' get sun date
    lSunDate = piDate + 6
    
    ' create an empty doc
    lobjWdApp.Documents.Add DocumentType:=wdNewBlankDocument
    
    ' Heading
    lobjWdApp.Selection.Font.Size = 18
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.TypeText Text:="Progress Report Form"

    lobjWdApp.Selection.Font.Size = 10
    lobjWdApp.Selection.Font.Bold = False

    ' The first table
    lobjWdApp.ActiveDocument.Tables.Add Range:=lobjWdApp.Selection.Range, NumRows:=5, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(1).Split 1, 4
    
    ' First row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(1).Width = 70
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Project"

    ' Fisrt row second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(2).Width = 160
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:=lProjectName
    
    ' Fisrt row third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(3).Width = 70
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Name"
    
    ' Fisrt row fourth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(4).Width = 160
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(1).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:=lEmpName
    
    ' 1st row borders
    With lobjWdApp.ActiveDocument.Tables(1).Rows(1)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' 2 row
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(1).Split 1, 4
    
    ' First row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(1).Width = 70
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="From Date"

    ' 2 row second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(2).Width = 160
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:=piDate
    
    ' 2 row third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(3).Width = 70
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="To Date"
    
    ' 2 row fourth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(4).Width = 160
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(2).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:=lSunDate

    ' second row borders
    With lobjWdApp.ActiveDocument.Tables(1).Rows(2)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With
    
    ' Third row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(1).Rows(3).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 1: Achievements"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' third row borders
    With lobjWdApp.ActiveDocument.Tables(1).Rows(3)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(1).Split 1, 5
    
    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(1).Width = 200
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Task Description"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(2).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base Start"
    
    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(3).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base End"
    
    ' 4th row fourth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(4).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Actual Start"
    
    ' 4th row fifth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(5).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(4).Cells(5).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Actual End"
    
    ' 4th row borders
    With lobjWdApp.ActiveDocument.Tables(1).Rows(4)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' 5th row
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(1).Split 1, 5
    
    ' 5th row, first col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(1).Width = 200

    ' 5th row second col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(2).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"
    
    ' 5th row third col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(3).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"
    
    ' 5th row fourth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(4).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"
    
    ' 5th row fifth col
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(5).Width = 65
    
    lobjWdApp.ActiveDocument.Tables(1).Rows(5).Cells(5).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"
    
    ' dynamically generated rows
    Dim lRowCount As Integer
    
    lRowCount = 5
    lobjWdApp.Selection.Font.Bold = False
    
    Set lRs = GetPRSectionDates(piEmpID, piProjectID, piDate)
    If lRs.RecordCount > 0 Then
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 1 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(1).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseStartDate"))
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseEndDate"))
                
                ' nth row fourth col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(4).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActStartDate"))
                
                ' nth row fifth col
                lobjWdApp.ActiveDocument.Tables(1).Rows(lRowCount).Cells(5).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActEndDate"))
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph

    Dim MyRange As Word.Range
    Dim lCount As Integer
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=3, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed

    ' 1st row, first col
    lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(2).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 2: Tasks in progress"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent

'    ' third row borders
    With lobjWdApp.ActiveDocument.Tables(2).Rows(1)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(1).Split 1, 5

    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(1).Width = 200

    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Task Description"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(2).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base Start"

    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(3).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base End"

    ' 4th row fourth col
    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(4).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
   lobjWdApp.Selection.TypeText Text:="Actual Start"

   ' 4th row fifth col
   lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(5).Width = 65

   lobjWdApp.ActiveDocument.Tables(2).Rows(2).Cells(5).Select
   lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
   lobjWdApp.Selection.Font.Bold = True
   lobjWdApp.Selection.TypeText Text:="Actual End"

   ' 4th row borders
   With lobjWdApp.ActiveDocument.Tables(2).Rows(2)
       With .Borders(wdBorderLeft)
           .LineStyle = wdLineStyleSingle
           .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' 5th Row
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(1).Split 1, 5

    ' 5th row, first col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(1).Width = 200 ''

    ' 5th row second col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(2).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row third col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(3).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row fourth col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(4).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row fifth col
    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(5).Width = 65

    lobjWdApp.ActiveDocument.Tables(2).Rows(3).Cells(5).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    lobjWdApp.Selection.Font.Bold = False
    
    lRowCount = 3
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 2 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(2).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseStartDate"))
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseEndDate"))
                
                ' nth row fourth col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(4).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActStartDate"))
                
                ' nth row fifth col
                lobjWdApp.ActiveDocument.Tables(2).Rows(lRowCount).Cells(5).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActEndDate"))
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=3, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    
    lobjWdApp.ActiveDocument.Tables(3).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(3).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 3: Objectives For Next Two Reporting Periods"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent

'    ' third row borders
    With lobjWdApp.ActiveDocument.Tables(3).Rows(1)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With
    
    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(1).Split 1, 5

    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(1).Width = 200

    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Task Description"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(2).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base Start"

    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(3).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Base End"

    ' 4th row fourth col
    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(4).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
   lobjWdApp.Selection.TypeText Text:="Actual Start"

   ' 4th row fifth col
   lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(5).Width = 65

   lobjWdApp.ActiveDocument.Tables(3).Rows(2).Cells(5).Select
   lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
   lobjWdApp.Selection.Font.Bold = True
   lobjWdApp.Selection.TypeText Text:="Actual End"

   ' 4th row borders
   With lobjWdApp.ActiveDocument.Tables(3).Rows(2)
       With .Borders(wdBorderLeft)
           .LineStyle = wdLineStyleSingle
           .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderRight)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderTop)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderBottom)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
        With .Borders(wdBorderVertical)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
        End With
    End With

    ' 5th Row
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(1).Split 1, 5

    ' 5th row, first col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(1).Width = 200

    ' 5th row second col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(2).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row third col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(3).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row fourth col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(4).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(4).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    ' 5th row fifth col
    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(5).Width = 65

    lobjWdApp.ActiveDocument.Tables(3).Rows(3).Cells(5).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = False
    lobjWdApp.Selection.TypeText Text:="mm/dd/yy"

    lobjWdApp.Selection.Font.Bold = False
    
    lRowCount = 3
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 3 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(3).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseStartDate"))
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_BaseEndDate"))
                
                ' nth row fourth col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(4).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActStartDate"))
                
                ' nth row fifth col
                lobjWdApp.ActiveDocument.Tables(3).Rows(lRowCount).Cells(5).Select
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_ActEndDate"))
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=2, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    
    With lobjWdApp.ActiveDocument.Tables(4)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderRight)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderTop)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderBottom)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
     End With
    
    lobjWdApp.ActiveDocument.Tables(4).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(4).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 4: Quality Assurance Issues"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(1).Split 1, 3

    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(1).Width = 195

    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Issues"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(2).Width = 70

    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Status"

    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(3).Width = 195

    lobjWdApp.ActiveDocument.Tables(4).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Remarks"

    lobjWdApp.Selection.Font.Bold = False
    
    lRowCount = 2
    Set lRs = GetPRSection45(piEmpID, piProjectID, piDate)
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 4 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(4).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(4).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_SectionTask"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(4).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskStatus"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(4).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskRemarks"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=2, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    
    With lobjWdApp.ActiveDocument.Tables(5)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderRight)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderTop)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderBottom)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
     End With

    lobjWdApp.ActiveDocument.Tables(5).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(5).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 5: Process Improvements"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent

    ' Fourth row
    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(1).Split 1, 3

    ' Fourth row, first col
    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(1).Width = 195

    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Improvements identified for implementation"

    ' 4th row second col
    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(2).Width = 70

    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(2).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Status"

    ' 4th row third col
    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(3).Width = 195

    lobjWdApp.ActiveDocument.Tables(5).Rows(2).Cells(3).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphCenter
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Remarks"
    
    lobjWdApp.Selection.Font.Bold = False
    
    lRowCount = 2
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 5 Then
                lRowCount = lRowCount + 1
                lobjWdApp.ActiveDocument.Tables(5).Rows.Add
                
                ' nth row, first col
                lobjWdApp.ActiveDocument.Tables(5).Rows(lRowCount).Cells(1).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_SectionTask"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            
                ' nth row second col
                lobjWdApp.ActiveDocument.Tables(5).Rows(lRowCount).Cells(2).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskStatus"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                
                ' nth row third col
                lobjWdApp.ActiveDocument.Tables(5).Rows(lRowCount).Cells(3).Select
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=Trim(lRs("WPR_TaskRemarks"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
            End If
            
            lRs.MoveNext
        Wend
    End If
    
    ' The second table
    lobjWdApp.Selection.MoveDown wdParagraph, 2, wdMove
    lobjWdApp.Selection.TypeParagraph
    
    lCount = lobjWdApp.ActiveDocument.Paragraphs.Count
    Set MyRange = lobjWdApp.ActiveDocument.Paragraphs(lCount).Range
    MyRange.Collapse Direction:=wdCollapseEnd

    lobjWdApp.ActiveDocument.Tables.Add Range:=MyRange, NumRows:=2, NumColumns:= _
        1, DefaultTableBehavior:=wdWord9TableBehavior, AutoFitBehavior:= _
        wdAutoFitFixed
    
    With lobjWdApp.ActiveDocument.Tables(6)
        With .Borders(wdBorderLeft)
            .LineStyle = wdLineStyleSingle
            .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderRight)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderTop)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
         With .Borders(wdBorderBottom)
             .LineStyle = wdLineStyleSingle
             .LineWidth = wdLineWidth150pt
         End With
     End With

    lobjWdApp.ActiveDocument.Tables(6).Rows(1).Cells(1).Width = 460
    lobjWdApp.ActiveDocument.Tables(6).Rows(1).Cells(1).Select
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Section 6: Notes"
    lobjWdApp.Selection.Cells.Shading.Texture = wdTexture20Percent
    
    lobjWdApp.ActiveDocument.Tables(6).Rows(2).Cells(1).Width = 460
    
    lobjWdApp.Selection.MoveDown wdParagraph, 1, wdMove
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    
    Dim lNoteCount As Integer
    lNoteCount = 0
    Set lRs = GetPRSectionNotes(piEmpID, piProjectID, piDate)
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
              
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 6 Then
                lNoteCount = lNoteCount + 1
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=CStr(lNoteCount) & ". " & Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.TypeParagraph
            End If
            lRs.MoveNext
        Wend
    End If
    
    ' Red flags
    lobjWdApp.Selection.Font.Bold = True
    lobjWdApp.Selection.TypeText Text:="Red Flags"
    lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
    lobjWdApp.Selection.TypeParagraph
    
    If lRs.RecordCount > 0 Then
        lRs.MoveFirst
              
        While Not lRs.EOF
            If Val(lRs("WPR_SectionNo")) = 7 Then
                lobjWdApp.Selection.Font.Bold = False
                lobjWdApp.Selection.TypeText Text:=". " & Trim(lRs("WPR_TaskDescription"))
                lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
                lobjWdApp.Selection.TypeParagraph
            End If
            lRs.MoveNext
        Wend
    Else
        lobjWdApp.Selection.Font.Bold = False
        lobjWdApp.Selection.TypeText Text:=". "
        lobjWdApp.Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
        lobjWdApp.Selection.TypeParagraph
    End If
    
    ' save the document
    lobjWdApp.ActiveDocument.SaveAs FileName:=piFileName

    lobjWdApp.Visible = False
    
    GenPRForUser = True
    GoTo GenPRForUser_Exit
    
GenPRForUser_Err:
    GenPRForUser = False
    GoTo GenPRForUser_Exit
GenPRForUser_Exit:
    Set lobjWdApp = Nothing
    Set lRs = Nothing
End Function

Public Function GetBugsGroups()
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * from TS_Groups Where G_InBugsDomain = 'Y'"
    Set lRs = lCnn.Execute(lSql)
    
    Set GetBugsGroups = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function InsertBugsGroups(ByVal piGroupList As String) As Boolean
On Error GoTo InsertBugsGroups_Err
    
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lGroupList() As String
    Dim lIdx
    
    Set lCnn = CreateObject("ADODB.Connection")
    Call lCnn.Open("TimeSheet", "sa", "")
           
    lGroupList = Split(piGroupList, ",")
    For lIdx = 0 To UBound(lGroupList)
        lSql = "Update TS_Groups Set G_InBugsDomain = 'Y' Where G_GroupID =" & Val(lGroupList(lIdx))
        Call lCnn.Execute(lSql)
    Next
    
    InsertBugsGroups = True
    GoTo InsertBugsGroups_Exit
    
InsertBugsGroups_Err:
    InsertBugsGroups = False
InsertBugsGroups_Exit:
    Set lCnn = Nothing
End Function

Public Function DeleteBugsGroups(ByVal piBugsGroupsList As String) As Boolean
On Error GoTo DeleteBugsGroups_Err
    
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lGroupList() As String
    Dim lIdx
    
    Set lCnn = CreateObject("ADODB.Connection")
    Call lCnn.Open("TimeSheet", "sa", "")
           
    lGroupList = Split(piBugsGroupsList, ",")
    For lIdx = 0 To UBound(lGroupList)
        lSql = "Update TS_Groups Set G_InBugsDomain = 'N' Where G_GroupID =" & Val(lGroupList(lIdx))
        Call lCnn.Execute(lSql)
    Next
    
    DeleteBugsGroups = True
    GoTo DeleteBugsGroups_Exit
    
DeleteBugsGroups_Err:
    DeleteBugsGroups = False
DeleteBugsGroups_Exit:
    Set lCnn = Nothing

End Function

Public Function CheckIfUserMemberOfGroup(ByVal piEmpID As Integer, ByVal piGroupID As Integer) As Boolean
On Error GoTo CheckIfUserMemberOfGroup_Err

    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select * From TS_GroupUsers Where U_Employee_ID = " & piEmpID & _
           " And G_GroupID = " & piGroupID
           
    Set lRs = lCnn.Execute(lSql)
    If (lRs.RecordCount > 0) Then
        CheckIfUserMemberOfGroup = True
    Else
        CheckIfUserMemberOfGroup = False
    End If
    GoTo CheckIfUserMemberOfGroup_Exit
    
CheckIfUserMemberOfGroup_Err:
    CheckIfUserMemberOfGroup = False
CheckIfUserMemberOfGroup_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function CheckIfGroupExists(ByVal piGroupID As Integer) As Boolean
On Error GoTo CheckIfGroupExists_Err

    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select G_GroupID From TS_Groups Where G_GroupID = " & piGroupID
    Set lRs = lCnn.Execute(lSql)
    If (lRs.RecordCount > 0) Then
        CheckIfGroupExists = True
    Else
        CheckIfGroupExists = False
    End If
    GoTo CheckIfGroupExists_Exit
    
CheckIfGroupExists_Err:
    CheckIfGroupExists = False
CheckIfGroupExists_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function GetUserGroups(ByVal piEmpID As Integer) As ADODB.Recordset
    Dim lCnn As ADODB.Connection
    Dim lSql As String
    Dim lRs As ADODB.Recordset

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select TS_GroupUsers.G_GroupID, TS_Groups.G_GroupName, TS_GroupUsers.G_GroupDeveloper, TS_GroupUsers.G_GroupTester" & _
           " From TS_GroupUsers, TS_Groups " & _
           " Where TS_GroupUsers.U_Employee_ID = " & piEmpID & _
           " And TS_Groups.G_GroupID = TS_GroupUsers.G_GroupID"
    Set lRs = lCnn.Execute(lSql)
    
    Set GetUserGroups = lRs
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function UpdateUserGroupRights(ByVal piEmployeeID As Integer, ByVal piGrpID As Integer, ByVal piDvlp As String, ByVal piTest As String) As Boolean
On Error GoTo UpdateUserGroupRights_Err
   
    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")

    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Update TS_GroupUsers Set " & _
           " G_GroupDeveloper = '" & piDvlp & "'" & _
           " ,G_GroupTester = '" & piTest & "'" & _
           " Where G_GroupID = " & piGrpID & _
           " And U_Employee_ID = " & piEmployeeID
           
    Set lRs = lCnn.Execute(lSql)
    UpdateUserGroupRights = True
    GoTo UpdateUserGroupRights_Exit
    
UpdateUserGroupRights_Err:
    UpdateUserGroupRights = False
UpdateUserGroupRights_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function


Public Function CheckIfDeveloper(ByVal piEmpID As Integer, ByVal piProjectID As Integer) As String
On Error GoTo CheckIfDeveloper_Err

    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select G_GroupDeveloper From TS_GroupUsers Where U_Employee_ID = " & piEmpID & " And G_GroupID = " & piProjectID
    Set lRs = lCnn.Execute(lSql)
    If (lRs.RecordCount > 0) Then
        CheckIfDeveloper = Trim(lRs("G_GroupDeveloper"))
    Else
        CheckIfDeveloper = "N"
    End If
    GoTo CheckIfDeveloper_Exit
    
CheckIfDeveloper_Err:
    CheckIfDeveloper = "N"
CheckIfDeveloper_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

Public Function CheckIfTester(ByVal piEmpID As Integer, ByVal piProjectID As Integer) As String
On Error GoTo CheckIfTester_Err

    Dim lCnn As ADODB.Connection
    Dim lRs As ADODB.Recordset
    Dim lSql As String

    Set lCnn = CreateObject("ADODB.Connection")
    Set lRs = CreateObject("ADODB.Recordset")
    
    lCnn.CursorLocation = adUseClient
    Call lCnn.Open("TimeSheet", "sa", "")

    lSql = "Select G_GroupTester From TS_GroupUsers Where U_Employee_ID = " & piEmpID & " And G_GroupID = " & piProjectID
    Set lRs = lCnn.Execute(lSql)
    If (lRs.RecordCount > 0) Then
        CheckIfTester = Trim(lRs("G_GroupTester"))
    Else
        CheckIfTester = "N"
    End If
    GoTo CheckIfTester_Exit
    
CheckIfTester_Err:
    CheckIfTester = "N"
CheckIfTester_Exit:
    Set lCnn = Nothing
    Set lRs = Nothing
End Function

