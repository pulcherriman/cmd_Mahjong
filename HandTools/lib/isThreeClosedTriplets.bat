:isThreeClosedTriplets::int pon_cnt, int open_kan_cnt, int head, int winning, int self_pick -> int
  setlocal
  rem ここでは順子が1メンツ含まれている場合の三暗刻判定のみ行う。対々和と複合する場合の三暗刻判定は classifyAllTripletWin で行う。
  set /a open_triplet_cnt=%1+%2
  if %open_triplet_cnt% neq 0 (
    exit /b 0
  )
  if %3 equ %4 (
    exit /b 8192 ::三暗刻
  ) else if %5 neq 0 (
    exit /b 8192 ::三暗刻
  )

exit /b 0
