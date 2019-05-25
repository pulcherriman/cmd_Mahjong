set _cur=%time%
if "%_cur:~0,1%" == " " (
	set _ret=10%_cur:~1,1%
) else set _ret=1%_cur:~0,2%
set /a _ret=_ret*60+1%_cur:~3,2%
set /a _ret=_ret*6000+1%_cur:~6,2%%_cur:~9,2%-36610000
if "%1" == "" exit /b %_ret%
set %1=%_ret%
exit /b
