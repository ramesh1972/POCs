Attribute VB_Name = "Win32Procs"
Declare Function GetMenu Lib "user32" (ByVal hWnd As Long) As Long
Declare Function GetSubMenu Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long

Declare Function CreateMenu Lib "user32" () As Long
Declare Function CreatePopupMenu Lib "user32" () As Long

Declare Function AppendMenu Lib "user32" Alias "AppendMenuA" _
   (ByVal hMenu As Long, ByVal wFlags As Long, ByVal wIDNewItem _
   As Long, ByVal lpNewItem As String) As Long

Declare Function InsertMenu Lib "user32" Alias "InsertMenuA" _
   (ByVal hMenu As Long, ByVal lPos As Long, ByVal wFlags As Long, ByVal wIDNewItem _
   As Long, ByVal lpNewItem As String) As Long

Public fMainForm As frmMain

Sub Main()
    Set fMainForm = New frmMain
    fMainForm.Show
End Sub

    
