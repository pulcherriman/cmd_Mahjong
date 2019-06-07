:isAllSimple::void -> int
  setlocal
  for %%i in (%haisi%) do (
    set /a tail=%%i%%10
    if !tail! equ 1 (
      exit /b 0
    )
    if !tail! equ 9 (
      exit /b 0
    )
    if %%i geq 40 (
      exit /b 0
    )
  )
exit /b 1 ::’f›ô‹ã
