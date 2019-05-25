@echo off

choice /n /m "ログを取得しますか？(Y/N)"
if %errorlevel% == 1 call :echoon
if %errorlevel% == 2 call :yMain
exit /b

:echoon
  @echo on
  call :yMain > Ments4.log 2>&1
exit /b

:yInit
  set /a head=0,t_cnt=0,o_cnt=0
  set income=12
  set tp[0]=12
  set tp[1]=12
  set tp[2]=13
  set tp[3]=13
  set tp[4]=14
  set tp[5]=14
  set tp[6]=15
  set tp[7]=15
  set tp[8]=16
  set tp[9]=16
  set tp[10]=17
  set tp[11]=17
  set tp[12]=18
  set tp[13]=18
  for /l %%i in (11,1,47) do (
    set newHand[%%i]=0
    set tmp[%%i]=0
  )
  for /l %%i in (0,1,13) do (
    set /a newHand[!tp[%%i]!]+=1
    set /a tmp[!tp[%%i]!]+=1
  )
  for /l %%i in (0,1,3) do (
    set /a time[%%i]=0,order[%%i]=0
  )
exit /b 0

:yMain
  call Times/get begin

  setlocal enabledelayedexpansion
  call :yInit
  echo 牌姿: %tp[0]% %tp[1]% %tp[2]% %tp[3]% %tp[4]% %tp[5]% %tp[6]% %tp[7]% %tp[8]% %tp[9]% %tp[10]% %tp[11]% %tp[12]% %tp[13]%
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 2 (
      echo.
      echo 雀頭候補: %%i
      echo ------------
      set /a tmp[%%i]-=2,head=%%i
      call :c_Time 0
      call :c_Order
      call :checkUseOut
      if !errorlevel! equ 1 (
        echo.
        echo パターン1
        echo ---------
    	call :updateScore
      )

      call :yInit
      set /a tmp[%%i]-=2,head=%%i
      call :c_Order
      call :c_Time 0
      call :checkUseOut
      if !errorlevel! equ 1 (
        echo.
        echo パターン2
        echo ---------
        call :updateScore
      )

      call :yInit
      set /a tmp[%%i]-=2,head=%%i
      call :c_Time 1
      call :c_Order
      call :c_Time 0
      call :checkUseOut
      if !errorlevel! equ 1 (
        echo.
        echo パターン3
        echo ---------
        call :updateScore
      )
      call :yInit
    )
  )
  call Times/get end
  call Times/print begin end
  call :pause
exit /b 0

:c_Time::int -> void
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 3 (
      set /a tmp[%%i]-=3,time[!t_cnt!]=%%i,t_cnt+=1
      if %1 geq 1 if !t_cnt! equ %1 (
        exit /b
      )
    )
  )
exit /b

:c_Order::void -> void
  for /l %%i in (11,1,37) do (
    set /a n=%%i%%10/8
    if !n! equ 0 (
      call :isOrder %%i
    )
  )
exit /b

:isOrder::int -> void
  set /a j=%1+1,k=%1+2
  :loop_isOrder
  if !tmp[%1]! neq 0 if !tmp[%j%]! neq 0 if !tmp[%k%]! neq 0 (
    set /a tmp[%1]-=1,tmp[%j%]-=1,tmp[%k%]-=1,order[%o_cnt%]=%1,o_cnt+=1
    goto loop_isOrder
  )
exit /b

:checkUseOut::void -> int
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 1 (
      exit /b 0
    )
  )
exit /b 1

:updateScore
  rem NotImplemented
  echo 雀頭: %head%
  set /a t_cnt-=1,o_cnt-=1
  for /l %%i in (0,1,%t_cnt%) do (
    echo 刻子%%i: !time[%%i]!
  )
  for /l %%i in (0,1,%o_cnt%) do (
    echo 順子%%i: !order[%%i]!
  )
exit /b

:pause
 pause > nul
exit /b