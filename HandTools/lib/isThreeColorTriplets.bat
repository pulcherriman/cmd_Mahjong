:isThreeColorTriplets::string triplets, int triplet_cnt -> int
  setlocal
  set triplets=%~1
  if %2 equ 3 (
    for %%o in (%triplets%) do (
      set _tmp=!_tmp!%%o
    )
    set /a _result="_tmp%%102030%%10101"
    if !_result! equ 0 exit /b 16384 ::�O�F����
  ) else if %2 equ 4 (
    for /l %%i in (0,3,9) do (
      set _tmp=
      for /l %%j in (0,3,9) do (
        if %%i neq %%j set _tmp=!_tmp!!triplets:~%%j,2!
      )
      set /a _result="_tmp%%102030%%10101"
      if !_result! equ 0 exit /b 16384 ::�O�F����
    )
  )
exit /b 0
