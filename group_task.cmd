:: ��設 �.�. v.2 2022.07
:: 㤠������ ����⭮� �믮������ �����, � ����ᨬ��� �� �����
:: �ਭ樯: �� 䠩�� CSV ����ࠥ��� -ip, 䫠� ping, flag �����, comment
:: ip 楫���� ip host`a
:: flag_task=yes (�� �⫨筮� �� 0) ����� �믮����� (����� �믮������� �� �㤥�), flag_task=0 ���� �믮�����
:: flag_ping ����� �������� ⥪�饬� �ᯮ������, �᫨ host ����㯥� =1
:: comment ��� ���ଠ樨

@ECHO OFF
SETLOCAL enabledelayedexpansion
cls
cd %~dp0

:: �ନ஢���� ��������� �६���� 䠩�
echo ip_addr;flag_ping;flag_task;comment>> %~dp0list_.csv

:: ��ॡ�� ������ ��ப� � 䠩��, �஬� ��ࢮ�
for /f "tokens=* skip=1" %%a IN (%~dp0list.csv) DO (

	:: �஡����� ��ப� �� ���祭��
	for /f "tokens=1-3* delims=;" %%b IN ("%%a") DO (
		::��ࢨ�� ���祭�� �� 䠩��
		set ip=%%b
		set ping=%%c
		set flag=%%d
		set comment=%%e

		::�஢�ઠ ����室����� �믮������ �����
		if !flag!==0 (
			:: ����㯥� �� ���?
			for /f "tokens=7" %%i IN ('ping -n 1 %%b^|find /I "TTL"') DO (
			:: =1 �ᯥ�� ping
			set ping=1
			)
			
			::�믮������ �����, �᫨ ��� ����㯥�
			if !ping!==1 (
				call :what
			)
		)
		:: �ନ஢���� ����
		set outline=!ip!;!ping!;!flag!;!comment!
		:: �뢮� ���� �� �࠭ >
		echo !outline!
		::������ ���� � �६���� 䠩�
		echo !outline!>> %~dp0list_.csv
	)
)
::��२���������
::del %~dp0list.csv
::ren %~dp0list_.csv list.csv
 
exit /b

::++++++++++++++++++++++++++++++  modul  +++++++++++++++++++++++++++++++++++++++++++++
:what

:: ����� ���ᨨ ��
for /f "tokens=2 delims==" %%k in ('wmic /node:!ip! os get caption /value^|findstr "="') do set win=%%k
:: ����� ��⭮�� ��
for /f "tokens=2 delims==" %%l in ('wmic /node:!ip! os get osarchitecture /value^|findstr "="') do set arh=%%l
set comment=%win%, %arh%
set flag=yes
if "%win%" equ "" set flag=error
exit /b
::+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++