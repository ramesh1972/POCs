# Microsoft Developer Studio Project File - Name="common" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=common - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "common.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "common.mak" CFG="common - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "common - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "common - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "common - Win32 Release"

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
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "common - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /I "..\..\COMMON\PUBLIC" /I "..\..\PL\PUBLIC" /I "..\..\PWW\PUBLIC" /I "C:\My3rdParty\CGIPP" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\string" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\nspr" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xpcom" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\necko" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\uriloader" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\gfx" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\gfxwin" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\widget" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\windowwatcher" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\layout" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\docshell" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\dom" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\webbrwsr" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\webshell" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\content" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\htmlparser" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\profdirserviceProvider" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\pref" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xpconnect" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\xmlextras" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\webbrowserpersist" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\view" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\imglib2" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\locale" /I "C:\My3rdParty\mozilla\mozilla\obj-i586-pc-msvc\dist\include\embed_base" /I "C:\My3rdParty\mysqlpp\include" /I "C:\My3rdParty\mysqlpp\mysql\include" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_X86_" /D "XP_WIN" /D "XP_WIN32" /U "NS_DEBUG" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:"..\..\build\Debug\common.lib"

!ENDIF 

# Begin Target

# Name "common - Win32 Release"
# Name "common - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\rvDB.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvFileLogger.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvHTMLElement.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvJSdb.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvMessageList.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvMessages.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvOpenURL.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rvXmlDocument.cpp
# End Source File
# Begin Source File

SOURCE=..\src\utils.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\public\rvDB.h
# End Source File
# Begin Source File

SOURCE=..\public\rvFileLogger.h
# End Source File
# Begin Source File

SOURCE=..\public\rvHTMLElement.h
# End Source File
# Begin Source File

SOURCE=..\public\rvJSdb.h
# End Source File
# Begin Source File

SOURCE=..\public\rvMessageList.h
# End Source File
# Begin Source File

SOURCE=..\public\rvMessages.h
# End Source File
# Begin Source File

SOURCE=..\public\rvOpenURL.h
# End Source File
# Begin Source File

SOURCE=..\public\rvXmlDocument.h
# End Source File
# Begin Source File

SOURCE=..\public\rvXPCOMIDs.h
# End Source File
# Begin Source File

SOURCE=..\public\utils.h
# End Source File
# End Group
# End Target
# End Project
