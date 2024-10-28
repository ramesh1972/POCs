Attribute VB_Name = "Module1"



Declare Function GetMenu Lib "user32" (ByVal hWnd As Long) As Long
Declare Function GetSubMenu Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long


Declare Function CreateMenu Lib "user32" () As Long
Declare Function CreatePopupMenu Lib "user32" () As Long

Type MENUITEMINFO
    cbSize As Long
    fMask As Long
    fType As Long
    fState As Long
    wID As Long
    hSubMenu As Long
    hbmpChecked As Long
    hbmpUnchecked As Long
    dwItemData As Long
    dwTypeData As String
    cch As Long
End Type

Declare Function InsertMenuItem Lib "user32" Alias "InsertMenuItemA" (hMenu As Long, uItem As Long, bypos As Boolean, NewMEnu As MENUITEMINFO) As Boolean
Declare Function GetMenuItemInfo Lib "user32" Alias "GetMenuItemInfoA" (ByVal hMenu As Long, _
  ByVal uItem As Long, ByVal fByPosition As Boolean, lpmii As MENUITEMINFO) As Boolean

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

    
