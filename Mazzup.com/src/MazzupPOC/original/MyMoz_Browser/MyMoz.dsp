# Microsoft Developer Studio Project File - Name="MyMoz" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=MyMoz - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "MyMoz.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "MyMoz.mak" CFG="MyMoz - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "MyMoz - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "MyMoz - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "MyMoz - Win32 Release"

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
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /Gi /GX /O1 /D "NDEBUG" /D "_NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_X86_" /D "XP_WIN" /D "XP_WIN32" /U "NS_DEBUG" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 user32.lib gdi32.lib xpcom.lib gkgfx.lib plds4.lib nspr4.lib profdirserviceprovider_s.lib /nologo /subsystem:console /pdb:none /machine:I386 /out:"C:\Mozilla\Mozilla\obj-i586-pc-msvc\dist\bin\MyMozR.exe"
# SUBTRACT LINK32 /debug /nodefaultlib

!ELSEIF  "$(CFG)" == "MyMoz - Win32 Debug"

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
# ADD CPP /nologo /MDd /W3 /Gm /Gi /GX /ZI /Od /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_X86_" /D "XP_WIN" /D "XP_WIN32" /D "NS_BUILD_REFCNT_LOGGING" /U "NS_DEBUG" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 user32.lib gdi32.lib xpcom.lib gkgfx.lib plds4.lib nspr4.lib profdirserviceprovider_s.lib cgipp.lib /nologo /subsystem:console /debug /machine:I386 /out:"C:\Mozilla\Mozilla\obj-i586-pc-msvc\dist\bin\MyMoz.exe" /pdbtype:sept /out:"/Mozilla/Mozilla/obj-i586-pc-msvc/dist/bin/MyMoz.exe"

!ENDIF 

# Begin Target

# Name "MyMoz - Win32 Release"
# Name "MyMoz - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\nsWebBrowserChrome.cpp

!IF  "$(CFG)" == "MyMoz - Win32 Release"

!ELSEIF  "$(CFG)" == "MyMoz - Win32 Debug"

# ADD CPP /Yc

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\rvDOMEventListener.cpp
# End Source File
# Begin Source File

SOURCE=.\rvFormWindow.cpp
# End Source File
# Begin Source File

SOURCE=.\rvMainWindow.cpp
# End Source File
# Begin Source File

SOURCE=.\rvMyMozApp.cpp
# End Source File
# Begin Source File

SOURCE=.\rvOpenURL.cpp
# End Source File
# Begin Source File

SOURCE=.\rvParentWindow.cpp
# End Source File
# Begin Source File

SOURCE=.\rvRuleBase.cpp
# End Source File
# Begin Source File

SOURCE=.\rvRuleCreator.cpp
# End Source File
# Begin Source File

SOURCE=.\rvRuleProcessor.cpp
# End Source File
# Begin Source File

SOURCE=.\rvRuleRenderer.cpp
# End Source File
# Begin Source File

SOURCE=.\rvRulesCollection.cpp
# End Source File
# Begin Source File

SOURCE=.\rvRulesDefines.cpp
# End Source File
# Begin Source File

SOURCE=.\rvRuleSetProcessor.cpp
# End Source File
# Begin Source File

SOURCE=.\rvRulesProcessor.cpp
# End Source File
# Begin Source File

SOURCE=.\rvWindowCreator.cpp
# End Source File
# Begin Source File

SOURCE=.\rvWinMain.cpp
# End Source File
# Begin Source File

SOURCE=.\rvXmlDocument.cpp
# End Source File
# Begin Source File

SOURCE=.\viewer.rc
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\nsWebBrowserChrome.h
# End Source File
# Begin Source File

SOURCE=.\nsWidgetSupport.h
# End Source File
# Begin Source File

SOURCE=.\resource.h
# End Source File
# Begin Source File

SOURCE=.\rvDOMEventListener.h
# End Source File
# Begin Source File

SOURCE=.\rvFileLogger.h
# End Source File
# Begin Source File

SOURCE=.\rvFormWindow.h
# End Source File
# Begin Source File

SOURCE=.\rvMainWindow.h
# End Source File
# Begin Source File

SOURCE=.\rvMyMozApp.h
# End Source File
# Begin Source File

SOURCE=.\rvOpenURL.h
# End Source File
# Begin Source File

SOURCE=.\rvParentWindow.h
# End Source File
# Begin Source File

SOURCE=.\rvRuleBase.h
# End Source File
# Begin Source File

SOURCE=.\rvRuleCreator.h
# End Source File
# Begin Source File

SOURCE=.\rvRuleProcessor.h
# End Source File
# Begin Source File

SOURCE=.\rvRuleRenderer.h
# End Source File
# Begin Source File

SOURCE=.\rvRuleResult.h
# End Source File
# Begin Source File

SOURCE=.\rvRulesCollection.h
# End Source File
# Begin Source File

SOURCE=.\rvRulesDefines.h
# End Source File
# Begin Source File

SOURCE=.\rvRuleSetProcessor.h
# End Source File
# Begin Source File

SOURCE=.\rvRulesProcessor.h
# End Source File
# Begin Source File

SOURCE=.\rvWindowCreator.h
# End Source File
# Begin Source File

SOURCE=.\rvXmlDocument.h
# End Source File
# Begin Source File

SOURCE=.\rvXPCOMIDs.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\cursor1.cur
# End Source File
# End Group
# End Target
# End Project
