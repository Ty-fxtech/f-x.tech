@ECHO OFF
cd %userprofile%
mkdir "%windir%\AdminCheck" 2>nul
if '%errorlevel%' == '0' rmdir "%windir%\AdminCheck" & goto gotPrivileges else goto getPrivileges


:getPrivileges
(
echo Set UAC = CreateObject^(^"Shell.Application^"^)
echo Set args = WScript.Arguments
echo UAC.ShellExecute args.Item^(0^), ^"^", ^"^", ^"runas^", 1) > runadmin.vbs
runadmin.vbs "%~dp0%0"
del runadmin.vbs
exit

:gotPrivileges
net stop ltservice & net start ltservice & ECHO:
Echo WAITING FOR TRAY TO FINISH STARTUP, PLEASE WAIT AT LEAST 2 MINUTES. & ECHO:
Powershell -c "Get-Content -Path C:\windows\LTSVC\LTErrors.txt -Tail 1 -Wait | %% {write-host $_;if ($_ -match 'Network Loop Started:::') {write-host ''; write-host 'TRAY FIX SUCCESSFUL!'; exit}}"
ECHO: & PAUSE


