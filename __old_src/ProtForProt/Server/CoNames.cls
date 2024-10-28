VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CoNames"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Public Function AddName(ByVal piFirst As String, ByVal piLast As String) As Boolean
    Dim lXMLDocument As MSXML2.DOMDocument
    Dim lXMLNode As MSXML2.IXMLDOMNode
    
    Set lXMLDocument = CreateObject("MSXML2.DOMDocument")
    lXMLDocument.Load ("C:\Names.xml")
    
    ' see if its the first child
    If Not lXMLDocument.documentElement Is Nothing Then
        Set lXMLNode = lXMLDocument.documentElement.childNodes(0).cloneNode(True)
        Call lXMLDocument.documentElement.appendChild(lXMLNode)
    Else
        ' else create the document
        Call lXMLDocument.loadXML("<NameList>" & _
                                    "<NameStruct>" & vbCrLf & _
                                        "<First></First>" & vbCrLf & _
                                        "<Last></Last>" & vbCrLf & _
                                    "</NameStruct>" & vbCrLf & _
                                  "</NameList>")
        Set lXMLNode = lXMLDocument.documentElement.childNodes(0)
    End If
    
    ' set the node values
    lXMLNode.childNodes(0).Text = piFirst
    lXMLNode.childNodes(1).Text = piLast
    
    ' save the document
    Call lXMLDocument.save("C:\Names.xml")
    
    Set lXMLDocument = Nothing

    AddName = True
End Function

Public Function BrowseNames() As String
    Dim lXMLDocument As MSXML2.DOMDocument
    Dim lXMLNode As MSXML2.IXMLDOMNode
    Dim lTableStr As String
    Dim lIdx As Integer
    
    lTableStr = "<TABlE width=100% border=1 style='border-collapse:collapse'>"
    lTableStr = lTableStr & "<TR>" _
                          & "<TD align=center color=green width=50%><B>First Name</B></TD><TD align=center color=green width=50%><B>Last Name</B></TD>" _
                          & "</TR>"
    
    Set lXMLDocument = CreateObject("MSXML2.DOMDocument")
    lXMLDocument.Load ("C:\Names.xml")
    
    ' loop through children
    For lIdx = 0 To lXMLDocument.documentElement.childNodes.length - 1
        Set lXMLNode = lXMLDocument.documentElement.childNodes(lIdx)
        
        lTableStr = lTableStr & "<TR>"
        lTableStr = lTableStr & "<TD width=40%>" & lXMLNode.childNodes(0).Text & "</TD>"
        lTableStr = lTableStr & "<TD width=60%>" & lXMLNode.childNodes(1).Text & "</TD>"
        lTableStr = lTableStr & "</TR>"
    Next
    
    lTableStr = lTableStr & "</TABLE>"
    Set lXMLDocument = Nothing

    ' return
    BrowseNames = lTableStr
End Function
