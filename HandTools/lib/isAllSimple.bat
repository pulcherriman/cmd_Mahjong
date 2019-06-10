:isAllSimple::void -> int
  setlocal
  for %%i in (%haisi%) do (
    set /a tmp="(1-%%i%%10)*(%%i%%10%%9)*(%%i/10%%10%%4)"
    if !tmp! equ 0 ( exit /b 0 )
  )
exit /b 1 ::’f›ô‹ã
