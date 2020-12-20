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
    for /f "delims==" %%i in ('set $p%1.') do (
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
        set /a $p%1.Hand[%%i]=$Table.Yama[!index!]
    )
    call Utils/sort $p%1.Hand 0 13
    exit /b

:: 現在のプレイヤー情報を描画する position=0を自分の位置とし反時計回り
:display_Name :: id position
	if "%2" == "" call Errors/occured Error invalid_arguments
    if %2 equ 0 (
        call ExternalTools/setPosition 26 30
        call ExternalTools/Color Description !$p%1.Name!
        call ExternalTools/Color Description :!$p%1.Score!
    ) else if %2 equ 1 (
        call ExternalTools/setPosition 10 66
        call ExternalTools/Color Description !$p%1.Name!
        call ExternalTools/setPosition 11 66
        call ExternalTools/Color Description !$p%1.Score!
    ) else if %2 equ 2 (
        call ExternalTools/setPosition 1 30
        call ExternalTools/Color Description !$p%1.Name!
        call ExternalTools/Color Description :!$p%1.Score!
    ) else if %2 equ 3 (
        call ExternalTools/setPosition 10 2
        call ExternalTools/Color Description !$p%1.Name!
        call ExternalTools/setPosition 11 2
        call ExternalTools/Color Description !$p%1.Score!
    )
    exit /b

:: 現在の手牌状況を描画する position=0を自分の位置とし反時計回り
:display_Pai :: id position
	if "%2" == "" call Errors/occured Error invalid_arguments
    set /a _index=$p%1.HandCount-1
    if %2 equ 0 (
        call :display_Pai_Jicha %1
    ) else if %2 equ 1 (
        call :display_Pai_Shimocha %1
    ) else if %2 equ 2 (
        call :display_Pai_Toimen %1
    ) else if %2 equ 3 (
        call :display_Pai_Kamicha %1
    )
    exit /b

:display_Pai_Jicha :: id
    call ExternalTools/setPosition 24 17
    for /l %%i in (0, 1, %_index%) do (
        call Utils/display PutPai !$p%1.Hand[%%i]!
    )
    exit /b

:display_Pai_Shimocha :: id
    for /l %%i in (0, 1, %_index%) do (
        call ExternalTools/setPosition 21-%%i 63
        call Utils/display PutPai !$p%1.Hand[%%i]!
    )
    exit /b

:display_Pai_Toimen :: id
    for /l %%i in (0, 1, %_index%) do (
        call ExternalTools/setPosition 2 58-2*%%i !column!
        call Utils/display PutPai !$p%1.Hand[%%i]!
    )
    exit /b

:display_Pai_Kamicha :: id
    for /l %%i in (0, 1, %_index%) do (
        call ExternalTools/setPosition 5+%%i 11
        call Utils/display PutPai !$p%1.Hand[%%i]!
    )
    exit /b

