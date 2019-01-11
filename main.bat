@echo off
cd %~dp0
mode con cols=90 lines=25
setlocal EnableDelayedExpansion
call Utils/envInit

call Times/get begin
call Utils/shipai yama 136
call Utils/display yama 136
call Times/get end

call Times/print begin end

pause>nul
exit

:init
