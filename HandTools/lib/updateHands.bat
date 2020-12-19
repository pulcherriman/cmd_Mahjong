@echo off
:updateHands
  rem NowImplementing
  setlocal
  pushd %~dp0
  set hand_sum_tmp=0
  set triples="%triple[1]% %triple[2]% %triple[3]% %triple[4]%"
  set runs="%run[1]% %run[2]% %run[3]% %run[4]%"

  call isAllTriple %t_cnt% %pon_cnt% %close_kan_cnt% %open_kan_cnt% || set /a hand_sum_tmp^|=!errorlevel!
  echo ‘ÎXŒn: %errorlevel%
  echo ^(‘ÎX: 4096, lˆÃ: 536870912, lÈq: 268435456^)

  if %isAllNum% equ 0 (
    call isHonorTile %triples% %head% %table_wind% %seat_wind% || set /a hand_sum_tmp^|=!errorlevel!
    echo •—”vEOŒ³”vŒn: !errorlevel!
  )

  set /a isAllSimple=hand_sum_tmp ^& 1,isAllTriple=hand_sum_tmp ^& 4096
  if %isAllSimple% equ 0 (
    if %isAllTriple% gtr 0 (
      call isTerminalHonor %head% %triples% %isAllNum% || set /a hand_sum_tmp^|=!errorlevel!
      echo ˜V“ªŒn: !errorlevel!
      echo ^(¬: 2048, ´: 134217728^)
    ) else (
      call isOutSide %head% triple %t_cnt% run %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
      echo ƒ`ƒƒƒ“ƒ^Œn: !errorlevel!
      echo ^(¬: 1024, ‘S: 512^)
    )
  )

  if %r_cnt% geq 3 (
    call isStraightOrThreeColorRuns %runs% %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo OF“¯‡^(131072^) or ˆê’Ê^(262144^): !errorlevel!
  )

  if %r_cnt% geq 2 (
    call isDoubleRun %runs% %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo ˆê”uŒû^(524288^) or “ñ”uŒû^(1048576^): !errorlevel!
  )

  if %t_cnt% geq 3 (
    call isThreeColorTriples %triples% %t_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo OF“¯: !errorlevel!
  )
popd && exit /b %hand_sum_tmp%
