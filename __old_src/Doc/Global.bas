Attribute VB_Name = "Global"
Option Explicit

Public gactive_doc As CHTMLDocument
Public gsrv_data As CXMLServerData
Public gcln_data As CXMLClientData

Public gcon As ADODB.Connection
Public gcon_str As String

Public Function db_connect(ByVal pcon_str As String)
    Set gcon = New ADODB.Connection
    
    gcon.CursorLocation = adUseClient
    Call gcon.Open(pcon_str, "sa", "")
End Function

Public Function db_disconnect()
    Call gcon.Close
End Function

