# Microsoft Developer Studio Project File - Name="pww" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=pww - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "pww.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "pww.mak" CFG="pww - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "pww - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "pww - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "pww - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "."
# PROP Intermediate_Dir "."
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Yu"stdafx.h" /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386 /out:"C:\MyFiles\Projects\dev\intrainter-bin\WWWRoot\main\pww\pww.exe"

!ELSEIF  "$(CFG)" == "pww - Win32 Debug"

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
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /I "..\..\COMMON\PUBLIC" /I "..\..\PL\PUBLIC" /I "..\..\PWW\PUBLIC" /I "C:\My3rdParty\CGIPP" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\string" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\nspr" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xpcom" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\necko" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\uriloader" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\gfx" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\gfxwin" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\widget" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\windowwatcher" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\layout" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\docshell" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\dom" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\webbrwsr" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\webshell" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\content" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\htmlparser" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\profdirserviceProvider" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\pref" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xpconnect" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xmlextras" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\webbrowserpersist" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\view" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\imglib2" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\locale" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\embed_base" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_X86_" /D "XP_WIN" /D "XP_WIN32" /D "NODEBUG" /U "NS_DEBUG" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 user32.lib xpcom.lib gkgfx.lib plds4.lib nspr4.lib cgipp.lib common.lib pl.lib profdirserviceprovider_s.lib /nologo /subsystem:console /debug /machine:I386 /nodefaultlib:"LIBCMTD.lib" /out:"C:\MyReleases\intrainter\dev\pww.exe" /pdbtype:sept /libpath:"..\..\BUILD\DEBUG" /libpath:"C:\My3rdParty\Cgipp\CGIPP\Debug" /libpath:"C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\lib"
# SUBTRACT LINK32 /pdb:none /nodefaultlib

!ENDIF 

# Begin Target

# Name "pww - Win32 Release"
# Name "pww - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\nsWebBrowserChrome.cpp
# End Source File
# Begin Source File

SOURCE=..\..\pl\src\rvDOMEventListener.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvFormWindow.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvMainWindow.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvMyMozApp.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvParentWindow.cpp
# End Source File
# Begin Source File

SOURCE=..\..\pl\src\rvRuleProcessor.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvWindowCreator.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvWinMain.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\public\nsWebBrowserChrome.h
# End Source File
# Begin Source File

SOURCE=..\public\resource.h
# End Source File
# Begin Source File

SOURCE=..\public\rvFormWindow.h
# End Source File
# Begin Source File

SOURCE=..\public\rvMainWindow.h
# End Source File
# Begin Source File

SOURCE=..\public\rvMyMozApp.h
# End Source File
# Begin Source File

SOURCE=..\public\rvParentWindow.h
# End Source File
# Begin Source File

SOURCE=..\public\rvWindowCreator.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=..\res\cursor1.cur
# End Source File
# Begin Source File

SOURCE=..\res\pww.rc
# End Source File
# End Group
# End Target
# End Project
