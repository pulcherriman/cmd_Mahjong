:classifyAllTripletWin::int pon_cnt, int close_kan_cnt, int open_kan_cnt, int head, int winning, int self_pick -> int
  setlocal
  set /a open_triplet_cnt=%1+%3
  if %open_triplet_cnt% equ 0 (
    if %2 equ 4 (
      exit /b 402653184 ::�l�Ȏq + �l�Í�
    )
    if %4 neq %5 if %6 equ 0 (
      exit /b 12288 ::�΁X�a + �O�Í�
    )
    exit /b 268435456 ::�l�Í�
  )
  if %open_triplet_cnt% equ 1 (
    if %4 neq %5 if %6 equ 0 (
      exit /b 12288 ::�΁X�a + �O�Í�
    )
    if %6 neq 0 (
      exit /b 12288 ::�΁X�a + �O�Í�
    )
  )
  set /a _tmp=%2+%3
  if !_tmp! equ 4 (
    exit /b 134217728 ::�l�Ȏq
  )
exit /b 4096 ::�΁X�a
