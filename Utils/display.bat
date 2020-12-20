:__method
	if "%1" == "" call Errors/occured Error invalid_arguments
    if not defined $Utils.SPACE (
        set $Utils.SPACE= Message:
        for /l %%i in (1,1,63) do set $Utils.SPACE=!$Utils.SPACE! 
		call ExternalTools/Color Description $Utils.SPACE
    )

	call :%*
	exit /b

:yamaArrayDump
	if "%3" == "" call Errors/occured Error invalid_arguments

	set /a _n=%2+%3-1
	set _str=
	for /l %%_ in (%2,1,%_n%) do (
		call :getChar !%1[%%_]!
		set _str=!_str!!_char!
	)
	echo %_str%
	exit /b

:putPai :: pai_number
	set /a _char=%1
	call :getChar %_char%
	echo.| set /p _=%_char%
	exit /b

:getChar :: pai_number
	set _disp=–³–³–³–³–³–³–³–³–³–³ŒÜˆê“ñOlŒÜ˜Zµ”ª‹ã‡D‡@‡A‡B‡C‡D‡E‡F‡G‡H‚T‚P‚Q‚R‚S‚T‚U‚V‚W‚X–³“Œ“ì¼–k”’á¢’†–³–³–³@
	set _char=!_disp:~%1,1!
	set /a _isR=%1%%10
	if %_isR% equ 0 (
		call ExternalTools/Color Pai_Aka _char
	) else (
		call ExternalTools/Color Pai_Normal _char
	)
	exit /b
	
:putKanjiNumber :: number
	set /a _num=%1
	if %_num% gtr 10 (
		echo.| set /p _=!_num!
		exit /b
	)
	set _disp=Zˆê“ñOlŒÜ˜Zµ”ª‹ã\
	echo.| set /p _=!_disp:~%_num%,1!
	exit /b
		
:putArabicNumber :: number
	set /a _num=%1
	if %_num% gtr 9 (
		echo.| set /p _=!_num!
		exit /b
	)
	set _disp=‚O‚P‚Q‚R‚S‚T‚U‚V‚W‚X
	echo.| set /p _=!_disp:~%_num%,1!
	exit /b

:Cls
	cls
	call Utils/Display Message
	exit /b

:Message :: message|null
	if "%1" == "" (
		call ExternalTools/setPosition 28 2
    	set /p _=%$Utils.SPACE%<nul
	) else (
		call ExternalTools/setPosition 28 3
		call ExternalTools/Color Description Message:%1
	)
    exit /b

:Pause :: message|null
	call :Message %1
	if "%1" == "" call ExternalTools/setPosition 28 11
	pause>nul