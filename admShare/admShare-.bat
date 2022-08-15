:: Кашин Д.П. 2018.12 v2
:: вкл доступ к Административным шарам c$ admin$ ipc$ +удаленный реестр

@echo off

reg add HKLM\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters /f /v AutoShareWks /t REG_DWORD /d 1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "LocalAccountTokenFilterPolicy" /t REG_DWORD /d 1 /f

sc config RemoteRegistry start= auto
sc start RemoteRegistry

netsh advfirewall set allprofiles state off

del %~s0 /q