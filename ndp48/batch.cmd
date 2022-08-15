@echo off
cls
setlocal

:: incoming parameter ip
set ip=%1
:: execution from the system user
psexec \\%ip% -h -s -c -f ndp.cmd
set comment=%errorlevel%

if %comment%==0 set flag=yes
if %comment%==1 set flag=yes
if %comment%==2 set flag=any
if %comment%==3 set flag=error

:: report generation
set outline=%ip%;1;%flag%;%comment%;
:: record report
echo %outline%>> %~dp0list_.csv

endlocal
exit
