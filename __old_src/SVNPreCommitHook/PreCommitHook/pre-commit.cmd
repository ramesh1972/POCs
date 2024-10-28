@echo off
SET SVN_LOOK="C:\Program Files\VisualSVN Server\bin\svnlook.exe"
SET SVN_STYLECOP="D:\Trunk\SVNPreCommitHook\SVNCodeReviewer\bin\Debug\SVNStyleCop.exe"

SET REV_OR_TRAN=transaction

IF "%3" == "test" SET REV_OR_TRAN=revision

for /f %%i in ('%SVN_LOOK% author %1 --transaction %2') do set AUTHOR=%%i

%SVN_STYLECOP% repository %1 %REV_OR_TRAN% %2 author %AUTHOR%
IF %ERRORLEVEL% EQU 0 GOTO STYLECOP_OK
EXIT %ERRORLEVEL%

:STYLECOP_OK
%SVN_LOOK% log --%REV_OR_TRAN% %2 %1 | FindStr [a-zA-Z0-9]
IF %ERRORLEVEL% EQU 0 GOTO FINAL_OK
ECHO "Commit comments are required" >&2
EXIT -1

:FINAL_OK
EXIT 0
