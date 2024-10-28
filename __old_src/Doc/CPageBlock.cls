VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPageBlock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public gpage_block_id As String
Public gblocks As Collection

Public Function append_block(ByRef pxml_node As IXMLDOMNode)
    Dim lblock As New CBlock
    
    Call lblock.convert_to_block(pxml_node)
    Call gblocks.Add(lblock)
End Function

Public Function convert_to_block(Byval ByRef pxml_node As IXMLDOMNode)
    Dim lhtml As String
    Dim lxml_node As IXMLDOMNode
    Dim lxml_node1 As IXMLDOMNode
    Dim lclass_type As String
    
    lclass_type = pxml_node.Attributes.getNamedItem("xclass_type").Text
    
    gpage_block_id = pxml_node.Attributes.getNamedItem("xname").Text
    
    If lclass_type = "xPageBlock" Then
        lhtml = "<" & pxml_node.baseName & _
                 " id='" & gblock_id & "'"
    
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
            
       lhtml = lhtml & " " & lattr & ">" & vbCrLf
       lhtml = lhtml & ">" & "</" & pxml_node.baseName & ">"
    
        gactive_doc.ghtml_doc.body.innerHTML = lhtml
    ElseIf lclass_type = "xNodeBlock" Then
        Call append_block(pxml_node)
    ElseIf lclass_type = "xDocumentBlock" Then
    End If
    
    If pxml_node.hasChildNodes Then
        For Each lxml_node In pxml_node.childNodes
            lhtml = lhtml & vbCrLf & convert_to_block(lxml_node)
        Next
    End If
End Function




