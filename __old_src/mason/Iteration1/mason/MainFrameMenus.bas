Attribute VB_Name = "MainFrameMenus"

Sub AppendMenuItems()
    Dim hMenuBar As Long
    Dim hMenuItem As Long
    Dim hMenuSubItem As Long
    Dim hMenuPopup As Long
    Dim mID As Long
    Dim FlagStr As Long
    Dim FlagChecked As Long
    Dim FlagPos As Long
    Dim FlagSep As Long
    Dim FlagPopUp As Long
    Dim Flas As Long
    Dim SubFlag As Long
    Dim ChkFlag As Long
    
    FlagStr = 0
    FlagChecked = 8
    FlagPopUp = 16
    FlagPos = 1024
    FlagSep = 2048
    
    mID = 1000
    Flag = FlagStr
    hMenuBar = GetMenu(fMainForm.hWnd)
    
    ' Main Menu
    hMenuItem = GetSubMenu(hMenuBar, 0)
    
    ' Language Menu
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuItem, 25, Flag, hMenuPopup, "&Language")
    Flag = FlagPos Or FlagChecked
    Call InsertMenu(hMenuPopup, 0, Flag, mID + 3, "US English")

    ' Security
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuItem, 26, Flag, hMenuPopup, "&Security")
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 0, Flag, mID + 4, "Certificates")
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 1, Flag, mID + 4, "Security Levels")
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 2, Flag, mID + 4, "Licenses")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call InsertMenu(hMenuItem, 27, Flag, 0, "")

    ' Home Web
    hMenuItem = GetSubMenu(hMenuBar, 2)
    
    Flag = FlagPos
    Call InsertMenu(hMenuItem, 14, Flag, mID + 4, "Content Properties")
    Call InsertMenu(hMenuItem, 15, Flag, mID + 4, "Show Format Panel")
    
    Flag = FlagPos Or FlagSep
    Call InsertMenu(hMenuItem, 16, Flag, 0, "")
    
    ' Library
    hMenuItem = GetSubMenu(hMenuBar, 3)
    
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuItem, 2, Flag, hMenuPopup, "&Library Folders")
    
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 0, Flag, mID + 4, "Folder Properties")
    
    Flag = FlagPos Or FlagSep
    Call InsertMenu(hMenuPopup, 1, Flag, 0, "")
   
    Flag = FlagPos
    Call InsertMenu(hMenuPopup, 2, Flag, mID + 4, "Create Folder")
    Call InsertMenu(hMenuPopup, 3, Flag, mID + 4, "Open Folder")
    Call InsertMenu(hMenuPopup, 4, Flag, mID + 4, "Edit Folder")
    Call InsertMenu(hMenuPopup, 5, Flag, mID + 4, "Move Folder")
    Call InsertMenu(hMenuPopup, 7, Flag, mID + 4, "Delete Folder")
    
    ' Search Menu
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 4, Flag, hMenuPopup, "&Search")
    
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Search &Engines")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 5, "www.yahoo.com")
    Call AppendMenu(hMenuItem, Flag, mID + 6, "www.google.com")
    Call AppendMenu(hMenuItem, Flag, mID + 7, "www.msn.com")
    Call AppendMenu(hMenuItem, Flag, mID + 8, "www.lycos.com")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Select Search Engines")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Search Library")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 10, "All")
    Call AppendMenu(hMenuItem, Flag, mID + 11, "Selected Content")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 12, "Saved Web Pages")
    Call AppendMenu(hMenuItem, Flag, mID + 13, "Home Sites")
    Call AppendMenu(hMenuItem, Flag, mID + 14, "E-Mails")
    Call AppendMenu(hMenuItem, Flag, mID + 15, "E-Documents")
    Call AppendMenu(hMenuItem, Flag, mID + 16, "Media Albums")
    Call AppendMenu(hMenuItem, Flag, mID + 17, "Downloaded Files")
    Call AppendMenu(hMenuItem, Flag, mID + 18, "Local Drives")
    Call AppendMenu(hMenuItem, Flag, mID + 19, "Calendar")
    Call AppendMenu(hMenuItem, Flag, mID + 20, "Contacts")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Design Search")
    
    hMenuSubItem = CreatePopupMenu()
    Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "Merge In Engine")
    
    Flag = FlagStr
    Call AppendMenu(hMenuSubItem, Flag, mID + 21, "Start Merge")
    Call AppendMenu(hMenuSubItem, Flag, mID + 22, "Map Input Fields")
    Call AppendMenu(hMenuSubItem, Flag, mID + 23, "Map Results Fields")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 24, "Search Page")
    Call AppendMenu(hMenuItem, Flag, mID + 25, "Input Fields")
    Call AppendMenu(hMenuItem, Flag, mID + 26, "Results Fields")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 27, "Add Search Engines")
    Call AppendMenu(hMenuPopup, Flag, mID + 28, "Remove Search Engines")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 28, "Save Search Phrases")
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 29, "View Search Phrases")
    Call AppendMenu(hMenuPopup, Flag, mID + 31, "Edit Search Phrases")

    ' Messenger
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 6, Flag, hMenuPopup, "&Messenger")

    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 32, "Alerts On")
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 33, "Manage Alerts")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 60, "&StartUp Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 61, "&Messenger Servers")
    Call AppendMenu(hMenuPopup, Flag, mID + 61, "&Manage Logins")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 34, "View Online Contacts")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 35, "Set Online Status")
    Call AppendMenu(hMenuPopup, Flag, mID + 36, "View Online Contacts")
    Call AppendMenu(hMenuPopup, Flag, mID + 37, "Address Book")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 38, "Chat Room")
    Call AppendMenu(hMenuPopup, Flag, mID + 39, "Manage Chat Rooms")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 40, "Audio Room")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Audio Controls")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 41, "Volume Control")
    Call AppendMenu(hMenuItem, Flag, mID + 42, "Recording Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 43, "Audio Options")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 44, "Video Room")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Video Controls")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 45, "Rendering Options")
    Call AppendMenu(hMenuItem, Flag, mID + 46, "Capture Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 47, "Video Options")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 48, "&Scribble Pad")
    Call AppendMenu(hMenuPopup, Flag, mID + 49, "&Share Media")
    Call AppendMenu(hMenuPopup, Flag, mID + 50, "&Share Web Pages")
    Call AppendMenu(hMenuPopup, Flag, mID + 51, "&File Transfer")
    Call AppendMenu(hMenuPopup, Flag, mID + 52, "&Share Browser")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 53, "&Telephony")
    Call AppendMenu(hMenuPopup, Flag, mID + 54, "&Call Settings")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 55, "&Web Conference")
    Call AppendMenu(hMenuPopup, Flag, mID + 56, "&Call Settings")

    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Plan Conferences")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 57, "Manage")
    Call AppendMenu(hMenuItem, Flag, mID + 58, "Add Participants")
    Call AppendMenu(hMenuItem, Flag, mID + 59, "Add Agenda")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 62, "&Security Options")

    ' File Transfer
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 7, Flag, hMenuPopup, "&File Transfer")

    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Open FTP Sites")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "FTP Site1")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "FTP Site2")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Open Connection")
    
    Call AppendMenu(hMenuPopup, Flag, mID + 66, "Select Profiles")
    Call AppendMenu(hMenuPopup, Flag, mID + 67, "Disconnect")
    Call AppendMenu(hMenuPopup, Flag, mID + 68, "Close")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 69, "Session Profiles")
    Call AppendMenu(hMenuPopup, Flag, mID + 70, "Manage FTP Sites")
    Call AppendMenu(hMenuPopup, Flag, mID + 71, "Save FTP Site")
    Call AppendMenu(hMenuPopup, Flag, mID + 72, "View FTP Folders")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 73, "Manage Logins")
    Call AppendMenu(hMenuPopup, Flag, mID + 74, "Transfer Properties")
    Call AppendMenu(hMenuPopup, Flag, mID + 75, "Folder Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 76, "Display Options")

    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 77, "View Schedules")
    Call AppendMenu(hMenuPopup, Flag, mID + 78, "Schedular")
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Alerts On")

    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Download Sites")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 80, "Download Site1")
    Call AppendMenu(hMenuItem, Flag, mID + 81, "Download Site2")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 82, "View Download Sites")
    Call AppendMenu(hMenuPopup, Flag, mID + 83, "Manage Download Sites")
    Call AppendMenu(hMenuPopup, Flag, mID + 84, "Save Download Site")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "View Downloads Folder")
    Call AppendMenu(hMenuPopup, Flag, mID + 86, "Downloads Folder Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 87, "Downloads Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 88, "File Associations")

    ' Media Menu
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 8, Flag, hMenuPopup, "&Media")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "View Collection")
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "View Album")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Albums")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Create Album")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Edit Album")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Remove Album")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Album Properties")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Default Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Display Options")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Album Pages")

    Call AppendMenu(hMenuItem, Flag, mID + 63, "Create Album Page")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Edit Album Page")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Remove Album Page")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Page Properties")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Default Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Display Options")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Page Contents")

    Call AppendMenu(hMenuItem, Flag, mID + 63, "Create Album Content")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Edit Album Content")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Remove Album Content")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Content Properties")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Default Properties")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Display Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 63, "Design Album")
    Call AppendMenu(hMenuPopup, Flag, mID + 64, "Design Page")
    Call AppendMenu(hMenuPopup, Flag, mID + 64, "Design Content")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Information")
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Images")
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Audio Content")
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Video")
    Call AppendMenu(hMenuPopup, Flag, mID + 79, "Display Media Links")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Get Images")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Image Control")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Size And Resolution")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Render Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "View Image Editors")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Image Formats")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Take Snapshot")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Get Audio")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Audio Control")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Volume Control")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Graphic Equilizer")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "Render Options")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Audio Players")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Encoders/Decoders")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Audio Devices")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Record Audio")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Get Video")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "&Video Control")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Render Options")
    Call AppendMenu(hMenuItem, Flag, mID + 63, "Capture Options")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuItem, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Video Players")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Encoders/Decoders")
    Call AppendMenu(hMenuItem, Flag, mID + 64, "View Video Devices")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Record Video")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Get Media Links")
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Save Media Link")
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Network Options")

    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Performance Options")
    
    ' Separator
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Zoom Window")
    Call AppendMenu(hMenuPopup, Flag, mID + 65, "Search Media")
    
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 9, Flag, hMenuPopup, "&e-Documents")
        
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "View Collection")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Collection")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "New Document")
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "New From Templates")
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Template1")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Template2")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Open Document")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Lock Document")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Unlock Document")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Save Document")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Close Document")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Display Options")
           Flag = FlagStr
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Full")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Pages")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Document Properties")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Document Ruler")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Page Number")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Header")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Footer")
           Call AppendMenu(hMenuItem, Flag, mID + 9, "Wrap Text")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Select")
            Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "All")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Page")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Content At Cursor")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Insert")
            Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Page")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Slide")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Grid")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Table")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Line Break")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Text")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Document Page Link")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Hyper Link")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Bullets")
    
        Flag = FlagPos Or FlagPopUp
        hMenuSubItem = CreatePopupMenu()
            Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "Standard")
                Flag = FlagStr
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Cover")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Introduction")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Summary")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Prelude")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Contents")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Index")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Appendix")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Margin")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Page Numbers")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Borders")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Header")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Footer")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Bibliography")
    
        Flag = FlagPos Or FlagPopUp
        hMenuSubItem = CreatePopupMenu()
            Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "Content")
                Flag = FlagStr
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Date And Time")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Special characters")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Formatted Strings")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Currency")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Formulas")
    
        Flag = FlagPos Or FlagPopUp
        hMenuSubItem = CreatePopupMenu()
            Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "Media")
                Flag = FlagStr
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Picture")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Audio")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Video")
    
        Flag = FlagPos Or FlagPopUp
        hMenuSubItem = CreatePopupMenu()
            Call AppendMenu(hMenuItem, Flag, hMenuSubItem, "From Templates")
                Flag = FlagStr
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Template1")
            Call AppendMenu(hMenuSubItem, Flag, mID + 9, "Template2")
    
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Format")
            Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Font")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Color")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Align")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Spacing")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Border")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "BackGround")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Document Properties")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Document Language")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Templates")
            Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "View")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Create")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Edit")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Save")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Remove")
        
        Flag = FlagPos Or FlagSep
        Call AppendMenu(hMenuItem, Flag, 0, "")
        Flag = FlagPos
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Load")
        
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Style Sheets")
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Select")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "View")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Create")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Edit")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Save")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Remove")
        
        Flag = FlagPos Or FlagSep
        Call AppendMenu(hMenuItem, Flag, 0, "")
        Flag = FlagPos
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Load")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Find")
        
    ' Calendar
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 10, Flag, hMenuPopup, "&Calendar")

    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Display Calendar")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Display Clock")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Display Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Show Planner")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Show Plans")
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "All")
        
        Flag = FlagPos Or FlagSep
        Call AppendMenu(hMenuItem, Flag, 0, "")
    
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Today")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "This Week")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Past Week")
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Next Week")
    
        Flag = FlagPos Or FlagSep
        Call AppendMenu(hMenuItem, Flag, 0, "")
    
        Flag = FlagStr
        Call AppendMenu(hMenuItem, Flag, mID + 9, "Select Time Period")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "View Plan")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "New Plan")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Plan")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Plan")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "View Task Folder")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "New Task Folder")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Task Folder")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Task Folder")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "View Task")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "New Task")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Task")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Task")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Set Alerts")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Alerts On")
    
    ' Services Menu
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 11, Flag, hMenuPopup, "&Services")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Open Services Catalog")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Edit Catalog")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Add Service Link")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Serice Link")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Save Service Link")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Add Service Type")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Remove Serice Type")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "News Groups")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Internet Directories")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "IRC Chat Rooms")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "TV Channels")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Radio Channels")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Streaming Media Sites")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Blogs")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "RSS Feeds")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Online Games")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Information Catalog")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Product Catalog")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Download Services Catalog")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Upload Service Link")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Design Service Page")
    Call AppendMenu(hMenuPopup, Flag, mID + 9, "Add To Home Site")
    
    ' Options
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 12, Flag, hMenuPopup, "&Options")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Startup Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Network Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Servers Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Login Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Exit Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Links Panel Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Browser Panel Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Library Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Search Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Audio Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Video Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "EMail Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Messenger Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "FTP Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Schedule Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Publish Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Themes Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Setup Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Status Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Messages Options")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Security Options")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Performance Options")
    
    ' Panels
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 13, Flag, hMenuPopup, "&Panels")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Application Themes")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Theme1")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Theme2")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Theme3")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Openned Panels")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel1")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel2")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel3")
    
    Flag = FlagPos Or FlagPopUp
    hMenuItem = CreatePopupMenu()
    Call AppendMenu(hMenuPopup, Flag, hMenuItem, "Recently Closed Panels")
    
    Flag = FlagStr
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel1")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel2")
    Call AppendMenu(hMenuItem, Flag, mID + 85, "Panel3")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Undo Last Action")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Select All")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Select At Cursor")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Copy Selected")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Cut Selected")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Paste")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Paste (With Dependencies)")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Find")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Replace")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Minimize Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Maximize Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Restore Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Hide Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Close Panel")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Lock Panel")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Lock All Panels")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Tile Panels Horizontal")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Tile Panels Vertical")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Dock Panels")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Best Fit")
    
    Flag = FlagPos Or FlagPopUp
    hMenuPopup = CreatePopupMenu()
    Call InsertMenu(hMenuBar, 14, Flag, hMenuPopup, "&End")
    
    Flag = FlagStr Or ChkFlag
    Call AppendMenu(hMenuPopup, Flag, mID + 28, "Save Settings On Exit")
    
    Flag = FlagPos Or FlagSep
    Call AppendMenu(hMenuPopup, Flag, 0, "")
    
    Flag = FlagStr
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "LogOff")
    Call AppendMenu(hMenuPopup, Flag, mID + 85, "Exit")
    
End Sub

