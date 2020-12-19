pushd %~dp0..

if "%2" == "" call occured Error panic
call :%*
popd && exit /b

:Error
	color 0c
	echo エラーが発生しました！
	if exist Errors/messages/%1.txt (
		echo 種別: 一般エラー
		echo 名称: %1
		echo.
		type Errors/message/%1.txt
	) else (
		echo 種別: 特殊エラー
		echo 説明: %1
	)
	pause>nul
	exit

:Warning
	color 0e
	echo 警告が発生しました！
	if exist Errors/messages/%1.txt (
		echo 種別: 一般警告
		echo 名称: %1
		echo.
		type Errors/message/%1.txt
	) else (
		echo 種別: 特殊警告
		echo 説明: %1
	)
	pause>nul
	color 07
	exit /b
