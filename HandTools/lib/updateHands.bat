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
      set triples=%triple[1]% %triple[2]% %triple[3]% %triple[4]%
      call isTerminalHonor %head% "!triples!" || set /a hand_sum_tmp^|=!errorlevel!
      echo ˜V“ªŒn: !errorlevel!
    ) else (
      call isOutSide %head% triple %t_cnt% run %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
      echo ‘S‘ÑŒn: !errorlevel!
    )
  )

  if %r_cnt% geq 3 (
    set runs=%run[1]% %run[2]% %run[3]% %run[4]%
    call isStraightOrThreeColorRuns "!runs!" %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo OF“¯‡^(128^) or ˆê’Ê^(256^): !errorlevel!
  )

  if %r_cnt% geq 2 (
    set runs=%run[1]% %run[2]% %run[3]% %run[4]%
    call isDoubleRun "!runs!" %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo ˆê”uŒû^(512^) or “ñ”uŒû^(32768^): !errorlevel!
  )
popd && exit /b %hand_sum_tmp%
