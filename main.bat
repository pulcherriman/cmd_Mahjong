@echo off
cd %~dp0
mode con cols=90 lines=25
setlocal EnableDelayedExpansion

:Routine_init
call Utils/envInit

:Routine_main
call Scenes/title
call Scenes/games/init

rem call Times/get begin
rem call Times/get end
rem call Times/print begin end

:Routine_fin
exit
