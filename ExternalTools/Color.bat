:__method
	if "%2" == "" call Errors/occured Error invalid_arguments
	if defined %2 (
		call :%*
	) else (
		set _str=%2
		call :__method %1 _str
		echo.|set /p _=!_str!
	)
	exit /b

:Pai_Normal
	set %1=%ccon_esc%30m%ccon_esc%107m!%1!%ccon_default%
	exit /b

:Pai_Aka
	set %1=%ccon_esc%91m%ccon_esc%107m!%1!%ccon_default%
	exit /b

:Description
	set %1=%ccon_esc%97m%ccon_esc%40m!%1!%ccon_default%
	exit /b