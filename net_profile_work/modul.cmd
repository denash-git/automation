:modul

start /wait /min cmd /c "psexec \\!ip! -h -i -u ***** -p ****** -f -c net_profil_work.cmd"
set comment=%errorlevel%
set flag=yes
exit /b

