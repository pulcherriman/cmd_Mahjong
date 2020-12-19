:: ëÏÇÃèÓïÒ
:__method
	if "%1" == "" call Errors/occured Error invalid_arguments
	call :%*
	exit /b

:ctor
    set $Table.Ba=1
    set $Table.Kyoku=1
    set $Table.Tsumibou=0
    set $Table.Kyoutaku=0

    set /a $Table.Nokori=136-14-13*4
    exit /b

:dtor
    for /f "delims==" %%i in ('set $Table') do (
        set %%i=
    )    
    exit /b

:shipai
    call Utils/shipai yama 136
    exit /b

:display_Info
    call ExternalTools/setPosition 11 35
    set _disp="ìåìÏêºñk"
    echo.|set /p _=!_disp:~%$Table.Ba%,1!
    call Utils/display PutKanjiNumber $Table.Kyoku
    echo ã«

    call ExternalTools/setPosition 12 35
    call Utils/display PutArabicNumber $Table.Tsumibou
    echo ñ{èÍ

    call ExternalTools/setPosition 14 35
    echo ãüëı
    call ExternalTools/setPosition 14 39
    call Utils/display PutArabicNumber $Table.Kyoutaku

    call ExternalTools/setPosition 15 35
    echo éc:
    call ExternalTools/setPosition 15 39
    call Utils/display PutArabicNumber $Table.Nokori

    exit /b