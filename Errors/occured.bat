pushd %~dp0..

if "%1" == "" call occured panic

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
popd && exit


