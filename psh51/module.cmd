:module
:: execution from the system user
psexec \\%ip% -h -s -c -f %~dp0psh.cmd

set result=%errorlevel%

set comment=%result% �訡�� �믮������, ����筮� �����襭�� �����
if %result%==0 set comment=net framework 4.8 ���������
if %result%==1 set comment=��⠭���� �믮����� ���㫥�
if %result%==2 set comment=�� �� �����ন������ ���㫥�
if %result%==3 set comment=����室��� ��१���㧪�

set flag=yes

exit /b
