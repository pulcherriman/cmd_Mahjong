@echo off
:updateHands
  rem NowImplementing
  setlocal
  pushd %~dp0
  set hand_sum_tmp=0
  set triplets="%triplet[1]% %triplet[2]% %triplet[3]% %triplet[4]%"
  set runs="%run[1]% %run[2]% %run[3]% %run[4]%"

  if %t_cnt% equ 4 (
    call classifyAllTripletWin %pon_cnt% %close_kan_cnt% %open_kan_cnt% %head% %winning_tile% %self_pick% || set /a hand_sum_tmp^|=!errorlevel!
    echo 対々系: %errorlevel%
    echo ^(対々: 4096, 三暗刻: 8192, 四暗刻: 536870912, 四槓子: 268435456^)
  ) else if %t_cnt% equ 3 (
    call isThreeClosedTriplets %pon_cnt% %open_kan_cnt% %head% %winning_tile% %self_pick% || set /a hand_sum_tmp^|=!errorlevel!
    echo 三暗刻^(8192^): %errorlevel%
  )

  if %isAllNum% equ 0 (
    call isHonorTile %triplets% %head% %table_wind% %seat_wind% || set /a hand_sum_tmp^|=!errorlevel!
    echo 風牌・三元牌系: !errorlevel!
  )

  set /a isAllSimple=hand_sum_tmp ^& 1,isAllTriplet=hand_sum_tmp ^& 4096
  if %isAllSimple% equ 0 (
    if %isAllTriplet% gtr 0 (
      call isTerminalHonor %head% %triplets% %isAllNum% || set /a hand_sum_tmp^|=!errorlevel!
      echo 老頭系: !errorlevel!
      echo ^(混: 2048, 清: 134217728^)
    ) else (
      call isOutSide %head% triplet %t_cnt% run %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
      echo チャンタ系: !errorlevel!
      echo ^(混: 1024, 全: 512^)
    )
  )

  if %r_cnt% equ 4 if %chi_cnt% equ 0 (
    call isNPHand %runs% %head% %winning_tile% %table_wind% %seat_wind% || set /a hand_sum_tmp^|=!errorlevel!
    echo 平和: !errorlevel!
  )

  if %r_cnt% geq 3 (
    call isStraightOrThreeColorRuns %runs% %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo 三色同順^(131072^) or 一通^(262144^): !errorlevel!
  )

  if %r_cnt% geq 2 (
    call isDoubleRun %runs% %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo 一盃口^(524288^) or 二盃口^(1048576^): !errorlevel!
  )

  if %t_cnt% geq 3 (
    call isThreeColorTriplets %triplets% %t_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo 三色同刻: !errorlevel!
    call isThreeQuads %close_kan_cnt% %open_kan_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo 三槓子: !errorlevel!
  )
popd && exit /b %hand_sum_tmp%
