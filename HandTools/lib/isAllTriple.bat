:isAllTriple::int triple_cnt, int pon_cnt, int close_kan_cnt, int open_kan_cnt -> int
  if %1 equ 4 (
    set /a _tmp=%2+%4
    if !_tmp! equ 0 (
      if %3 equ 4 (
        exit /b 805306368 ::�l�Ȏq + �l�Í�
      )
      exit /b 536870912 ::�l�Í�
    ) else (
      set /a _tmp=%3+%4
      if !_tmp! equ 4 (
        exit /b 268435456 ::�l�Ȏq
      )
      exit /b 4096 ::�΁X�a
    )
  )
exit /b 0
