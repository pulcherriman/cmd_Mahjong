:classifyAllTripletWin::int pon_cnt, int close_kan_cnt, int open_kan_cnt, int head, int winning, int self_pick -> int
  setlocal
  set /a open_triplet_cnt=%1+%3
  if %open_triplet_cnt% equ 0 (
    if %2 equ 4 (
      exit /b 402653184 ::四槓子 + 四暗刻
    )
    if %4 neq %5 if %6 equ 0 (
      exit /b 12288 ::対々和 + 三暗刻
    )
    exit /b 268435456 ::四暗刻
  )
  if %open_triplet_cnt% equ 1 (
    if %4 neq %5 if %6 equ 0 (
      exit /b 12288 ::対々和 + 三暗刻
    )
    if %6 neq 0 (
      exit /b 12288 ::対々和 + 三暗刻
    )
  )
  set /a _tmp=%2+%3
  if !_tmp! equ 4 (
    exit /b 134217728 ::四槓子
  )
exit /b 4096 ::対々和
