@echo off
setlocal enabledelayedexpansion
REM order[0]=11
REM order[1]=12
REM order[2]=14
REM order[3]=17


set ord=11 12 14 17

:hoge
call Times/get begin
call :IsIttuu
call Times/get end
call Times/print begin end
echo %errorlevel%
pause>nul
goto hoge

:IsIttuu
for /l %%i in (0,3,9) do (
	set dig=
	for /l %%j in (0,3,9) do (
		if %%i neq %%j set dig=!dig!!ord:~%%j,2!
	)
	set /a dig=dig%%101010%%10101
	if !dig! equ 306 exit /b 1
)
exit /b 0
