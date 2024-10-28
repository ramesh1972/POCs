VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CXMLServerData"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_xnode As CxNode

Public Function load_xnode(ByVal pnode_id As Integer)
    Set m_xnode = New CxNode
    
    Call db_connect(gcon_str)
    Call m_xnode.xselect(pnode_id, True)
    Call db_disconnect
End Function

Public Function load_xpage_node(ByVal pinodeid As Integer)

End Function

Public Function load_xdoc_node(ByVal pnode_id As Integer)

End Function

Public Function inherit_xnode()

End Function

Public Function expand_xlinks()
    Call m_xnode.expand_link(True)
End Function

Public Function get_xml_str(ByVal deep As Boolean) As String
        get_xml_str = m_xnode.to_xml_string(deep)
End Function

Public Function receive_request(ByVal pxml_node As IXMLDOMNode)

End Function

