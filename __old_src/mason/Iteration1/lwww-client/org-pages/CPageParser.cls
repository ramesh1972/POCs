VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPageParser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Public Function GetParsedPage(ByVal Page As String) As String
Dim HTMLDoc As New HTMLDocument

Dim Str As String

Str = ""
HTMLDoc.location = Page
Str = HTMLDoc.body.innerHTML
MsgBox Str

'For Idx = 0 To HTMLDoc.All.length
 '   Set HTMLElem = HTMLDoc.All(Idx)
    
  '  Str = Str + HTMLElem.Id + "<BR>"
'Next

    GetParsedPage = Str
End Function
