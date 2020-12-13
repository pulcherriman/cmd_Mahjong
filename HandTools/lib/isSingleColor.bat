:isSingleColor::ref int[] tp, int endIdx, bool is7Pairs -> int
  setlocal
  set /a is7Pairs=%3,fst_tp=%1[0],fst_color="fst_tp/10%%10"
  if %fst_tp% geq 40 exit /b 33554432 ::字一色
  for /l %%i in (1,1,%2) do (
    set /a color="%1[%%i]/10%%10"
    if !color! neq %fst_color% (
      if !color! neq 4 ( exit /b 0 )
      if %is7Pairs% == 1 ( exit /b 256 ::混一色 )
      if %fst_color% == 3 if !%1[%%i]! == 46 (
        call %~dp0isAllGreen
        if errorlevel 1 exit /b 67108864 ::緑一色
      )
      exit /b 256 ::混一色
    )
  )
  if !color! == 3 (
    call %~dp0isAllGreen
    if errorlevel 1 exit /b 67108864 ::緑一色
  )
exit /b 128 ::清一色
