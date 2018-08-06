if "%1" == "" call Errors/occured panic
cd %~dp0/messages
color 0c
echo エラーが発生しました！
if exist %1.txt (
	echo 種別: 一般エラー
	echo 名称: %1
	echo.
	type %1.txt
) else (
	echo 種別: 特殊エラー
	echo 名称: %1
)
pause>nul
exit


