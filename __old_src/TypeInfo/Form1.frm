VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   6180
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7320
   LinkTopic       =   "Form1"
   ScaleHeight     =   6180
   ScaleWidth      =   7320
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   3375
      Left            =   840
      MultiLine       =   -1  'True
      TabIndex        =   2
      Text            =   "Form1.frx":0000
      Top             =   2400
      Width           =   5535
   End
   Begin VB.ListBox List1 
      Height          =   645
      Left            =   720
      TabIndex        =   1
      Top             =   1320
      Width           =   2535
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   360
      Top             =   240
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   1320
      TabIndex        =   0
      Top             =   360
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    Dim x As TypeLibInfo
    Dim y As CoClasses
    Dim z As Interfaces
    Dim w As Members
    Dim u As MemberInfo
    Dim v As Parameters
    Dim zz As ParameterInfo
    Dim zzz As CustomDataCollection
    
    Dim i As Integer, j As Integer, n As Integer, k As Integer
    Dim strName As String, strMembers As String

    Dim xmlStr As String
    Dim xmlDoc As New MSXML2.DOMDocument26
    
    xmlStr = "<TypeInfo>" & vbCrLf
    
    On Error Resume Next
    CommonDialog1.ShowOpen

    'Program ends if you click the Cancel button in the
    'file open dialog box
    If CommonDialog1.Flags = 0 Then
        End
    End If

    'Get information from type library
    Set x = TypeLibInfoFromFile(CommonDialog1.FileName)
    
    Set y = x.CoClasses

    'Show Type Library information in the List box
    For i = 1 To y.Count
     '   xmlStr = xmlStr & "    <ClassInfo>" & vbCrLf
      '  xmlStr = xmlStr & "        <ClassName id=" & Chr(34) & y.Item(i).Name & Chr(34) & ">" & y.Item(i).Name & "</ClassName>" & vbCrLf
        
        Set z = y.Item(i).Interfaces
        
        For n = 1 To z.Count
       '     xmlStr = xmlStr & "            <InterfaceInfo>" & vbCrLf
        '    xmlStr = xmlStr & "                <InterfaceName id=" & Chr(34) & z.Item(n).Name & Chr(34) & ">" & z.Item(n).Name & "</InterfaceName>" & vbCrLf
        
            Set w = z.Item(n).Members
            For k = 1 To w.Count
                Set u = w.Item(k)
              
         '       xmlStr = xmlStr & "                    <MethodInfo>" & vbCrLf
          '      xmlStr = xmlStr & "                        <MethodName id=" & Chr(34) & u.Name & Chr(34) & ">" & u.Name & "</MethodName>" & vbCrLf
                
                Set v = u.Parameters
                For l = 1 To v.Count
                    Set zz = v.Item(l)
           ''         xmlStr = xmlStr & "                               <ParameterInfo>" & vbCrLf
             '       xmlStr = xmlStr & "                                   <ParameterName  id=" & Chr(34) & zz.Name & Chr(34) & ">" & zz.Name & "</ParameterName>" & vbCrLf
              '      xmlStr = xmlStr & "                                   <ParameterType>" & zz.VarTypeInfo & "</ParameterType>" & vbCrLf
                    Set zzz = zz.CustomDataCollection
               '     xmlStr = xmlStr & "                                        <CustomInfo>" & vbCrLf
                    For q = 1 To zzz.Count
                        xmlStr = xmlStr & zzz.Item(q).Value & vbCrLf
                    Next q
                '    xmlStr = xmlStr & "                                        </CustomInfo>" & vbCrLf
                 '   xmlStr = xmlStr & "                                   </ParameterInfo>" & vbCrLf
                Next
                'xmlStr = xmlStr & "                    </MethodInfo>" & vbCrLf
            Next
            'xmlStr = xmlStr & "            </InterfaceInfo>" & vbCrLf
        Next
        'xmlStr = xmlStr & "    </ClassInfo>" & vbCrLf
    Next
    'xmlStr = xmlStr & "</TypeInfo>"
    
    Set z = Nothing
    Set y = Nothing
    Set x = Nothing
    Set w = Nothing

    'Display filename in the text box
    Text1.Text = CommonDialog1.FileName

    'If the file does not contain type library information
    'then display this error message.
    If Err.Number = 91 Then
        Dim strMsgTitle As String, strMsgError As String
        Dim intResponse
        strMsgTitle = "No Type Library"
        strMsgError = "You chose a file without a type library. "
        strMsgError = strMsgError & "Choose another file."
        Err.Clear
        intResponse = MsgBox(strMsgError, vbOKCancel, strMsgTitle)

        If intResponse = vbOK Then
            Command1_Click
        End If
    End If

    'xmlDoc.loadXML (xmlStr)
    'res = xmlDoc.Validate
    
    'Dim myErr As IXMLDOMParseError
    'Set myErr = xmlDoc.parseError
    'If (myErr.errorCode <> 0) Then
     '   MsgBox ("You have error " & myErr.reason)
    'End If

    Text1.Text = xmlStr
    'xmlDoc.save ("C:\inetpub\wwwroot\xml\typeinfo.xml")
End Sub


