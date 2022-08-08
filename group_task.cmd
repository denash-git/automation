:: group execution of task in a workgroup, depending on the module
:: 
:: из файла 'list.csv' построчно читается ip, flag пинга, flag задачи, comment
:: 	 - ip целевой ip host`a
::   - flag_task =0 -требуется выполнение :modul. не равно 0 -задача выполнена, не подлежит выполнению
::               выполняется только при доступности hosta в текщее время
::   - flag_ping история доступности hosta, 0 или 1
::   - comment для информации, резултат

@ECHO OFF
SETLOCAL enabledelayedexpansion
cls
cd %~dp0

:: формирование временного файла
echo ip_addr;flag_ping;flag_task;comment>> %~dp0list_.csv

:: перебор каждой строки в файле, кроме первой
for /f "tokens=* skip=1" %%a IN (%~dp0list.csv) DO (

	:: дробление строки на значения
	for /f "tokens=1-3* delims=;" %%b IN ("%%a") DO (
		:: первичные значения из файла
		set ip=%%b
		set ping=%%c
		set flag=%%d
		set comment=%%e
		set pnow=0
		
		:: проверка необходимости выполнения задачи
		if !flag!==0 (
			:: доступен ли хост?
			for /f "tokens=7" %%i IN ('ping -n 1 %%b^|find /I "TTL"') DO (
			:: =1 успешный ping
			set pnow=1
			)
			
			::выполнение задачи, если хост доступен
			if !pnow!==1 (
				call :modul
				set ping=1
			)
		)
		:: формирование отчета
		set outline=!ip!;!ping!;!flag!;!comment!
		:: вывод отчета на экран
		echo !outline!
		::запись отчета в временный файл
		echo !outline!>> %~dp0list_.csv
	)
)

del %~dp0list.csv
ren %~dp0list_.csv list.csv
 
exit /b

::++++++++++++++++++++++++++++++  modul  +++++++++++++++++++++++++++++++++++++++++++++
:modul
:: входной параметр ip
:: выходной парметр результат flag_task и comment

exit /b
::+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++