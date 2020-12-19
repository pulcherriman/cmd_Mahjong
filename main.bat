@echo off
cd %~dp0
setlocal EnableDelayedExpansion

:Routine_init
call Utils/envInit

:Routine_main
call Scenes/titleMenu
call Scenes/games/init
call Scenes/games/finish

:Routine_fin
goto Routine_init
