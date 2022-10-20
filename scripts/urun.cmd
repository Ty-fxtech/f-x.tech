@ECHO OFF 
cd "%PUBLIC%\f-x.tech"

REM Specify download URL and filehash.

REM This is the remainder of the URL up to the filename.
SET "URL=https://github.com/bgeraghty/RunProcessAsUser-ScreenConnect/raw/master/Release/rpau.zip"

REM This is the pre-computed file hash from powershell Get-FileHash of the dowlnoaded folder to verify whether or not the existing file is correct and 100% downloaded.
SET "FILEHASH=79E3B3036DB6A934AC3ECF58956B7890291E36AD18AF2C8CDEA9C1415E375BD7"


REM Set variables based on the URL for the filename and appfolder
call :filenamewext "FILENAME" "%URL%"
call :filenamenoext "APPFOLDER" "%URL%"


REM Download File and extract it if it doesn't exist or doesn't match the above hash, then run the 'STARTBIN' file.
SET "DLFILEHASH=0"
IF EXIST %FILENAME% for /f %%A in ('powershell -c Get-FileHash "%FILENAME%" ^^^| Select -ExpandProperty Hash') do set "dlfilehash=%%A"
IF NOT "%FILEHASH%"=="%DLFILEHASH%" curl -# -OL "%URL%" 
IF NOT EXIST "%APPFOLDER%/rpau.exe" echo Expand-Archive -Path "%FILENAME%" -DestinationPath "%APPFOLDER%" | powershell -c "-"
cd "%APPFOLDER%"
IF NOT [%1]==[] rpau --hidden "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "/c curl.exe f-x.tech/%1 | iex"
GOTO :EOF


:filenamenoext
SET "%~1=%~n2"
EXIT /B

:filenamewext
SET "%~1=%~nx2"
EXIT /B
