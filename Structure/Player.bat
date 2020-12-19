:: 各プレイヤーの情報
:__method
	if "%1" == "" call Errors/occured Error invalid_arguments
	call :%*
	exit /b

:ctor :: id name
    set $p%1.Name=%2
    exit /b

:dtor :: id
    set $p%1.Name=
    exit /b

:act :: method id values...
    call :%*
    exit /b

:: 13枚配る
:haipai :: id begin_index
    for /l %%i in (0, 1, 12) do (
        set /a $p%1.Hand[%%i]=%2+%%i
    )

:: 現在の手牌状況を描画する position=1を自分の位置とし反時計回り
:display :: id position
    set $p%1
    exit /b