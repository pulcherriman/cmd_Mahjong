:isStraight::string ord, int ord_cnt -> int
  setlocal
  set ord=%~2
  if %2 equ 3 (
    for /l %%o in (%ord%) do (
      set tmp=!tmp!%%o
    )
    set /a tmp=tmp%%101010%%10101
    if !tmp! equ 306 exit /b 256 ::ˆê‹C’ÊŠÑ
  ) else if %2 equ 4 (
    for /l %%i in (0,3,9) do (
      for /l %%j in (0,3,9) do (
        if %%i neq %%j set tmp=!tmp!!ord:~%%j,2!
      )
      set /a tmp=tmp%%101010%%10101
      if !tmp! equ 306 exit /b 256 ::ˆê‹C’ÊŠÑ
    )
  )
exit /b 0
