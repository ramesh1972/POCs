VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CXMLClientData"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private gxml_str As String
Private gxml_doc As DOMDocument30

Public Function set_xml(ByVal pxml As String)
    Set gxml_doc = Nothing
    
    gxml_str = pxml
    Set gxml_doc = New DOMDocument30
    gxml_doc.loadXML (gxml_str)
End Function

Public Function to_html()
    ' loop through gxml_doc and create html
    Dim lnode As IXMLDOMNode
    
    Set lnode = gxml_doc.documentElement
    Call convert_to_block(lnode)
End Function

Public Function convert_to_block(ByRef pxml_node As IXMLDOMNode) As String
    Call gactive_doc.convert_to_block(pxml_node)
End Function

Public Function get_new_node_id() As Integer
    get_new_node_id = get_next_node_id(gxml_doc.documentElement, 0) + 1
End Function

Private Function get_next_node_id(ByVal pxml_node As IXMLDOMNode, ByVal lcurr_max As Integer) As Integer
    Dim lmax As Integer
    Dim lnode_id As Integer
    Dim lxml_node As IXMLDOMNode
    
    lnode_id = CInt(pxml_node.Attributes.getNamedItem("xnode_id").Text)
    If lnode_id > lcurr_max Then
        lcurr_max = lnode_id
    End If
    
    If pxml_node.hasChildNodes Then
        For Each lxml_node In pxml_node.childNodes
            lmax = get_next_node_id(lxml_node, lcurr_max)
            If lmax > lcurr_max Then
                lcurr_max = lmax
            End If
        Next
    End If
    
    get_next_node_id = lcurr_max
End Function

Public Function save()
    Call gxml_doc.save("C:\Documents and Settings\HomeUser\Desktop\run.xml")
End Function

Public Function get_xml_node(ByVal pinode_id As Integer) As IXMLDOMNode
    Dim lnode As IXMLDOMNode
    
    Set lnode = get_xml_obj(pinode_id, gxml_doc.documentElement)
    If lnode Is Nothing Then
        Set get_xml_node = Nothing
    Else
        Set get_xml_node = lnode
    End If
End Function

Private Function get_xml_obj(ByVal pinode_id As Integer, ByVal pxml_node As IXMLDOMNode) As IXMLDOMNode
    Dim lnode_id As Integer
    Dim lxml_node As IXMLDOMNode
    Dim lret_node As IXMLDOMNode
    
    lnode_id = CInt(pxml_node.Attributes.getNamedItem("xnode_id").Text)
    If lnode_id = pinode_id Then
        Set get_xml_obj = pxml_node
        GoTo EndOfFunc
    End If
    
    If pxml_node.hasChildNodes Then
        For Each lxml_node In pxml_node.childNodes
            Set lret_node = get_xml_obj(pinode_id, lxml_node)
            If Not lret_node Is Nothing Then
                Set get_xml_obj = pxml_node
                GoTo EndOfFunc
            End If
        Next
    End If

    Set get_xml_obj = Nothing

EndOfFunc:
End Function


