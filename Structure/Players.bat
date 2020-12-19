:: �v���C���[���̍쐬�ƃA�N�Z�X
:__method
	if "%1" == "" call Errors/occured Error invalid_arguments
	call :%*
	exit /b

:create :: id
	if "%1" == "" call Errors/occured Error invalid_arguments
	if defined players[%1] (
		call Errors/occured Warning �v���C���[�y%1�z�͂��łɑ��݂��Ă��܂�
		exit /b
	)
	set players[%1]=0
	call Structure/Player ctor %1
	exit /b

:act :: method id values...
	if "%2" == "" call Errors/occured Error invalid_arguments
	if not defined players[%2] (
		call Errors/occured Error �v���C���[�y%2�z�͑��݂��܂���
		exit /b
	)
	call Structure/Player %*
	exit /b

:delete :: id
	if "%1" == "" call Errors/occured Error invalid_arguments
	if not defined players[%1] (
		call Errors/occured Warning �v���C���[�y%1�z�͑��݂��Ȃ����߁A�폜�ł��܂���
		exit /b
	)
	call Structure/Player dtor %1
	set players[%1]=
	exit /b
	
