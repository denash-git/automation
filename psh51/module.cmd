:module
:: execution from the system user
psexec \\%ip% -h -s -c -f %~dp0psh.cmd

set result=%errorlevel%

set comment=%result% ошибка выполнения, досрочное завершение модуля
if %result%==0 set comment=net framework 4.8 присутствует
if %result%==1 set comment=установка выполнена модулем
if %result%==2 set comment=ОС не поддерживается модулем
if %result%==3 set comment=необходима перезагрузка

set flag=yes

exit /b
