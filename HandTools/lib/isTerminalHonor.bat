:isTerminalHonor::int head, string times -> int
  setlocal
  set /a tmp="(1-%1%%10)*(%1%%10%%9)*(%1/10%%10%%4)"
  if %tmp% neq 0 ( exit /b 0 )
  set /a tmp=0
  for %%t in (%~2) do (
    set /a tmp="(1-%%t%%10)*(%%t%%10%%9)*(%%t/10%%10%%4)"
    if !tmp! neq 0 ( exit /b 0 )
  )
  if %1 geq 40 ( exit /b 1024 ::¬˜V“ª)
exit /b 67108864 ::´˜V“ª
