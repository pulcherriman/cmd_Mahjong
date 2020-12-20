:isNPHand::string runs, int head, int winning_tile, int table_wind int seat_wind -> int
  setlocal
  set runs=%~1

  if %2 equ %4 (
    exit /b 0
  ) else if %2 equ %5 (
    exit /b 0
  ) else if %2 geq 45 (
    exit /b 0
  )
  for %%r in (%runs%) do (
    if %%r equ %3 (
      exit /b 2 ::•½˜a
    )
    set /a _tmp=%%r+2
    if !_tmp! equ %3 (
      exit /b 2 ::•½˜a
    )
  )
exit /b 0
