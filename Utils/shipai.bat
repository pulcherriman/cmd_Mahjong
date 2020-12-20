:: —^‚¦‚ç‚ê‚½”z—ñ–¼‚ÅR‚ğì‚é

:main :: ref array, count
if "%2" == "" call Errors/occured Error invalid_arguments
set /a _n=%2-1

for /l %%_ in (0,1,%_n%) do (
	set /a _d=%%_^&3
	set /a %1[%%_]=11+%%_/36+%%_/4
	set _d=!%1[%%_]:~1,1!!_d!
	if !_d! equ 50 if %%_ lss 108 set /a %1[%%_]=%1[%%_]/10*10
)

call Utils/Shuffle %1 %2
exit /b

