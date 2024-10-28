VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CxNode"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public m_xnode_id As Integer
Public m_xname As String
Public m_xtag As String
Public m_xparent_id As Integer
Public m_root_id As Integer
Public m_xpos As Integer
Public m_xrevision As Integer
Public m_xclass_type As String
Public m_xlife_type As String
Public m_xdata_type As String
Public m_xdata_text As String
Public m_xbase_id As Integer
Public m_xbase_revision_no As Integer
Public m_xinherit As Boolean
Public m_xoverride As Boolean
Public m_xdatetime As Date

Private m_xnode_children() As CxNode
Private m_xnode_child_count As Integer

Public Function set_data(ByVal prec As ADODB.Recordset)
    m_xnode_id = CInt(Trim(prec(0).Value))
    m_xname = CStr(Trim(prec(1).Value))
    m_xtag = CStr(Trim(prec(2).Value))
    m_xparent_id = CInt(Trim(prec(3).Value))
    m_root_id = CInt(Trim(prec(4).Value))
    m_xpos = CInt(Trim(prec(5).Value))
    m_xrevision = CInt(Trim(prec(6).Value))
    m_xclass_type = CStr(Trim(prec(7).Value))
    m_xlife_type = CStr(Trim(prec(8).Value))
    m_xdata_type = CStr(Trim(prec(9).Value))
    m_xdata_text = CStr(Trim(prec(10).Value))
    m_xbase_id = CInt(Trim(prec(11).Value))
    m_xbase_revision_no = CInt(Trim(prec(12).Value))
    
    If Trim(prec(13).Value) = "Y" Then
        m_xinherit = True
    Else
        m_xinherit = False
    End If
    
    If Trim(prec(14).Value) = "Y" Then
        m_xoverride = True
    Else
        m_xoverride = False
    End If
    
    m_xdatetime = CDate(Trim(prec(15).Value))
End Function

Public Function to_xml_string(ByVal deep As Boolean)
    Dim lstr As String
    Dim lcount As Integer
    Dim lidx As Integer
    
    lstr = "<" & m_xtag
    
    lstr = lstr & " xnode_id='" & CStr(m_xnode_id) & "'"
    lstr = lstr & " xname='" & CStr(m_xname) & "'"
    lstr = lstr & " xparent_id='" & CStr(m_xparent_id) & "'"
    lstr = lstr & " xroot_id='" & CStr(m_root_id) & "'"
    lstr = lstr & " xpos='" & CStr(m_xpos) & "'"
    lstr = lstr & " xrevision='" & CStr(m_xrevision) & "'"
    lstr = lstr & " xclass_type='" & CStr(m_xclass_type) & "'"
    lstr = lstr & " xlife_type='" & CStr(m_xlife_type) & "'"
    lstr = lstr & " xdata_type='" & CStr(m_xdata_type) & "'"
    lstr = lstr & " xdata_text='" & CStr(m_xdata_text) & "'"
    lstr = lstr & " xbase_id='" & CStr(m_xbase_id) & "'"
    lstr = lstr & " xbase_revision_no='" & CStr(m_xbase_revision_no) & "'"
    lstr = lstr & " xinherit='" & CStr(m_xinherit) & "'"
    lstr = lstr & " xoverride='" & CStr(m_xoverride) & "'"
        
    lstr = lstr & " xupdate='N'"
    lstr = lstr & " xnew='N'"
    lstr = lstr & " xremove='N'"
    lstr = lstr & " xexecute='N'"
    
    lstr = lstr & ">"
    
    If deep And m_xnode_child_count > 0 Then
        For lidx = 0 To UBound(m_xnode_children) - 1
            lstr = lstr & m_xnode_children(lidx).to_xml_string(True) & vbCrLf
        Next
    End If
    
    lstr = lstr & "</" & m_xtag & ">"
    
    to_xml_string = lstr
End Function

Public Function xselect(ByVal pnode_id As Integer, ByVal pdeep As Boolean)
    Dim lstr As String
    Dim lCRs As ADODB.Recordset
        
    lstr = "Select * from ph0_xnodes Where xnode_id = " & pnode_id
    Set lCRs = gcon.Execute(lstr)
    
    If pdeep Then
        Call xselect_deep(lCRs)
    End If
    
    Call set_data(lCRs)
End Function

Public Function xselect_deep(ByVal pCRs As ADODB.Recordset)
    Dim lstr As String
    Dim lCRs As ADODB.Recordset
    Dim lidx As Integer
    
    Call set_data(pCRs)
    
    lstr = "Select * from ph0_xnodes Where xparent_id = " & m_xnode_id & " Order By xposition asc"
    Set lCRs = gcon.Execute(lstr)
    
    If Not lCRs.EOF Then
        m_xnode_child_count = lCRs.RecordCount
        ReDim m_xnode_children(m_xnode_child_count) As CxNode
        
        lidx = 0
        While Not lCRs.EOF
            Set m_xnode_children(lidx) = New CxNode
            Call m_xnode_children(lidx).xselect_deep(lCRs)
            lidx = lidx + 1
            
            lCRs.MoveNext
        Wend
    End If
End Function

Private Function FieldExists(ByVal rs As Recordset, ByVal field As String) As Boolean
    Dim lidx As Integer
    
    For lidx = 0 To rs.Fields.Count - 1
        If Trim(rs.Fields(lidx).Name) = Trim(field) Then
            FieldExists = True
            GoTo EndOfFunc
        End If
    Next

    FieldExists = False
EndOfFunc:
End Function

Public Function expand_link(ByVal pdeep As Boolean)
    Dim lrs As ADODB.Recordset
    Dim lnode As CxNode
    Dim lstr As String
    Dim lidx As Integer
    
    If Not m_xclass_type = "xRequests" Then
        If m_xdata_type = "xLink" Then
            If m_xclass_type = "xTextBlock" Or m_xclass_type = "xTextBoxBlock" Then
                lstr = "select * from ph0_xnodes Where xnode_id = " & CInt(m_xdata_text)
                
                Call db_connect(gcon_str)
                Set lrs = gcon.Execute(lstr)
                
                If Not lrs.EOF Then
                    If Trim(lrs("xclass_type").Value) = "xNodeData" Or Trim(lrs("xclass_type").Value) = "xData" Then
                        m_xdata_type = "xData"
                        m_xdata_text = ""
                        
                        ReDim Preserve m_xnode_children(m_xnode_child_count + 1) As CxNode
                        Set m_xnode_children(m_xnode_child_count) = New CxNode
                        Call m_xnode_children(m_xnode_child_count).xselect_deep(lrs)
                        m_xnode_child_count = m_xnode_child_count + 1
                    End If
                End If
            End If
        End If
        
        If pdeep Then
            For lidx = 0 To m_xnode_child_count - 1
                Call m_xnode_children(lidx).expand_link(True)
            Next
        End If
    End If
End Function
