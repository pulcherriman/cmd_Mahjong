:yMain::ref int[14] tp, ref int income -> void
  setlocal enabledelayedexpansion
  call :yInit %1 %2
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 2 (
      set /a tmp[%%i]-=2,head=%%i
      call :c_Time 0
      call :c_Order
      call :checkUseOut
      if !errorlevel! equ 1 (
        call :updateScore
      )
      call :yInit %1 %2
      set /a tmp[%%i]-=2,head=%%i
      call :c_Order
      call :c_Time 0
      call :checkUseOut
      if !errorlevel! equ 1 (
        call :updateScore
      )
      call :yInit %1 %2
      set /a tmp[%%i]-=2,head=%%i
      call :c_Time 1
      call :c_Order
      call :c_Time 0
      call :checkUseOut
      if !errorlevel! equ 1 (
        call :updateScore
      )
      call :yInit %1 %2
    )
  )
exit /b 0

:yInit::ref int[14] tp, ref int income -> void
  set /a head=0,t_cnt=0,o_cnt=0
  set income=!%2!
  for /l %%i in (11,1,47) do (
    set newHand[%%i]=0
    set tmp[%%i]=0
  )
  for /l %%i in (0,1,13) do (
    set /a newHand[!%1[%%i]!]+=1
    set /a tmp[!%1[%%i]!]+=1
  )
  for /l %%i in (0,1,3) do (
    set /a time[%%i]=0,order[%%i]=0
  )
exit /b 0

:c_Time::int -> void
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 3 (
      set /a tmp[%%i]-=3,time[!t_cnt!]=%%i,t_cnt+=1
      if %1 geq 1 if !t_cnt! equ %1 (
        goto exit_c_Time
      )
    )
  )
  :exit_c_Time
exit /b

:c_Order::void -> void
  for /l %%i in (11,1,37) do (
    set /a n=%%i%%10
    if !n! leq 7 (
      call :isOrder %%i
    )
  )
exit /b

:isOrder::int -> void
  set /a i=%1,j=%1+1,k=%1+2
  :loop_isOrder
  if !tmp[%i%]! geq 1 if !tmp[%j%]! geq 1 if !tmp[%k%]! geq 1 (
    set /a tmp[%i%]-=1,tmp[%j%]-=1,tmp[%k%]-=1,order[%o_cnt%]=%i%,o_cnt+=1
    goto loop_isOrder
  )
exit /b

:checkUseOut::void -> int
  setlocal
  set n=1
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 1 (
      set n=0
    )
  )
exit /b %n%

:updateScore
  rem NotImplemented
  echo “ª: %head%
  set /a t_cnt-=1,o_cnt-=1
  for /l %%i in (0,1,%t_cnt%) do (
    echo Žq%%i: !time[%%i]!
  )
  for /l %%i in (0,1,%o_cnt%) do (
    echo ‡Žq%%i: !order[%%i]!
  )
exit /b

:pause
  pause > nul
exit /b
