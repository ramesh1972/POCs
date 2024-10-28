# Microsoft Developer Studio Generated NMAKE File, Based on MDebug.dsp
!IF "$(CFG)" == ""
CFG=MDebug - Win32 Debug
!MESSAGE No configuration specified. Defaulting to MDebug - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "MDebug - Win32 Release" && "$(CFG)" != "MDebug - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
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
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "MDebug - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\MDebug.exe"


CLEAN :
	-@erase "$(INTDIR)\JSConsole.obj"
	-@erase "$(INTDIR)\nsBaseDialog.obj"
	-@erase "$(INTDIR)\nsBeOSMain.obj"
	-@erase "$(INTDIR)\nsBrowserWindow.obj"
	-@erase "$(INTDIR)\nsButton.obj"
	-@erase "$(INTDIR)\nsCheckButton.obj"
	-@erase "$(INTDIR)\nsEditorMode.obj"
	-@erase "$(INTDIR)\nsFindDialog.obj"
	-@erase "$(INTDIR)\nsImageInspectorDialog.obj"
	-@erase "$(INTDIR)\nsLabel.obj"
	-@erase "$(INTDIR)\nsMacMain.obj"
	-@erase "$(INTDIR)\nsOS2Main.obj"
	-@erase "$(INTDIR)\nsPhMain.obj"
	-@erase "$(INTDIR)\nsPhMenu.obj"
	-@erase "$(INTDIR)\nsPrintSetupDialog.obj"
	-@erase "$(INTDIR)\nsTableInspectorDialog.obj"
	-@erase "$(INTDIR)\nsTextHelper.obj"
	-@erase "$(INTDIR)\nsTextWidget.obj"
	-@erase "$(INTDIR)\nsThrobber.obj"
	-@erase "$(INTDIR)\nsViewerApp.obj"
	-@erase "$(INTDIR)\nsWebBrowserChrome.obj"
	-@erase "$(INTDIR)\nsWebCrawler.obj"
	-@erase "$(INTDIR)\nsWidgetSupport.obj"
	-@erase "$(INTDIR)\nsWindowCreator.obj"
	-@erase "$(INTDIR)\nsWinMain.obj"
	-@erase "$(INTDIR)\nsXPBaseWindow.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(OUTDIR)\MDebug.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /Fp"$(INTDIR)\MDebug.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
MTL_PROJ=/nologo /D "NDEBUG" /mktyplib203 /win32 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\MDebug.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /incremental:no /pdb:"$(OUTDIR)\MDebug.pdb" /machine:I386 /out:"$(OUTDIR)\MDebug.exe" 
LINK32_OBJS= \
	"$(INTDIR)\nsXPBaseWindow.obj" \
	"$(INTDIR)\JSConsole.obj" \
	"$(INTDIR)\nsBaseDialog.obj" \
	"$(INTDIR)\nsBeOSMain.obj" \
	"$(INTDIR)\nsBrowserWindow.obj" \
	"$(INTDIR)\nsEditorMode.obj" \
	"$(INTDIR)\nsFindDialog.obj" \
	"$(INTDIR)\nsImageInspectorDialog.obj" \
	"$(INTDIR)\nsMacMain.obj" \
	"$(INTDIR)\nsOS2Main.obj" \
	"$(INTDIR)\nsPhMain.obj" \
	"$(INTDIR)\nsPhMenu.obj" \
	"$(INTDIR)\nsPrintSetupDialog.obj" \
	"$(INTDIR)\nsTableInspectorDialog.obj" \
	"$(INTDIR)\nsThrobber.obj" \
	"$(INTDIR)\nsViewerApp.obj" \
	"$(INTDIR)\nsWebBrowserChrome.obj" \
	"$(INTDIR)\nsWebCrawler.obj" \
	"$(INTDIR)\nsWidgetSupport.obj" \
	"$(INTDIR)\nsWindowCreator.obj" \
	"$(INTDIR)\nsWinMain.obj" \
	"$(INTDIR)\nsButton.obj" \
	"$(INTDIR)\nsCheckButton.obj" \
	"$(INTDIR)\nsLabel.obj" \
	"$(INTDIR)\nsTextHelper.obj" \
	"$(INTDIR)\nsTextWidget.obj"

"$(OUTDIR)\MDebug.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "MDebug - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : "$(OUTDIR)\MDebug.exe"


CLEAN :
	-@erase "$(INTDIR)\JSConsole.obj"
	-@erase "$(INTDIR)\nsBaseDialog.obj"
	-@erase "$(INTDIR)\nsBeOSMain.obj"
	-@erase "$(INTDIR)\nsBrowserWindow.obj"
	-@erase "$(INTDIR)\nsButton.obj"
	-@erase "$(INTDIR)\nsCheckButton.obj"
	-@erase "$(INTDIR)\nsEditorMode.obj"
	-@erase "$(INTDIR)\nsFindDialog.obj"
	-@erase "$(INTDIR)\nsImageInspectorDialog.obj"
	-@erase "$(INTDIR)\nsLabel.obj"
	-@erase "$(INTDIR)\nsMacMain.obj"
	-@erase "$(INTDIR)\nsOS2Main.obj"
	-@erase "$(INTDIR)\nsPhMain.obj"
	-@erase "$(INTDIR)\nsPhMenu.obj"
	-@erase "$(INTDIR)\nsPrintSetupDialog.obj"
	-@erase "$(INTDIR)\nsTableInspectorDialog.obj"
	-@erase "$(INTDIR)\nsTextHelper.obj"
	-@erase "$(INTDIR)\nsTextWidget.obj"
	-@erase "$(INTDIR)\nsThrobber.obj"
	-@erase "$(INTDIR)\nsViewerApp.obj"
	-@erase "$(INTDIR)\nsWebBrowserChrome.obj"
	-@erase "$(INTDIR)\nsWebCrawler.obj"
	-@erase "$(INTDIR)\nsWidgetSupport.obj"
	-@erase "$(INTDIR)\nsWindowCreator.obj"
	-@erase "$(INTDIR)\nsWinMain.obj"
	-@erase "$(INTDIR)\nsXPBaseWindow.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(OUTDIR)\MDebug.exe"
	-@erase "$(OUTDIR)\MDebug.ilk"
	-@erase "$(OUTDIR)\MDebug.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /MLd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /Fp"$(INTDIR)\MDebug.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 
MTL_PROJ=/nologo /D "_DEBUG" /mktyplib203 /win32 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\MDebug.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /incremental:yes /pdb:"$(OUTDIR)\MDebug.pdb" /debug /machine:I386 /out:"$(OUTDIR)\MDebug.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\nsXPBaseWindow.obj" \
	"$(INTDIR)\JSConsole.obj" \
	"$(INTDIR)\nsBaseDialog.obj" \
	"$(INTDIR)\nsBeOSMain.obj" \
	"$(INTDIR)\nsBrowserWindow.obj" \
	"$(INTDIR)\nsEditorMode.obj" \
	"$(INTDIR)\nsFindDialog.obj" \
	"$(INTDIR)\nsImageInspectorDialog.obj" \
	"$(INTDIR)\nsMacMain.obj" \
	"$(INTDIR)\nsOS2Main.obj" \
	"$(INTDIR)\nsPhMain.obj" \
	"$(INTDIR)\nsPhMenu.obj" \
	"$(INTDIR)\nsPrintSetupDialog.obj" \
	"$(INTDIR)\nsTableInspectorDialog.obj" \
	"$(INTDIR)\nsThrobber.obj" \
	"$(INTDIR)\nsViewerApp.obj" \
	"$(INTDIR)\nsWebBrowserChrome.obj" \
	"$(INTDIR)\nsWebCrawler.obj" \
	"$(INTDIR)\nsWidgetSupport.obj" \
	"$(INTDIR)\nsWindowCreator.obj" \
	"$(INTDIR)\nsWinMain.obj" \
	"$(INTDIR)\nsButton.obj" \
	"$(INTDIR)\nsCheckButton.obj" \
	"$(INTDIR)\nsLabel.obj" \
	"$(INTDIR)\nsTextHelper.obj" \
	"$(INTDIR)\nsTextWidget.obj"

"$(OUTDIR)\MDebug.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("MDebug.dep")
!INCLUDE "MDebug.dep"
!ELSE 
!MESSAGE Warning: cannot find "MDebug.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "MDebug - Win32 Release" || "$(CFG)" == "MDebug - Win32 Debug"
SOURCE=.\viewer\windows\nsButton.cpp

"$(INTDIR)\nsButton.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\windows\nsCheckButton.cpp

"$(INTDIR)\nsCheckButton.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\windows\nsLabel.cpp

"$(INTDIR)\nsLabel.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\windows\nsTextHelper.cpp

"$(INTDIR)\nsTextHelper.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\windows\nsTextWidget.cpp

"$(INTDIR)\nsTextWidget.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\JSConsole.cpp

"$(INTDIR)\JSConsole.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsBaseDialog.cpp

"$(INTDIR)\nsBaseDialog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsBeOSMain.cpp

"$(INTDIR)\nsBeOSMain.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsBrowserWindow.cpp

"$(INTDIR)\nsBrowserWindow.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsEditorMode.cpp

"$(INTDIR)\nsEditorMode.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsFindDialog.cpp

"$(INTDIR)\nsFindDialog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsImageInspectorDialog.cpp

"$(INTDIR)\nsImageInspectorDialog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsMacMain.cpp

"$(INTDIR)\nsMacMain.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsOS2Main.cpp

"$(INTDIR)\nsOS2Main.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsPhMain.cpp

"$(INTDIR)\nsPhMain.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsPhMenu.cpp

"$(INTDIR)\nsPhMenu.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsPrintSetupDialog.cpp

"$(INTDIR)\nsPrintSetupDialog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsTableInspectorDialog.cpp

"$(INTDIR)\nsTableInspectorDialog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsThrobber.cpp

"$(INTDIR)\nsThrobber.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsViewerApp.cpp

"$(INTDIR)\nsViewerApp.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsWebBrowserChrome.cpp

"$(INTDIR)\nsWebBrowserChrome.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsWebCrawler.cpp

"$(INTDIR)\nsWebCrawler.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsWidgetSupport.cpp

"$(INTDIR)\nsWidgetSupport.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsWindowCreator.cpp

"$(INTDIR)\nsWindowCreator.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsWinMain.cpp

"$(INTDIR)\nsWinMain.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=.\viewer\nsXPBaseWindow.cpp

"$(INTDIR)\nsXPBaseWindow.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

