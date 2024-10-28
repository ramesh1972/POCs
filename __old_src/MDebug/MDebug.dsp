# Microsoft Developer Studio Project File - Name="MDebug" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=MDebug - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "MDebug.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "MDebug.mak" CFG="MDebug - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "MDebug - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "MDebug - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "MDebug - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "_X86_" /D "XP_WIN" /D "XP_WIN32" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib widget_windows.lib nspr4.lib basedocshell_s.lib uriloaderbase_s.lib neckobase_s.lib neckodns_s.lib neckosocket_s.lib mozutil_s.lib unicharutil_s.lib gfxshared_s.lib xpcom.lib string_s.lib embed_base_s.lib jsdombase_s.lib jsdomevents_s.lib nslocale_s.lib htmleditor_s.lib nswebbrowser_s.lib viewer_windows_s.lib prefetch_s.lib windowwatcher_s.lib xpcomcomponents_s.lib gkgfx.lib xpwidgets_s.lib widgetsupport_s.lib plc4.lib plds4.lib js3250.lib /nologo /subsystem:windows /machine:I386 /nodefaultlib:"LIBC.lib"

!ELSEIF  "$(CFG)" == "MDebug - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /W3 /Gm /GX /ZI /Od /I "c:\myfiles\projects\analyst\mdebug\viewer\public" /I "C:\mozilla\mozilla\nsprpub\pr\include" /I "C:\mozilla\mozilla\obj-i586-pc-msvc\dom\public\idl\core\_xpidlgen" /I "C:\mozilla\mozilla\xpcom\string\public" /I "C:\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xpcom\\" /I "C:\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xpcom\base" /I ".\widget" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "_X86_" /D "XP_WIN" /D "XP_WIN32" /D "USE_LOCAL_WIDGETS" /FR /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib widget_windows.lib nspr4.lib basedocshell_s.lib uriloaderbase_s.lib neckobase_s.lib neckodns_s.lib neckosocket_s.lib mozutil_s.lib unicharutil_s.lib gfxshared_s.lib xpcom.lib string_s.lib embed_base_s.lib jsdombase_s.lib jsdomevents_s.lib nslocale_s.lib htmleditor_s.lib nswebbrowser_s.lib viewer_windows_s.lib prefetch_s.lib windowwatcher_s.lib xpcomcomponents_s.lib gkgfx.lib xpwidgets_s.lib widgetsupport_s.lib plc4.lib plds4.lib js3250.lib /nologo /subsystem:windows /debug /machine:I386 /nodefaultlib:"libcd.lib" /pdbtype:sept
# SUBTRACT LINK32 /nodefaultlib

!ENDIF 

# Begin Target

# Name "MDebug - Win32 Release"
# Name "MDebug - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "windows"

# PROP Default_Filter "*.cpp;*.h"
# Begin Source File

SOURCE=.\viewer\windows\nsButton.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsButton.h
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsCheckButton.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsCheckButton.h
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsdefs.h
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsLabel.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsLabel.h
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsTextHelper.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsTextHelper.h
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsTextWidget.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\windows\nsTextWidget.h
# End Source File
# Begin Source File

SOURCE=.\viewer\resources.h
# End Source File
# End Group
# Begin Source File

SOURCE=.\viewer\JSConsole.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsBaseDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsBrowserWindow.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsEditorMode.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsFindDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsImageInspectorDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsPrintSetupDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsTableInspectorDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsThrobber.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsViewerApp.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsWebBrowserChrome.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsWebCrawler.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsWidgetSupport.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsWindowCreator.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsWinMain.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer\nsXPBaseWindow.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\viewer\public\nsIButton.h
# End Source File
# Begin Source File

SOURCE=.\viewer\public\nsICheckButton.h
# End Source File
# Begin Source File

SOURCE=.\viewer\public\nsILabel.h
# End Source File
# Begin Source File

SOURCE=.\viewer\public\nsITextWidget.h
# End Source File
# Begin Source File

SOURCE=.\viewer\public\nsIWindowListener.h
# End Source File
# Begin Source File

SOURCE=.\viewer\public\nsIXPBaseWindow.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\viewer\viewer.rc
# End Source File
# End Group
# Begin Source File

SOURCE=.\viewer\viewer.aps
# End Source File
# End Target
# End Project
