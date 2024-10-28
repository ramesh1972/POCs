VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsHTMLCombo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private WithEvents gCombo As HTMLSelectElement
Attribute gCombo.VB_VarHelpID = -1

Public Function GetNodeManagersHTML() As String
    GetNodeManagersHTML = _
    "<Table width=80% align=center border=1 style='border-collapse:collapse'>" & _
        "<TR>" & _
            "<TD>Select node manager</TD>" & _
            "<TD>" & _
                "<Select id='cbNodeManagers'>" & _
                  "<Option value=1>xClass Manager</Option>" & _
                  "<Option value=2>xNode Manager</Option>" & _
                  "<Option value=3>xData Manager</Option>" & _
                  "<Option value=4>xHTML Manager</Option>" & _
                "</Select>" & _
            "</TD>" & _
        "</TR>" & _
    "</Table>"
End Function

Public Function SetActiveCombo(pCombo As HTMLSelectElement)
    Set gCombo = pCombo
End Function

Private Sub gCombo_onchange()
    Dim oDiv As HTMLDivElement
    
    Set oDiv = gActiveDoc.GetControl("oDivxTypes")
    If gCombo.Value = 1 Then
        oDiv.innerHTML = _
            "<Table width=80% align=center border=1 style='border-collapse:collapse'>" & _
            "<TR>" & _
                "<TD>Hello0</TD>" & _
            "</TR>" & _
            "</Table>"

    ElseIf gCombo.Value = 2 Then
        oDiv.innerHTML = _
            "<Table width=80% align=center border=1 style='border-collapse:collapse'>" & _
            "<TR>" & _
                "<TD>Hello1</TD><TD>World</TD>" & _
            "</TR>" & _
            "</Table>"
        
    ElseIf gCombo.Value = 3 Then
        oDiv.innerHTML = _
            "<Table width=80% align=center border=1 style='border-collapse:collapse'>" & _
            "<TR>" & _
                "<TD>Hello1</TD><TD>World</TD><TD>World1</TD>" & _
            "</TR>" & _
            "</Table>"
    Else
        oDiv.innerHTML = ""
    End If
End Sub

