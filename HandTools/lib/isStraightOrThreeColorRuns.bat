:isStraightOrThreeColorRuns::string runs, int run_cnt -> int
  setlocal
  set runs=%~1
  if %2 equ 3 (
    for %%o in (%runs%) do (
      set _tmp=!_tmp!%%o
    )
    set /a _result="_tmp%%101010%%10101"
    if !_result! equ 306 exit /b 256 ::��C�ʊ�
    set /a _result="_tmp%%102030%%10101"
    if !_result! equ 0 exit /b 128 ::�O�F����
  ) else if %2 equ 4 (
    for /l %%i in (0,3,9) do (
      set _tmp=
      for /l %%j in (0,3,9) do (
        if %%i neq %%j set _tmp=!_tmp!!runs:~%%j,2!
      )
      set /a _result="_tmp%%101010%%10101"
      if !_result! equ 306 exit /b 256 ::��C�ʊ�
      set /a _result="_tmp%%102030%%10101"
      if !_result! equ 0 exit /b 128 ::�O�F����
    )
  )
exit /b 0
