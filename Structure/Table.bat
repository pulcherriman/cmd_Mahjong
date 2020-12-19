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
    exit /b

:dtor
    call ExternalTools/setPosition 25 1
    for /f "delims==" %%i in ('set $Table') do (
        set %%i=
    )    
    exit /b

:shipai
    call Utils/shipai yama 136
    exit /b

:display_Info
    call ExternalTools/setPosition 11 35
    call Utils/display PutPai 40+$Table.Ba
    call Utils/display PutKanjiNumber $Table.Kyoku
    echo ã«

    call ExternalTools/setPosition 12 35
    call Utils/display PutArabicNumber $Table.Tsumibou
    echo ñ{èÍ

    call ExternalTools/setPosition 14 35
    echo ãüëı
    call ExternalTools/setPosition 14 39
    call Utils/display PutArabicNumber $Table.Kyoutaku

    exit /b