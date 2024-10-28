VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   1800
      TabIndex        =   0
      Top             =   1320
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim gConnected As Boolean
Dim lCnn As ADODB.Connection

Private Sub Command1_Click()
gConnected = False
Call GetTree(0)
End Sub

Private Function GetTree(ByVal piNodeID As Integer) As Boolean

    Dim lRs As ADODB.Recordset
    Dim lSql As String
    Dim lNodeText As String
    Dim lChildNodeID As Integer
    
    Set lRs = CreateObject("ADODB.RecordSet")
    
    If Not gConnected Then
        Set lCnn = CreateObject("ADODB.Connection")
        lCnn.CursorLocation = adUseClient
        lCnn.Open "treedb", "sa", ""
        gConnected = True
    End If
    
    ' Get the contents for the current node
    lSql = "select * from Tree Where NodeID = " & piNodeID
    Set lRs = lCnn.Execute(lSql)
    lNodeText = ""
    If lRs.RecordCount > 0 Then
        lNodeText = Trim(lRs("NodeText"))
    End If
    MsgBox ("Node Text = " & lNodeText)
    
    ' Get the children and loop through
    lSql = "Select * From Tree Where ParentNode = " & piNodeID
    Set lRs = lCnn.Execute(lSql)
    If lRs.RecordCount > 0 Then
        While Not lRs.EOF
            lChildNodeID = Val(lRs("NodeID"))
            Call GetTree(lChildNodeID)
            lRs.MoveNext
        Wend
    End If
End Function
