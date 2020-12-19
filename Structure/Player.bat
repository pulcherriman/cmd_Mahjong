:: 各プレイヤーの情報
:__method
	if "%1" == "" call Errors/occured Error invalid_arguments
	call :%*
	exit /b

:ctor :: id name
	if "%2" == "" call Errors/occured Error invalid_arguments
    set $p%1.Name=%2
    set $p%1.Score=25000
    exit /b

:dtor :: id
	if "%1" == "" call Errors/occured Error invalid_arguments
    call ExternalTools/setPosition 25 1
    for /f "delims==" %%i in ('set $p%1') do (
        set %%i=
    )
    exit /b

:act :: method id values...
	if "%2" == "" call Errors/occured Error invalid_arguments
    call :%*
    exit /b

:: 13枚配る
:haipai :: id begin_index
	if "%2" == "" call Errors/occured Error invalid_arguments
    set $p%1.HandCount=13
    for /l %%i in (0, 1, 12) do (
        set /a index=%2+%%i
        set /a $p%1.Hand[%%i]=yama[!index!]
    )
    call Utils/sort $p%1.Hand 0 13

:: 現在の手牌状況を描画する position=1を自分の位置とし反時計回り
:display :: id position
	if "%2" == "" call Errors/occured Error invalid_arguments
    set /a _index=$p%1.HandCount-1
    if %2 equ 1 (
        call :display_Jicha %1
    ) else if %2 equ 2 (
        call :display_Shimocha %1
    ) else if %2 equ 3 (
        call :display_Toimen %1
    ) else if %2 equ 4 (
        call :display_Kamicha %1
    )
    exit /b

:display_Jicha :: id
    call ExternalTools/setPosition 24 17
    for /l %%i in (0, 1, %_index%) do (
        call Utils/display PutPai !$p%1.Hand[%%i]!
    )
    exit /b

:display_Shimocha :: id
    for /l %%i in (0, 1, %_index%) do (
        call ExternalTools/setPosition 21-%%i 63
        call Utils/display PutPai !$p%1.Hand[%%i]!
    )
    exit /b

:display_Toimen :: id
    for /l %%i in (0, 1, %_index%) do (
        call ExternalTools/setPosition 2 58-2*%%i !column!
        call Utils/display PutPai !$p%1.Hand[%%i]!
    )
    exit /b

:display_Kamicha :: id
    for /l %%i in (0, 1, %_index%) do (
        call ExternalTools/setPosition 5+%%i 11
        call Utils/display PutPai !$p%1.Hand[%%i]!
    )
    exit /b

