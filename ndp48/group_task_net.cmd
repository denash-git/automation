:: версия многопоточного выполнения и асинхронной записи резултата в list_.csv
@echo off
setlocal enabledelayedexpansion
cls
cd %~dp0

:: формирование заголовка временный файл
echo ip_addr;flag_ping;flag_task;comment>> %~dp0list_.csv

:: перебор каждой строки в файле, кроме первой
for /f "tokens=* skip=1" %%a IN (%~dp0list.csv) DO (

	:: дробление строки на значения
	for /f "tokens=1-3* delims=;" %%b IN ("%%a") DO (
		::первичные значения строки
		set ip=%%b
		set ping=%%c
		set flag=%%d
		set comment=%%e
		set acc=0
		::проверка необходимости выполнения задачи
		if !flag!==0 (
			:: доступен ли хост?
			for /f "tokens=7" %%i IN ('ping -n 1 %%b^|find /I "TTL"') DO (
				:: =1 успешный ping
				set acc=1
			)
			
			::выполнение задачи, если хост доступен
			if !acc!==1 (
				call :net
				set ping=1
			)
		)
		
		if !acc!==0 (
			set outline=!ip!;!ping!;!flag!;!comment!
			echo !outline!
			echo !outline!>> %~dp0list_.csv
		)
	)
)
::переименование
::del %~dp0list.csv
::ren %~dp0list_.csv list.csv
 
exit /b

::++++++++++++++++++++++++++++++  modul +++++++++++++++++++++++++++++++++++++++++++++
:net

start /min cmd /c "%~dp0batch.cmd !ip!"
echo !ip!;1;processing
::timeout 30 >NULL
exit /b

