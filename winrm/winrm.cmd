:: winRM enable for win10 win7 win 8
:: %errorlevel% 0 - success, 2 - not support, * - error not known
@echo off
cls

:: search OS version
:: version: 5.1 - xp | 6.1 - Windows7 | 10.0 - Windows10
for /f "tokens=2 delims=[]" %%i in ('ver') do (
   for /f "tokens=2,3 delims=. " %%a in ("%%i") do set version=%%a.%%b)

if %version%==10.0 goto :#
if %version%==6.0 goto #
if %version%==6.1 goto :#
if %version%==5.1 echo win XP not support

exit /b 2

:#
:: enable winrm
powershell.exe -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command Enable-PSRemoting -Force

exit /b 0
