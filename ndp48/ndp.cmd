
:: net framework 4.8 install for win7
:: return %errorlevel%:
:: 		0 is present installed
::		1 installed
::		2 not support OS
::		3 error
@echo off
cls

:: check OS version: 6.1 - Windows7
for /f "tokens=2 delims=[]" %%i in ('ver') do (
   for /f "tokens=2,3 delims=. " %%a in ("%%i") do set version=%%a.%%b
)
if %version%==6.1 goto :#
exit /b 2

:#
set app=NDP48-Slim-x86-x64-ENU.exe
set url=http://192.168.8.30/distrib/net

:: check installed
wmic product where "Name like '%%4.8'" get name | find "Framework 4.8" && ( exit /b ) || (
	:: if non installed, download and install
	if not exist "%temp%\%app%" bitsadmin /transfer downNET %url%/%app% %temp%\%app%
	%temp%\%app% /ai /gm2 && exit /b 1
)
exit /b 4
