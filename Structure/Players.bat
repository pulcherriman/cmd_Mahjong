:: �v���C���[���̍쐬�ƃA�N�Z�X
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
		call Errors/occured Warning �v���C���[�y%1�z�͂��łɑ��݂��Ă��܂�
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
		call Errors/occured Warning �v���C���[�y%1�z�͑��݂��Ȃ����߁A�폜�ł��܂���
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

:: �w��ID�̃v���C���[�̃��\�b�h���Ă�
:act :: method id values...
	if "%2" == "" call Errors/occured Error invalid_arguments
	if not defined $Players.Exist[%2] (
		call Errors/occured Error �v���C���[�y%2�z�͑��݂��܂���
		exit /b
	)
	call Structure/Player %*
	exit /b