:isSingleColor::ref int[] tp, int endIdx, bool is7Pairs -> int
  setlocal
  set /a is7Pairs=%3,fst_tp=%1[0],fst_color="fst_tp/10%%10"
  if %fst_tp% geq 40 exit /b 33554432 ::����F
  for /l %%i in (1,1,%2) do (
    set /a color="%1[%%i]/10%%10"
    if !color! neq %fst_color% (
      if !color! neq 4 ( exit /b 0 )
      if %is7Pairs% == 1 ( exit /b 256 ::����F )
      if %fst_color% == 3 if !%1[%%i]! == 46 (
        call %~dp0isAllGreen
        if errorlevel 1 exit /b 67108864 ::�Έ�F
      )
      exit /b 256 ::����F
    )
  )
  if !color! == 3 (
    call %~dp0isAllGreen
    if errorlevel 1 exit /b 67108864 ::�Έ�F
  )
exit /b 128 ::����F
