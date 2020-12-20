@echo off

:handMain
  setlocal enabledelayedexpansion
  pushd %~dp0
  call ../Times/get begin
  call :handInit
  call :printCondition

  set base_hand_sum=0

  call :isAllNum "%haisi%" & set /a isAllNum=!errorlevel!

  if %isAllNum% equ 1 (
    call lib/isAllSimple || set /a base_hand_sum^|=!errorlevel!
    echo タンヤオ: !errorlevel!
  )

  call lib/isFlush tp 13 0 %winning_tile% %open_group_cnt% %close_kan_cnt% || set /a base_hand_sum^|=!errorlevel!
  echo 一色系: %errorlevel%
  echo ^(混: 256, 清: 128, 字: 33554432, 緑: 67108864^)

  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 2 (
      set /a tmp[%%i]-=2,head=%%i
      call :c_Triple 0
      call :c_Run
      call :checkUseOut
      rem 将来的には call :checkUseOut || call :updateHands に置き換えられる
      if errorlevel 1 (
        echo.
        echo パターン1
        echo ---------
        call :printFormation
        call lib/updateHands & set /a hand_sum="base_hand_sum|!errorlevel!"
        echo 役合計値: !hand_sum!
        echo.
        call lib/printHandList !hand_sum! & set han_value=!errorlevel!
        echo !han_value! 翻
      )
      call :handInit
      set /a tmp[%%i]-=2,head=%%i
      call :c_Run
      call :c_Triple 0
      call :checkUseOut
      rem 将来的には call :checkUseOut || call :updateHands に置き換えられる
      if errorlevel 1 (
        echo.
        echo パターン2
        echo ---------
        call :printFormation
        call lib/updateHands & set /a hand_sum="base_hand_sum|!errorlevel!"
        echo 役合計値: !hand_sum!
        echo.
        call lib/printHandList !hand_sum! & set han_value=!errorlevel!
        echo !han_value! 翻
        )
      call :handInit
      set /a tmp[%%i]-=2,head=%%i
      call :c_Triple 1
      call :c_Run
      call :c_Triple 0
      call :checkUseOut
      rem 将来的には call :checkUseOut || call :updateHands に置き換えられる
      if errorlevel 1 (
        echo.
        echo パターン3
        echo ---------
        call :printFormation
        call lib/updateHands & set /a hand_sum="base_hand_sum|!errorlevel!"
        echo 役合計値: !hand_sum!
        echo.
        call lib/printHandList !hand_sum! & set han_value=!errorlevel!
        echo !han_value! 翻
      )
      call :handInit
    )
  )
  echo.
  call ../Times/get end
  call ../Times/print begin end
exit /b 0

:handInit
  set /a pon_cnt=1,chi_cnt=0,close_kan_cnt=0,open_kan_cnt=0
  set /a table_wind=41,seat_wind=41,riichi=0,oneshot=0,self_pick=0,haitei=0,rinshan=0,chankan=0
  rem フラグ変数: 場家リーチ一発ツモ海底嶺上槍槓の順↑
  set winning_tile=11
  set tp[0]=11
  set tp[1]=11
  set tp[2]=11
  set tp[3]=12
  set tp[4]=12
  set tp[5]=13
  set tp[6]=14
  set tp[7]=15
  set tp[8]=16
  set tp[9]=17
  set tp[10]=18
  set tp[11]=19
  set tp[12]=19
  set tp[13]=19
  set /a head=0,t_cnt=0,r_cnt=0,open_group_cnt=pon_cnt+chi_cnt+open_kan_cnt
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
    set triplet[%%i]=
    set     run[%%i]=
  )
exit /b 0

:c_Triple::int -> void
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 3 (
      set /a tmp[%%i]-=3,t_cnt+=1
      set /a triplet[!t_cnt!]=%%i
      if %1 geq 1 if !t_cnt! equ %1 (
        exit /b
      )
    )
  )
exit /b

:c_Run::void -> void
  for /l %%i in (11,1,37) do (
    set /a n=%%i%%10/8
    if !n! equ 0 (
      call :isRun %%i
    )
  )
exit /b

:isRun::int -> void
  set /a j=%1+1,k=%1+2
  :loop_isRun
  if !tmp[%1]! geq 1 if !tmp[%j%]! geq 1 if !tmp[%k%]! geq 1 (
    set /a tmp[%1]-=1,tmp[%j%]-=1,tmp[%k%]-=1,r_cnt+=1
    set /a run[!r_cnt!]=%1
    goto loop_isRun
  )
exit /b

:checkUseOut::void -> int
  for /l %%i in (11,1,47) do (
    if !tmp[%%i]! geq 1 (
      exit /b 0
    )
  )
exit /b 1

:printFormation::void -> void
  echo 雀頭: %head%
  for /l %%i in (1,1,%t_cnt%) do (
    echo 刻子%%i: !triplet[%%i]!
  )
  for /l %%i in (1,1,%r_cnt%) do (
    echo 順子%%i: !run[%%i]!
  )
exit /b

:printCondition::void -> void
  setlocal
  echo 牌姿: %haisi%

  if %self_pick% equ 0 (
    set win_type=ロン
  ) else (
    set win_type=ツモ
  )
  echo %win_type%: %winning_tile%
  echo 鳴き回数: ポン %pon_cnt% 回, チー %chi_cnt% 回, 暗槓 %close_kan_cnt% 回, 明槓 %open_kan_cnt% 回

  if %riichi% equ 1 (
    set disp_riichi=リーチ
  ) else if %riichi% equ 2 (
    set disp_riichi=ダブリー
  )
  if %oneshot% neq 0 (
    set disp_oneshot=一発
  )
  if %haitei% neq 0 (
    set disp_haitei=海底or河底
  )
  if %rinshan% neq 0 (
    set disp_rinshan=嶺上開花
  )
  if %chankan% neq 0 (
    set disp_chankan=槍槓
  )
  echo 状況: %disp_riichi% %disp_oneshot% %disp_haitei% %disp_rinshan% %disp_chankan%
  echo -------------------
  echo.
exit /b

:isAllNum::string haisi -> bool
  setlocal
  for %%h in (%~1) do (
    if %%h geq 40 exit /b 0
  )
exit /b 1
