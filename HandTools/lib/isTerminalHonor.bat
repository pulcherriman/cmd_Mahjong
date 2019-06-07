:isTerminalHonor::int head, string times -> int
  setlocal
  set /a tmp="(1-%1%%10)*(%1%%10%%9)*(%1/10%%10%%4)"
  if %tmp% neq 0 ( exit /b 0 )
  for %%t in (%~1) do (
    set /a tailnum="%%t%%10"
    if !tailnum! neq 1 if !tailnum! neq 9 if %%t lss 40 ( exit /b 0 )
    if %%t geq 40 ( exit /b 1024 ::¬˜V“ª)
  )
  if %head% geq 40 ( exit /b 1024 ::¬˜V“ª)
exit /b 67108864 ::´˜V“ª
