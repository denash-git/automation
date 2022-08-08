:: group execution of task in a workgroup, depending on the module
:: 
:: �� 䠩�� 'list.csv' �����筮 �⠥��� ip, flag �����, flag �����, comment
:: 	 - ip 楫���� ip host`a
::   - flag_task =0 -�ॡ���� �믮������ :modul. �� ࠢ�� 0 -����� �믮�����, �� �������� �믮������
::               �믮������ ⮫쪮 �� ����㯭��� hosta � ⥪饥 �६�
::   - flag_ping ����� ����㯭��� hosta, 0 ��� 1
::   - comment ��� ���ଠ樨, १���

@ECHO OFF
SETLOCAL enabledelayedexpansion
cls
cd %~dp0

:: �ନ஢���� �६������ 䠩��
echo ip_addr;flag_ping;flag_task;comment>> %~dp0list_.csv

:: ��ॡ�� ������ ��ப� � 䠩��, �஬� ��ࢮ�
for /f "tokens=* skip=1" %%a IN (%~dp0list.csv) DO (

	:: �஡����� ��ப� �� ���祭��
	for /f "tokens=1-3* delims=;" %%b IN ("%%a") DO (
		:: ��ࢨ�� ���祭�� �� 䠩��
		set ip=%%b
		set ping=%%c
		set flag=%%d
		set comment=%%e
		set pnow=0
		
		:: �஢�ઠ ����室����� �믮������ �����
		if !flag!==0 (
			:: ����㯥� �� ���?
			for /f "tokens=7" %%i IN ('ping -n 1 %%b^|find /I "TTL"') DO (
			:: =1 �ᯥ�� ping
			set pnow=1
			)
			
			::�믮������ �����, �᫨ ��� ����㯥�
			if !pnow!==1 (
				call :modul
				set ping=1
			)
		)
		:: �ନ஢���� ����
		set outline=!ip!;!ping!;!flag!;!comment!
		:: �뢮� ���� �� �࠭
		echo !outline!
		::������ ���� � �६���� 䠩�
		echo !outline!>> %~dp0list_.csv
	)
)

del %~dp0list.csv
ren %~dp0list_.csv list.csv
 
exit /b

::++++++++++++++++++++++++++++++  modul  +++++++++++++++++++++++++++++++++++++++++++++
:modul
:: �室��� ��ࠬ��� ip
:: ��室��� ��ଥ�� १���� flag_task � comment

exit /b
::+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++