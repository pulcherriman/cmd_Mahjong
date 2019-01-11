if "%2" == "" call Errors/occured invalid_arguments

setlocal
set _disp=–³–³–³–³–³–³–³–³–³–³ŒÜˆê“ñOlŒÜ˜Zµ”ª‹ã‡D‡@‡A‡B‡C‡D‡E‡F‡G‡H‚T‚P‚Q‚R‚S‚T‚U‚V‚W‚X–³“Œ“ì¼–k”’á¢’†–³–³–³@

set /a _n=%2-1
set _str=
for /l %%_ in (0,1,%_n%) do (
	call :getChar !%1[%%_]!
	set _str=!_str!!_char!
	set /a _m=%%_%%17
	if !_m! equ 16 (
		echo !_str!
		set _str=
	)
)
exit /b

:getChar
	set _char=!_disp:~%1,1!
	set /a _isR=%1%%10
	if %_isR% equ 0 call ExternalTools/setColor _char fore red bright
	exit /b
