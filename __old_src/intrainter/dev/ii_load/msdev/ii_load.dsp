# Microsoft Developer Studio Project File - Name="ii_load" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=ii_load - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "ii_load.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ii_load.mak" CFG="ii_load - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ii_load - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ii_load - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "ii_load - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386

!ELSEIF  "$(CFG)" == "ii_load - Win32 Debug"

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
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /I "..\..\COMMON\PUBLIC" /I "..\..\PL\PUBLIC" /I "..\..\PWW\PUBLIC" /I "C:\My3rdParty\CGIPP" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\string" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\nspr" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xpcom" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\necko" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\uriloader" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\gfx" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\gfxwin" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\widget" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\windowwatcher" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\layout" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\docshell" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\dom" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\webbrwsr" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\webshell" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\content" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\htmlparser" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\profdirserviceProvider" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\pref" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xpconnect" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xmlextras" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\webbrowserpersist" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\view" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\imglib2" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\locale" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\embed_base" /I "C:\My3rdParty\cgipp\\" /I "C:\My3rdParty\mysqlpp\include" /I "C:\My3rdParty\mysqlpp\mysql\include" /D "_DEBUG" /D "WIN32" /D "_MBCS" /D "_X86_" /D "XP_WIN" /D "XP_WIN32" /D "_CONSOLE" /U "NS_DEBUG" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 user32.lib libmysql.lib mysql++.lib xpcom.lib gkgfx.lib plds4.lib nspr4.lib common.lib profdirserviceprovider_s.lib cgipp.lib /nologo /subsystem:console /debug /machine:I386 /out:"C:\MyReleases\intrainter\dev\ii-load.exe" /pdbtype:sept /libpath:"..\..\BUILD\DEBUG" /libpath:"C:\My3rdParty\Cgipp\CGIPP\Debug" /libpath:"C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\lib" /libpath:"C:\My3rdParty\mysqlpp\lib" /libpath:"C:\My3rdParty\mysqlpp\mysql\lib"
# SUBTRACT LINK32 /nodefaultlib

!ENDIF 

# Begin Target

# Name "ii_load - Win32 Release"
# Name "ii_load - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\component.cpp
# End Source File
# Begin Source File

SOURCE=..\src\main.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\component.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
