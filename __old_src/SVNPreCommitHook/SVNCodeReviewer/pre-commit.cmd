@echo off
SET SVN_LOOK="C:\Program Files\VisualSVN Server\bin\svnlook.exe"
SET SVN_STYLECOP="C:\Program Files\VisualSVN Server\svnstylecop\sourceCode\bin\Debug\SVNStyleCop.exe"

SET REV_OR_TRAN=transaction

IF "%3" == "test" SET REV_OR_TRAN=revision

%SVN_STYLECOP% -repository:%1 -%REV_OR_TRAN%:%2
IF %ERRORLEVEL% EQU 0 GOTO STYLECOP_OK
EXIT %ERRORLEVEL%

:STYLECOP_OK
%SVN_LOOK% log --%REV_OR_TRAN% %2 %1 | FindStr [a-zA-Z0-9]
IF %ERRORLEVEL% EQU 0 GOTO FINAL_OK
ECHO "Commit comments are required" >&2
EXIT -1

:FINAL_OK
EXIT 0
