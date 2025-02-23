@echo off
setlocal

:: Define the app directories
set APP1_DIR=shared-micro-front-end-app
set APP2_DIR=userManagement
set APP3_DIR=dashboard
set APP4_DIR=footer
set APP5_DIR=header
set APP6_DIR=host

:: Define the log file
set LOG_FILE=build_and_run.log
echo Starting build and run process > %LOG_FILE%

:: Build and run each app
call :build_and_run "%APP1_DIR%" shared-micro-front-end-app
call :build_and_run "%APP2_DIR%" userManagement
call :build_and_run "%APP3_DIR%" dashboard
call :build_and_run "%APP4_DIR%" footer
call :build_and_run "%APP5_DIR%" header
call :build_and_run "%APP6_DIR%" host

:: End script
echo All apps have been built and started. Logs are saved in %LOG_FILE%.
exit /b

:build_and_run
:: Function to build and run an app
:: %1 - App directory
:: %2 - App name
echo -------------------------------------
echo Current directory: %CD%
echo Building and starting %2
cd %~1 || exit /b

echo Changed Directory: %CD%

echo Installing dependencies %2...
call npm install --force

echo Building %2...
call npm run build
if %errorlevel% neq 0 (
    echo Build failed for %2. Check logs for details. >> %LOG_FILE%
    exit /b
)

echo Starting %2...
start cmd /k "npm run start"
if %errorlevel% neq 0 (
    echo Failed to start %2. Check logs for details. >> %LOG_FILE%
    exit /b
)

cd ..
exit /b
