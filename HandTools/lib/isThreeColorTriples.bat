:isThreeColorTriples::string triples, int triple_cnt -> int
  setlocal
  set triples=%~1
  if %2 equ 3 (
    for %%o in (%triples%) do (
      set _tmp=!_tmp!%%o
    )
    set /a _result="_tmp%%102030%%10101"
    if !_result! equ 0 exit /b 16384 ::三色同刻
  ) else if %2 equ 4 (
    for /l %%i in (0,3,9) do (
      set _tmp=
      for /l %%j in (0,3,9) do (
        if %%i neq %%j set _tmp=!_tmp!!triples:~%%j,2!
      )
      set /a _result="_tmp%%102030%%10101"
      if !_result! equ 0 exit /b 16384 ::三色同刻
    )
  )
exit /b 0
