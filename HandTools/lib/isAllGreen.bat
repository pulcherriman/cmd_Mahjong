:isAllGreen::void -> bool
  for %%i in (%haisi%) do (
    set /a result="(%%i%%46)*(%%i%%33)*(%%i%%32/7+%%i%%2)"
    if !result! neq 0 (
      exit /b 0
    )
  )
exit /b 1
