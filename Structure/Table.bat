:: 卓の情報
:__method
	if "%1" == "" call Errors/occured Error invalid_arguments
	call :%*
	exit /b

:ctor :: ref PlayerIdArray, Your ID
    set $Table.Ba=1
    set $Table.Kyoku=1
    set $Table.Tsumibou=0
    set $Table.Kyoutaku=0
    set $Table.PlayerCount=0
    for /f %%i in ('set %1') do (
        set _cmd=%%i
        set !_cmd:Players.Id=Table.Players!
        set /a $Table.PlayerCount+=1
    )
    set /a $Table.PlayerCountForLoop=$Table.PlayerCount-1
    call Utils/Shuffle $Table.Players %$Table.PlayerCount%

    exit /b

:dtor
    for /f "delims==" %%i in ('set $Table.') do (
        set %%i=
    )    
    exit /b

:set_player :: id
    if "%1" == "" call Errors/occured Error invalid_arguments
    :__inner_set_player
        if %$Table.Players[0]% equ %1 exit /b
        for /l %%i in (%$Table.PlayerCountForLoop%,-1,0) do (
            set /a _index=%%i+1
            set /a $Table.Players[!_index!]=$Table.Players[%%i]
        )
        set /a $Table.Players[0]=$Table.Players[%$Table.PlayerCount%]
        set $Table.Players[%$Table.PlayerCount%]=
        goto __inner_set_player
    exit /b

:decide_Chicha
    call Utils/Display pause 親を決めます。（開発中）
    call Utils/Display Message

    :: 親を決める
    exit /b

:start_section
    :: 洗牌
    call Utils/shipai $Table.Yama 136

    :: TODO:ワンパイ処理

    :: 各家配牌
    for /l %%i in (0,1,%$Table.PlayerCountForLoop%) do (
        set /a _index=14+13*%%i
        call Structure/Players act haipai !$Table.Players[%%i]! !_index!
    )

    :: 牌の残り枚数設定
    set /a $Table.Nokori=136-14-13*4

    exit /b



::#region display

:display_Players
    for /l %%i in (0,1,%$Table.PlayerCountForLoop%) do (
        call Structure/Players act display_Name !$Table.Players[%%i]! %%i
    )
    exit /b

:display_Info
    :: 局の情報
    call ExternalTools/setPosition 11 35
    set _disp="東南西北"
    echo.|set /p _=!_disp:~%$Table.Ba%,1!
    call Utils/display PutKanjiNumber $Table.Kyoku
    echo 局

    call ExternalTools/setPosition 12 35
    call Utils/display PutArabicNumber $Table.Tsumibou
    echo 本場

    call ExternalTools/setPosition 14 35
    echo 供託
    call ExternalTools/setPosition 14 39
    call Utils/display PutArabicNumber $Table.Kyoutaku

    call ExternalTools/setPosition 15 35
    echo 残:
    call ExternalTools/setPosition 15 39
    call Utils/display PutArabicNumber $Table.Nokori

    :: プレイヤーの手牌
    for /l %%i in (0,1,%$Table.PlayerCountForLoop%) do (
        call Structure/Players act display_Pai !$Table.Players[%%i]! %%i
    )

    exit /b

::#endregion display
