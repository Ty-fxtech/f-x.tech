@ECHO OFF
SETLOCAL EnableExtensions  EnableDelayedExpansion
REM accepts 1 parameter, Type ascii numerical ranges with dash separated by spaces double-quoted.
REM All characters are between 33-126, numbers 49-57, lower 97-122, upper 65-90
set ipt=%1
if not defined ipt set ipt="97-122 65-90"
set ipt=%ipt:~1,-1%
FOR %%g in (%ipt%) DO (
set var=%%g & set var=!var:-= !
set rng=!rng!ECHO !var! ^^^^^^^^^^^^^^^&)
set rng=%rng:~0,-5%
FOR /F "tokens=1,2" %%a  IN ('%rng%') DO (
set up=1 & if %%a GTR %%b set up=-1
FOR /L %%i IN (%%a,!up!,%%b) DO (
cmd /c exit %%i & set alp=!alp!!=exitcodeAscii! ))
echo !alp!
pause
