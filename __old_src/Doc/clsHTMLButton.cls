VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsHTMLButton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private WithEvents gButton As HTMLButtonElement
Attribute gButton.VB_VarHelpID = -1

Public Function SetActiveButton(pBut As HTMLButtonElement)
    Set gButton = pBut
End Function

Private Function gButton_onclick() As Boolean
    Dim oDiv As HTMLDivElement
    Dim oText As HTMLInputTextElement
    
    Set oDiv = gActiveDoc.GetControl("oDiv")
    Set oText = gActiveDoc.GetControl("oText")
    
    oDiv.innerHTML = oText.Value
End Function

