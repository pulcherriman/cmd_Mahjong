@echo off
:updateHands
  rem NowImplementing
  setlocal
  pushd %~dp0
  set hand_sum_tmp=0

  call isAllTriple %t_cnt% || set /a hand_sum_tmp^|=!errorlevel!
  echo ‘ÎX: %errorlevel%

  set /a isAllSimple=hand_sum_tmp ^& 1,isAllTriple=hand_sum_tmp ^& 2048
  if %isAllSimple% equ 0 (
    if %isAllTriple% gtr 0 (
      set times=%time[1]% %time[2]% %time[3]% %time[4]%
      call isTerminalHonor %head% "!times!" || set /a hand_sum_tmp^|=!errorlevel!
      echo ˜V“ªŒn: !errorlevel!
    ) else (
      call isOutSide %head% time %t_cnt% order %o_cnt% || set /a hand_sum_tmp^|=!errorlevel!
      echo ‘S‘ÑŒn: !errorlevel!
    )
  )

  if %o_cnt% geq 3 (
    set orders=%order[1]% %order[2]% %order[3]% %order[4]%
    call isStraight "!orders!" %o_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo ˆê’Ê: !errorlevel!
  )
popd && exit /b %hand_sum_tmp%
