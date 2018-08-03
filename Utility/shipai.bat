if "%2" == "" call Error/occured invalid_arguments
set /a _n=%2-1
for /l %%_ in (0,1,%_n%) do (
	set /a _d=%%_^&3
	set /a %1[%%_]=11+%%_/36+%%_/4
	if !%1[%%_]:~1,1!!_d! equ 50 if %%_ lss 108 set /a %1[%%_]=%1[%%_]/10*10
)
for /l %%_ in (%_n%,-1,1) do (
	set /a _m=!random!%%^(%%_+1^)
	set /a _tmp=%1[!_m!]
	set /a %1[!_m!]=%1[%%_]
	set /a %1[%%_]=_tmp
)
exit /b

