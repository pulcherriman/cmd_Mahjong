:isFlush::ref int[] tp, int endIdx, bool is7Pairs, int winning_tile, int open_group_cnt, int close_kan_cnt -> int
  setlocal
  set /a is7Pairs=%3,fst_tp=%1[0],fst_color="fst_tp/10%%10"
  if %fst_tp% geq 40 exit /b 16777216 ::字一色
  for /l %%i in (1,1,%2) do (
    set /a color="%1[%%i]/10%%10"
    if !color! neq %fst_color% (
      if !color! neq 4 ( exit /b 0 )
      if %is7Pairs% == 1 ( exit /b 256 ::混一色 )
      if %fst_color% == 3 if !%1[%%i]! == 46 (
        call %~dp0isAllGreen
        if errorlevel 1 exit /b 33554432 ::緑一色
      )
      exit /b 256 ::混一色
    )
  )
  if !color! == 3 (
    call %~dp0isAllGreen
    if errorlevel 1 exit /b 33554432 ::緑一色
  )

  if %5%6 neq 00 (
    exit /b 128 ::清一色
  )
  set _tmp=!%1[0]:~-1!!%1[1]:~-1!!%1[2]:~-1!!%1[11]:~-1!!%1[12]:~-1!!%1[13]:~-1!
  if %_tmp% neq 111999 exit /b 128 ::清一色
  set /a tempint=234567891-!%1[3]:~-1!!%1[4]:~-1!!%1[5]:~-1!!%1[6]:~-1!!%1[7]:~-1!!%1[8]:~-1!!%1[9]:~-1!!%1[10]:~-1!0
  if 1%tempint:1=% neq 1 exit /b 128 ::清一色
  set /a d=%4%%10-(10%tempint:1=-1%)
  if %d% equ 0 exit /b 1073741824 ::純正九蓮宝燈
exit /b 536870912 ::九蓮宝燈

