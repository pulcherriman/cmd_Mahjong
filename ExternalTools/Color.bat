set _col=0
set _arg=%1

:setColor_loop
	shift
	if "%1" == "" goto setColor_fin
	set /a _col+=ccon_%1
	goto setColor_loop

:setColor_fin
set %_arg%=%ccon_esc%%_col%m%ccon_esc%107m!%_arg%!%ccon_esc%97m%ccon_esc%42m
exit /b

