VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CTextBoxBlock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public WithEvents m_block As HTMLDivElement
Attribute m_block.VB_VarHelpID = -1
Public WithEvents m_textarea As HTMLTextAreaElement
Attribute m_textarea.VB_VarHelpID = -1
Public m_xml_node As IXMLDOMNode

Function convert_to_block(ByRef pxml_node As IXMLDOMNode)
    Dim lhtml As String
    Dim lxml_node As IXMLDOMNode
    Dim lxml_node1 As IXMLDOMNode
    Dim lclass_type As String
    Dim ldiv As HTMLDivElement
    Dim id As String
    Dim id1 As String
    Dim ltext As String
    Dim lattr As String
    Dim lparent_class As String
    
    lclass_type = pxml_node.Attributes.getNamedItem("xclass_type").Text
    If lclass_type = "xTextBoxBlock" Then
        Set m_xml_node = pxml_node
        id = "id_" & pxml_node.Attributes.getNamedItem("xnode_id").Text
        lhtml = "<" & pxml_node.baseName & " id='" & id & "'"
        
        ' attributes
        If pxml_node.hasChildNodes Then
            For Each lxml_node In pxml_node.childNodes
                lattr = ""
                If lxml_node.Attributes.getNamedItem("xclass_type").Text = "xAttributes" Then
                    For Each lxml_node1 In lxml_node.childNodes
                        lattr = lattr & lxml_node1.baseName & "='" & lxml_node1.Attributes.getNamedItem("xdata_text").Text & "' "
                    Next
                    Exit For
                End If
            Next
        End If
    
        lhtml = lhtml & " " & lattr & ">"
        
        If pxml_node.Attributes.getNamedItem("xdata_type").Text = "String" Then
            lhtml = lhtml & pxml_node.Attributes.getNamedItem("xdata_text").Text
        ElseIf pxml_node.Attributes.getNamedItem("xdata_type").Text = "xData" Then
            ' text blocks
             If pxml_node.hasChildNodes Then
                For Each lxml_node In pxml_node.childNodes
                    If lxml_node.Attributes.getNamedItem("xclass_type").Text = "xData" Or lxml_node.Attributes.getNamedItem("xclass_type").Text = "xNodeData" Then
                        For Each lxml_node1 In lxml_node.childNodes
                            lhtml = lhtml & lxml_node1.Attributes.getNamedItem("xdata_text").Text
                        Next
                    End If
                Next
            End If
        End If
    End If
        
    lhtml = lhtml & "</" & pxml_node.baseName & ">" & "<BR>"
    
    ' search for the parent
    Set lxml_node = pxml_node
    lparent_class = pxml_node.parentNode.Attributes.getNamedItem("xclass_type").Text
    While lxml_node.nodeType <> NODE_DOCUMENT And lparent_class <> "xNodeBlock"
        Set lxml_node = lxml_node.parentNode
        lparent_class = lxml_node.Attributes.getNamedItem("xclass_type").Text
    Wend
    
    If lparent_class = "xNodeBlock" Then
        id1 = "id_" & lxml_node.parentNode.Attributes.getNamedItem("xnode_id").Text
        Set ldiv = gactive_doc.get_dom_object(id1)
        
        ldiv.innerHTML = lhtml
        
        Set m_block = ldiv
        Set m_textarea = gactive_doc.get_dom_object(id)
    End If
End Function

Public Function get_block_object(ByVal pid As String) As Object
    If "id_" & m_xml_node.Attributes.getNamedItem("xnode_id").Text = pid Then
        Set get_block_object = Me
        GoTo EndOfFunc
    Else
        Set get_block_object = Nothing
    End If
    
EndOfFunc:
End Function

Public Function ui_to_display()
    Dim lta As HTMLTextAreaElement
    
    Set lta = gactive_doc.get_dom_object("id_" & m_xml_node.Attributes.getNamedItem("xnode_id").Text)
    MsgBox lta.Value
End Function

Public Function ui_to_register()
    Dim lta As HTMLTextAreaElement
    Dim lvalue As String
    Dim ldata_type As String
    Dim lattr As IXMLDOMNode
    
    Set lta = gactive_doc.get_dom_object("id_" & m_xml_node.Attributes.getNamedItem("xnode_id").Text)
    lvalue = lta.Value
    
    If m_xml_node.Attributes.getNamedItem("xdata_type").Text = "String" Then
        m_xml_node.Attributes.getNamedItem("xupdate").Text = "Y"
        m_xml_node.Text = lvalue
    End If
End Function

