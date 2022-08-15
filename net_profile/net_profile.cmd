:: network profile private enable, only for win 7
@echo off
setLocal enableExtensions enabledelayedexpansion
cls

:: search OS version
for /f "tokens=2 delims=[]" %%i in ('ver') do (
   for /f "tokens=2,3 delims=. " %%a in ("%%i") do set version=%%a.%%b)

if %version%==6.1 goto :#
exit /b 2
:#
:: path profile
set scrub=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles
:: stampdatatime
set stamp=0
:: path search
set target=0
:: search all profiles in search data last connect
for /f "delims=" %%a in ('reg query "%scrub%" /S') do (
	
	echo %%a | find "%scrub%" && ( set str=%%a )
	
	for /f "tokens=1-3" %%b in ("%%a") do (
	
		echo %%b | find "DateLastConnected" && (
			echo =%%d
			if %%d gtr !stamp! ( 
				set stamp=%%d
				set target=!str!
			)	
		)
	)
)
:: current setup
for /f "tokens=3" %%e in ('reg query "!target!" /v Category') do set "param=%%e"
:: enable private, if different
if !param! neq 0x1 ( reg add "!target!" /v Category /t REG_DWORD /d 1 /f
	exit /b 1
)

exit /b 0
