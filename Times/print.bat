if "%1" == "" call Errors/occured invalid_arguments
if "%2" == "" (
	set /a _hour=%1
	set /a _ms=_hour%%100
	set /a _hour/=100
	set /a _sec=_hour%%60
	set /a _hour/=60
	set /a _min=_hour%%60
	set /a _hour/=60
	echo %1: !_hour!:!_min!:!_sec!.!_ms!
) else (
	set /a _diff=%2-%1
	if !_diff! lss 0 set /a _diff+=8640000
	call Times/print %1
	call Times/print %2
	echo diff: !_diff!0 msec
)
