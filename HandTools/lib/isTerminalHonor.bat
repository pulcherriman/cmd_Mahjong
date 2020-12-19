:isTerminalHonor::int head, string triples, int isAllNum -> int
  setlocal
  set /a tmp="(1-%1%%10)*(%1%%10%%9)*(%1/10%%10%%4)"
  if %tmp% neq 0 ( exit /b 0 )
  set /a tmp=0
  for %%t in (%~2) do (
    set /a tmp="(1-%%t%%10)*(%%t%%10%%9)*(%%t/10%%10%%4)"
    if !tmp! neq 0 ( exit /b 0 )
  )
  if %3 equ 0 ( exit /b 2048 ::¬˜V“ª)
exit /b 134217728 ::´˜V“ª
