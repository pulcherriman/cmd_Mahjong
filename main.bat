@echo off
cd %~dp0
setlocal EnableDelayedExpansion

:Routine_init
call Utils/envInit

:Routine_main
call Scenes/title
call Scenes/games/init

:Routine_fin
goto Routine_init
