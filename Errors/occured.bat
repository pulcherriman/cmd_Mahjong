pushd %~dp0..

if "%1" == "" call occured panic

color 0c
echo エラーが発生しました！
if exist Errors/messages/%1.txt (
	echo 種別: 一般エラー
	echo 名称: %1
	echo.
	type Errors/message/%1.txt
) else (
	echo 種別: 特殊エラー
	echo 名称: %1
)
pause>nul
popd && exit


