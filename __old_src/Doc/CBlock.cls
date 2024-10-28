VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CBlock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public m_text_block As CTextBlock
Public m_textbox_block As CTextBoxBlock
Public m_button_block As CButtonBlock
Public m_xml_node As IXMLDOMNode

Public Function convert_to_block(ByVal pxml_node As IXMLDOMNode)
    Dim lhtml As String
    Dim lxml_node As IXMLDOMNode
    Dim lxml_node1 As IXMLDOMNode
    Dim lclass_type As String
    Dim ldiv As HTMLDivElement
    Dim id As String
    Dim lattr As String
    
    lclass_type = pxml_node.Attributes.getNamedItem("xclass_type").Text
    If lclass_type = "xNodeBlock" Then
        Set m_xml_node = pxml_node
        id = "id_" & pxml_node.Attributes.getNamedItem("xnode_id").Text
        lhtml = "<" & pxml_node.baseName & " id='" & id & "'"

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
       lhtml = lhtml & "</" & pxml_node.baseName & ">"
       
       Set ldiv = gactive_doc.get_dom_object(gactive_doc.gbody_id)
       ldiv.innerHTML = lhtml
    
        If pxml_node.hasChildNodes Then
            For Each lxml_node In pxml_node.childNodes
                lhtml = lhtml & convert_to_block(lxml_node)
            Next
        End If
    ElseIf lclass_type = "xTextBlock" Then
        Set m_text_block = New CTextBlock
        Call m_text_block.convert_to_block(pxml_node)
    ElseIf lclass_type = "xTextBoxBlock" Then
        Set m_textbox_block = New CTextBoxBlock
        Call m_textbox_block.convert_to_block(pxml_node)
    ElseIf lclass_type = "xButtonBlock" Then
        Set m_button_block = New CButtonBlock
        Call m_button_block.convert_to_block(pxml_node)
    End If
End Function

Public Function get_block_object(ByVal pid As String) As Object
    Dim obj As Object
    If "id_" & m_xml_node.Attributes.getNamedItem("xnode_id").Text = pid Then
        Set get_block_object = Me
        GoTo EndOfFunc
    End If
    
    If Not m_text_block Is Nothing Then
        Set obj = m_text_block.get_block_object(pid)
        If Not obj Is Nothing Then
            Set get_block_object = obj
            GoTo EndOfFunc
        End If
    End If
    
    If Not m_textbox_block Is Nothing Then
        Set obj = m_textbox_block.get_block_object(pid)
        If Not obj Is Nothing Then
            Set get_block_object = obj
            GoTo EndOfFunc
        End If
    End If
    
    If Not m_button_block Is Nothing Then
        Set obj = m_button_block.get_block_object(pid)
        If Not obj Is Nothing Then
            Set get_block_object = obj
            GoTo EndOfFunc
        End If
    End If
    
EndOfFunc:
End Function

