pushd %~dp0..

if "%2" == "" call occured Error panic
call :%*
popd && exit /b

:Error
	color 0c
	echo �G���[���������܂����I
	if exist Errors/messages/%1.txt (
		echo ���: ��ʃG���[
		echo ����: %1
		echo.
		type Errors/message/%1.txt
	) else (
		echo ���: ����G���[
		echo ����: %1
	)
	pause>nul
	exit

:Warning
	color 0e
	echo �x�����������܂����I
	if exist Errors/messages/%1.txt (
		echo ���: ��ʌx��
		echo ����: %1
		echo.
		type Errors/message/%1.txt
	) else (
		echo ���: ����x��
		echo ����: %1
	)
	pause>nul
	color 07
	exit /b
