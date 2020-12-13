@echo off
:updateHands
  rem NowImplementing
  setlocal
  pushd %~dp0
  set hand_sum_tmp=0

  call isAllTriple %t_cnt% %pon_cnt% %close_kan_cnt% %open_kan_cnt% || set /a hand_sum_tmp^|=!errorlevel!
  echo 対々系: %errorlevel%
  echo ^(対々: 4096, 四暗刻: 536870912, 四槓子: 268435456^)

  set /a isAllSimple=hand_sum_tmp ^& 1,isAllTriple=hand_sum_tmp ^& 4096
  if %isAllSimple% equ 0 (
    if %isAllTriple% gtr 0 (
      set triples=%triple[1]% %triple[2]% %triple[3]% %triple[4]%
      call isTerminalHonor %head% "!triples!" || set /a hand_sum_tmp^|=!errorlevel!
      echo 老頭系: !errorlevel!
      echo ^(混: 2048, 清: 134217728^)
    ) else (
      call isOutSide %head% triple %t_cnt% run %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
      echo チャンタ系: !errorlevel!
      echo ^(混: 1024, 全: 512^)
    )
  )

  if %r_cnt% geq 3 (
    set runs=%run[1]% %run[2]% %run[3]% %run[4]%
    call isStraightOrThreeColorRuns "!runs!" %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo 三色同順^(131072^) or 一通^(262144^): !errorlevel!
  )

  if %r_cnt% geq 2 (
    set runs=%run[1]% %run[2]% %run[3]% %run[4]%
    call isDoubleRun "!runs!" %r_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo 一盃口^(524288^) or 二盃口^(1048576^): !errorlevel!
  )

  if %t_cnt% geq 3 (
    set triples=%triple[1]% %triple[2]% %triple[3]% %triple[4]%
    call isThreeColorTriples "!triples!" %t_cnt% || set /a hand_sum_tmp^|=!errorlevel!
    echo 三色同刻: !errorlevel!
  )
popd && exit /b %hand_sum_tmp%
