:: プレイヤー情報の作成とアクセス
:__method
	if "%1" == "" call Errors/occured Error invalid_arguments
	call :%*
	exit /b

:ctor
	set $Players.Count=0
	exit /b

:dtor
    for /f "delims==" %%i in ('set $Players.') do (
        set %%i=
    )
	exit /b

:create :: id
	if "%1" == "" call Errors/occured Error invalid_arguments
	if defined $Players.Exist[%1] (
		call Errors/occured Warning プレイヤー【%1】はすでに存在しています
		exit /b
	)
	set $Players.Exist[%1]=0
	set $Players.Id[%$Players.Count%]=%1
	set /a $Players.Count+=1
	call Structure/Player ctor %*
	exit /b

:delete :: id
	if "%1" == "" call Errors/occured Error invalid_arguments
	if not defined $Players.Exist[%1] (
		call Errors/occured Warning プレイヤー【%1】は存在しないため、削除できません
		exit /b
	)
	call Structure/Player dtor %1
	set $Players.Exist[%1]=
	set /a $Players.Count-=1
	for /l %%i in (0, 1, %$Players.Count%) do (
		if $Players.Id[%%i] equ %1 (
			set _flag=%%i
		)
		if defined _flag (
			set /a _flag+=1
			set /a $Players.Id[%%i]=$Players.Id[%_flag%]
		)
	)
	set $Players.Id[%$Players.Count%]=
	exit /b

:: 指定IDのプレイヤーのメソッドを呼ぶ
:act :: method id values...
	if "%2" == "" call Errors/occured Error invalid_arguments
	if not defined $Players.Exist[%2] (
		call Errors/occured Error プレイヤー【%2】は存在しません
		exit /b
	)
	call Structure/Player %*
	exit /b