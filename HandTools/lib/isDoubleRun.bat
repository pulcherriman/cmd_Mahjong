:isDoubleRun::string runs, int run_cnt -> int
  setlocal
  set runs=%~1

  if %2 geq 3 (
    set _tmp2=%runs:~3,2%
    set _tmp3=%runs:~6,2%
    if !_tmp2! equ !_tmp3! (
      exit /b 524288 ::ˆê”uŒû
    )
  )
  if %2 equ 4 (
    set _tmp1=%runs:~0,2%
    set _tmp4=%runs:~9,2%
    if !_tmp3! equ !_tmp4! (
      if !_tmp1! equ !_tmp2! if !_tmp2! neq !_tmp3! (
        exit /b 1048576 ::“ñ”uŒû
      )
      exit /b 524288 ::ˆê”uŒû
    )
  )
  if %2 geq 2 (
    if !_tmp1! equ !_tmp2! (
      exit /b 524288 ::ˆê”uŒû
    )
  )

exit /b 0
