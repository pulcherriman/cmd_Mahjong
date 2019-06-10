:isStraight::string ord, int ord_cnt -> int
  setlocal
  set ord=%~1
  if %2 equ 3 (
    for %%o in (%ord%) do (
      set _tmp=!_tmp!%%o
    )
    echo !_tmp!
    set /a _tmp="_tmp%%101010%%10101"
    if !_tmp! equ 306 exit /b 256 ::ˆê‹C’ÊŠÑ
  ) else if %2 equ 4 (
    for /l %%i in (0,3,9) do (
      set _tmp=
      for /l %%j in (0,3,9) do (
        if %%i neq %%j set _tmp=!_tmp!!ord:~%%j,2!
      )
      set /a _tmp="_tmp%%101010%%10101"
      if !_tmp! equ 306 exit /b 256 ::ˆê‹C’ÊŠÑ
    )
  )
exit /b 0
