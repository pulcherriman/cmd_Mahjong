if "%1" == "" call Errors/occured invalid_arguments
if "%2" == "" (
	set /a _hour=%1
	set /a _ms=_hour%%100+100,_hour/=100
	set /a _sec=_hour%%60+100,_hour/=60
	set /a _min=_hour%%60+100,_hour=_hour/60+100
	echo %1: !_hour:~1!:!_min:~1!:!_sec:~1!.!_ms:~1!
) else (
	set /a _diff="(%2-%1+8640000)%%8640000"
	call Times/print %1
	call Times/print %2
	echo diff: !_diff!0 msec
)
