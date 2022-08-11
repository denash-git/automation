:: ����� ��������筮�� �믮������ � �ᨭ�஭��� ����� १��� � list_.csv
@echo off
setlocal enabledelayedexpansion
cls
cd %~dp0

:: �ନ஢���� ��������� �६���� 䠩�
echo ip_addr;flag_ping;flag_task;comment>> %~dp0list_.csv

:: ��ॡ�� ������ ��ப� � 䠩��, �஬� ��ࢮ�
for /f "tokens=* skip=1" %%a IN (%~dp0list.csv) DO (

	:: �஡����� ��ப� �� ���祭��
	for /f "tokens=1-3* delims=;" %%b IN ("%%a") DO (
		::��ࢨ�� ���祭�� ��ப�
		set ip=%%b
		set ping=%%c
		set flag=%%d
		set comment=%%e
		set acc=0
		::�஢�ઠ ����室����� �믮������ �����
		if !flag!==0 (
			:: ����㯥� �� ���?
			for /f "tokens=7" %%i IN ('ping -n 1 %%b^|find /I "TTL"') DO (
				:: =1 �ᯥ�� ping
				set acc=1
			)
			
			::�믮������ �����, �᫨ ��� ����㯥�
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
::��२���������
::del %~dp0list.csv
::ren %~dp0list_.csv list.csv
 
exit /b

::++++++++++++++++++++++++++++++  modul +++++++++++++++++++++++++++++++++++++++++++++
:net

start /min cmd /c "%~dp0batch.cmd !ip!"
echo !ip!;1;processing
::timeout 30 >NULL
exit /b

