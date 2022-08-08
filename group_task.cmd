:: Кашин Д.П. v.2 2022.07
:: удаленное пакетное выполнение задач, в зависимости от модуля
:: принцип: из файла CSV забирается -ip, флаг ping, flag задачи, comment
:: ip целевой ip host`a
:: flag_task=yes (любое отличное от 0) задача выполнена (больше выполняться не будет), flag_task=0 надо выполнить
:: flag_ping задача подлежит текущему исполнению, если host доступен =1
:: comment для информации

@ECHO OFF
SETLOCAL enabledelayedexpansion
cls
cd %~dp0

:: формирование заголовка временный файл
echo ip_addr;flag_ping;flag_task;comment>> %~dp0list_.csv

:: перебор каждой строки в файле, кроме первой
for /f "tokens=* skip=1" %%a IN (%~dp0list.csv) DO (

	:: дробление строки на значения
	for /f "tokens=1-3* delims=;" %%b IN ("%%a") DO (
		::первичные значения из файла
		set ip=%%b
		set ping=%%c
		set flag=%%d
		set comment=%%e

		::проверка необходимости выполнения задачи
		if !flag!==0 (
			:: доступен ли хост?
			for /f "tokens=7" %%i IN ('ping -n 1 %%b^|find /I "TTL"') DO (
			:: =1 успешный ping
			set ping=1
			)
			
			::выполнение задачи, если хост доступен
			if !ping!==1 (
				call :what
			)
		)
		:: формирование отчета
		set outline=!ip!;!ping!;!flag!;!comment!
		:: вывод отчета на экран >
		echo !outline!
		::запись отчета в временный файл
		echo !outline!>> %~dp0list_.csv
	)
)
::переименование
::del %~dp0list.csv
::ren %~dp0list_.csv list.csv
 
exit /b

::++++++++++++++++++++++++++++++  modul  +++++++++++++++++++++++++++++++++++++++++++++
:what

:: запрос версии ОС
for /f "tokens=2 delims==" %%k in ('wmic /node:!ip! os get caption /value^|findstr "="') do set win=%%k
:: запрос битности ОС
for /f "tokens=2 delims==" %%l in ('wmic /node:!ip! os get osarchitecture /value^|findstr "="') do set arh=%%l
set comment=%win%, %arh%
set flag=yes
if "%win%" equ "" set flag=error
exit /b
::+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++