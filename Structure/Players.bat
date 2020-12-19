:: プレイヤー情報の作成とアクセス
:__method
	if "%1" == "" call Errors/occured Error invalid_arguments
	call :%*
	exit /b

:create :: id
	if "%1" == "" call Errors/occured Error invalid_arguments
	if defined players[%1] (
		call Errors/occured Warning プレイヤー【%1】はすでに存在しています
		exit /b
	)
	set players[%1]=0
	call Structure/Player ctor %1
	exit /b

:act :: method id values...
	if "%2" == "" call Errors/occured Error invalid_arguments
	if not defined players[%2] (
		call Errors/occured Error プレイヤー【%2】は存在しません
		exit /b
	)
	call Structure/Player %*
	exit /b

:delete :: id
	if "%1" == "" call Errors/occured Error invalid_arguments
	if not defined players[%1] (
		call Errors/occured Warning プレイヤー【%1】は存在しないため、削除できません
		exit /b
	)
	call Structure/Player dtor %1
	set players[%1]=
	exit /b
	
