:: powershell update 5.1 for windows 7
:: return %errorlevel%:
:: 		0 is present installed
::		1 installed
::		2 not support OS
::		3 other

@echo off
cls

:: check OS version: 6.1 - Windows7
for /f "tokens=2 delims=[]" %%i in ('ver') do (
   for /f "tokens=2,3 delims=. " %%a in ("%%i") do set version=%%a.%%b
)
if %version%==6.1 goto :#
exit /b 2

:#
:: check installed
wmic qfe list | find "KB3191566">NUL && (
	:: successfully
	exit /b 0
)

set app=Win7-KB3191566-x86
if exist %programfiles(x86)% set app=Win7AndW2K8R2-KB3191566-x64
set url=http://192.168.8.30/distrib/psh

if not exist "%temp%\%app%.zip" bitsadmin /transfer downPSH %url%/%app%.zip %temp%\%app%.zip
cd  %temp%
"%programfiles%"\7-Zip\7z.exe x %app%.zip -y
wusa "%temp%\%app%.msu" /quiet /norestart && exit /b 1

exit /b 3
