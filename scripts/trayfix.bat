@ECHO OFF
cd %userprofile%
mkdir "%windir%\AdminCheck" 2>nul
if '%errorlevel%' == '0' rmdir "%windir%\AdminCheck" & goto gotPrivileges else goto getPrivileges


:getPrivileges
echo "Must be ran as admin!"
pause
exit

:gotPrivileges
net stop ltservice & net start ltservice & ECHO:
Echo WAITING FOR TRAY TO FINISH STARTUP, PLEASE WAIT AT LEAST 2 MINUTES. & ECHO:
Powershell -c "Get-Content -Path C:\windows\LTSVC\LTErrors.txt -Tail 1 -Wait | %% {write-host $_;if ($_ -match 'Network Loop Started:::') {write-host ''; write-host 'TRAY FIX SUCCESSFUL!'; exit}}"
ECHO: & PAUSE


