VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CButtonBlock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public WithEvents m_block As HTMLDivElement
Attribute m_block.VB_VarHelpID = -1
Public WithEvents m_button As HTMLInputButtonElement
Attribute m_button.VB_VarHelpID = -1
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
    If lclass_type = "xButtonBlock" Then
        Set m_xml_node = pxml_node
        id = "id_" & pxml_node.Attributes.getNamedItem("xnode_id").Text
        lhtml = "<Input type=""button"" id='" & id & "'"
        
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
    
        lhtml = lhtml & " " & lattr
        If pxml_node.Attributes.getNamedItem("xdata_type").Text = "String" Or pxml_node.Attributes.getNamedItem("xdata_type").Text = "xCaption" Then
            lhtml = lhtml & " value='" & pxml_node.Attributes.getNamedItem("xdata_text").Text & "'"
        ElseIf pxml_node.Attributes.getNamedItem("xdata_type").Text = "xData" Then
            ' text blocks
        End If
    End If
    
    lhtml = lhtml & ">"
        
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
        
        ldiv.innerHTML = ldiv.innerHTML & lhtml
        
        Set m_block = ldiv
        Set m_button = gactive_doc.get_dom_object(id)
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

Public Function m_button_onclick() As Boolean
    Dim lnode As IXMLDOMNode
    Dim lreq As IXMLDOMNode
    Dim lcurr_Req As IXMLDOMNode
    Dim lsend_to_server As Boolean
    
    Set lnode = m_xml_node.selectSingleNode("ButtonRequests")
    For Each lreq In lnode.childNodes
        If lreq.selectSingleNode("Code").Attributes.getNamedItem("xdata_text").Text = "Click" Then
            Set lcurr_Req = lreq
            Exit For
        End If
    Next
    
    If Not lcurr_Req Is Nothing Then
        lsend_to_server = do_button_action(lcurr_Req)
        If lsend_to_server Then

        End If
    End If
End Function

Public Function do_button_action(ByVal lreq As IXMLDOMNode)
    Dim lcode As String
    Dim lvalue As String
    Dim lsubrequest As IXMLDOMNode
    Dim obj As Object
    
    If lreq.selectSingleNode("Value") Is Nothing Then
        For Each lsubrequest In lreq.selectNodes("Request")
            If do_button_action(lsubrequest) = True Then
                do_button_action = True
                Exit For
            End If
        Next
    Else
        lcode = lreq.selectSingleNode("Code").Attributes.getNamedItem("xdata_text").Text
        lvalue = lreq.selectSingleNode("Value").Attributes.getNamedItem("xdata_text").Text
        
        If lcode = "UIToRegister" Then
            Set obj = gactive_doc.get_block_object("id_" & lvalue)
            Call obj.ui_to_register
            do_button_action = False
        ElseIf lcode = "Display" Then
            Set obj = gactive_doc.get_block_object("id_" & lvalue)
            Call obj.ui_to_display
            do_button_action = False
        ElseIf lcode = "RegisterToDB" Then
            lreq.Attributes.getNamedItem("xexecute").Text = "Y"
            
            do_button_action = True
            Call gactive_doc.send_to_server(lvalue)
        End If
    End If
End Function

