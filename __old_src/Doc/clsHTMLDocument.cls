VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CHTMLDocument"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public WithEvents ghtml_doc As HTMLDocument
Attribute ghtml_doc.VB_VarHelpID = -1
Public gbody_id As String
Public m_blocks As New Collection
Public m_xml_node As IXMLDOMNode

Public Function set_active_dom_doc(ByVal pHTMLDoc As HTMLDocument)
    Set ghtml_doc = pHTMLDoc
End Function

Public Function get_dom_object(ByVal pid As String) As HTMLGenericElement
    Set get_dom_object = ghtml_doc.All(pid)
End Function

Public Function load_xdoc(ByVal pnode_id As Integer)
      ghtml_doc.body.innerHTML = "<HTML><Head><Title>Phase0</Title></Head><Body><Div id='oDocPageDiv'></Div></Body></HTML>"
      gbody_id = "oDocPageDiv"
End Function

Public Function load_xnode(ByVal pnode_id As Integer)
    Dim ldiv As HTMLDivElement
    Dim lxml As String
    Dim lhtml As String
    
    Call gsrv_data.load_xnode(pnode_id)
    Call gsrv_data.expand_xlinks
    lxml = gsrv_data.get_xml_str(True)
    
    gcln_data.set_xml (lxml)
    Call gcln_data.to_html
End Function

Public Function convert_to_block(ByRef pxml_node As IXMLDOMNode)
    Dim lhtml As String
    Dim lxml_node As IXMLDOMNode
    Dim lclass_type As String
    Dim lblock As CBlock
    
    Set m_xml_node = pxml_node
    lclass_type = pxml_node.Attributes.getNamedItem("xclass_type").Text
    If lclass_type = "xNode" Then
    ElseIf lclass_type = "xNodeBlock" Then
        Set lblock = New CBlock
        Call lblock.convert_to_block(pxml_node)
        Call m_blocks.Add(lblock, pxml_node.Attributes.getNamedItem("xnode_id").Text)
    End If
    
    If pxml_node.hasChildNodes Then
        For Each lxml_node In pxml_node.childNodes
            lhtml = lhtml & convert_to_block(lxml_node)
        Next
    End If
End Function

Private Function ghtml_doc_onclick() As Boolean
    Dim linput As HTMLInputElement
    Dim lbutton As HTMLInputButtonElement
    Dim lbut As CButtonBlock
    
    If ghtml_doc.parentWindow.event.srcElement.tagName = "INPUT" Then
        Set linput = ghtml_doc.parentWindow.event.srcElement

        If linput.Type = "button" Then
            Set lbutton = ghtml_doc.parentWindow.event.srcElement
            
            ' get id
            Set lbut = get_block_object(lbutton.id)
            'Call lbut.m_button_onclick
        End If
    End If
End Function

Public Function get_block_object(ByVal pid As String) As Object
    Dim Item As CBlock
    
    For Each Item In m_blocks
        Set get_block_object = Item.get_block_object(pid)
        If Not get_block_object Is Nothing Then
            GoTo EndOfFunc
        End If
    Next
    
EndOfFunc:
End Function

Public Function send_to_server(ByVal pinode_id As Integer)
    Call gsrv_data.receive_request(gcln_data.get_xml_node(pinode_id))
End Function
