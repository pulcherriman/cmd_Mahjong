@echo off

:handMain
  setlocal enabledelayedexpansion
  call %~dp0../Times/get begin
  call :handInit
  echo 牌姿: %haisi%
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 2 (
      echo.
      echo 雀頭候補: %%i
      echo ------------
      set /a tmp[%%i]-=2,head=%%i
      call :c_Time 0
      call :c_Order
      call :checkUseOut
      if errorlevel 1 (
        echo.
        echo パターン1
        echo ---------
        call :updateScore
      )
      call :handInit
      set /a tmp[%%i]-=2,head=%%i
      call :c_Order
      call :c_Time 0
      call :checkUseOut
      if errorlevel 1 (
        echo.
        echo パターン2
        echo ---------
        call :updateScore
        )
      call :handInit
      set /a tmp[%%i]-=2,head=%%i
      call :c_Time 1
      call :c_Order
      call :c_Time 0
      call :checkUseOut
      if errorlevel 1 (
        echo.
        echo パターン3
        echo ---------
        call :updateScore
      )
      call :handInit
    )
  )
  call %~dp0../Times/get end
  call %~dp0../Times/print begin end
exit /b 0

:handInit
  set /a head=0,t_cnt=0,o_cnt=0
  set income=22
  set tp[0]=11
  set tp[1]=12
  set tp[2]=13
  set tp[3]=17
  set tp[4]=18
  set tp[5]=19
  set tp[6]=21
  set tp[7]=22
  set tp[8]=23
  set tp[9]=31
  set tp[10]=31
  set tp[11]=44
  set tp[12]=44
  set tp[13]=44
  set haisi=%tp[0]% %tp[1]% %tp[2]% %tp[3]% %tp[4]% %tp[5]% %tp[6]% %tp[7]% %tp[8]% %tp[9]% %tp[10]% %tp[11]% %tp[12]% %tp[13]%
  for /l %%i in (11,1,47) do (
    set newHand[%%i]=0
    set tmp[%%i]=0
  )
  for %%i in (%haisi%) do (
    set /a newHand[%%i]+=1
    set /a tmp[%%i]+=1
  )
  for /l %%i in (1,1,4) do (
    set  time[%%i]=
    set order[%%i]=
  )
exit /b 0


:c_Time::int -> void
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 3 (
      set /a tmp[%%i]-=3,t_cnt+=1
      set /a time[!t_cnt!]=%%i
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
  if !tmp[%1]! geq 1 if !tmp[%j%]! geq 1 if !tmp[%k%]! geq 1 (
    set /a tmp[%1]-=1,tmp[%j%]-=1,tmp[%k%]-=1,o_cnt+=1
    set /a order[!o_cnt!]=%1
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
  rem NowImplementing
  echo 雀頭: %head%
  for /l %%i in (1,1,%t_cnt%) do (
    echo 刻子%%i: !time[%%i]!
  )
  for /l %%i in (1,1,%o_cnt%) do (
    echo 順子%%i: !order[%%i]!
  )
  set handSum=0
  call :isAllNum tp 13
  set /a isAllNum=%errorlevel%
  call %~dp0lib/isAllSimple && set /a handSum^|=!errorlevel!
  echo タンヤオ: %errorlevel%
  call %~dp0lib/isSingleColor tp 13 0 && set /a handSum^|=!errorlevel!
  echo 一色系: %errorlevel%
  call %~dp0lib/isAllTriple %t_cnt% && set /a handSum^|=!errorlevel!
  echo 対々: %errorlevel%
  set /a isAllSimple=handSum ^& 1,isAllTriple=handSum ^& 2048
  if %isAllSimple% equ 0 (
    if %isAllTriple% gtr 0 (
      set times="%time[1]% %time[2]% %time[3]% %time[4]%"
      call %~dp0lib/isTerminalHonor %head% !times! && set /a handSum^|=!errorlevel!
      echo 老頭系: !errorlevel!
    ) else (
      call %~dp0lib/isOutSide %head% time %t_cnt% order %o_cnt% && set /a handSum^|=!errorlevel!
      echo 全帯系: !errorlevel!
    )
  )
  echo %handSum%
exit /b

:isAllNum::ref int[] tp, int endIdx -> bool
  setlocal
  for /l %%i in (end,-1,0) do (
    if !%1[%%i]! geq 40 exit /b 0
  )
exit /b 1
