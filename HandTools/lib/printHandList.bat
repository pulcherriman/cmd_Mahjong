@echo off
:printHandList::int hand_sum -> int
  rem NowImplementing
  setlocal
  pushd %~dp0
  rem set hand_sum=%1

  set han=0

  if %hand_sum% geq 4194304 (
    set /a tmp=hand_sum ^& 4194304
    if !tmp! neq 0 (
      set /a han+=13
      echo 大三元
    )

    set /a tmp=hand_sum ^& 8388608
    if !tmp! neq 0 (
      set /a han+=13
      echo 小四喜
    )

    set /a tmp=hand_sum ^& 16777216
    if !tmp! neq 0 (
      set /a han+=26
      echo 大四喜
    )

    set /a tmp=hand_sum ^& 33554432
    if !tmp! neq 0 (
      set /a han+=13
      echo 字一色
    )

    set /a tmp=hand_sum ^& 67108864
    if !tmp! neq 0 (
      set /a han+=13
      echo 緑一色
    )

    set /a tmp=hand_sum ^& 134217728
    if !tmp! neq 0 (
      set /a han+=13
      echo 清老頭
    )

    set /a tmp=hand_sum ^& 268435456
    if !tmp! neq 0 (
      set /a han+=13
      echo 四槓子
    )

    set /a tmp=hand_sum ^& 536870912
    if !tmp! neq 0 (
      set /a han+=13
      echo 四暗刻
    )

    set /a tmp=hand_sum ^& 1073741824
    if !tmp! neq 0 (
      set /a han+=13
      echo 九蓮宝燈
    )

    popd && exit /b !han!
  )

  if %hand_sum% equ 0 (
    echo 役なし！
    popd && exit /b 0
  )

  set /a tmp=hand_sum ^& 1
  if %tmp% neq 0 (
    set /a han+=1
    echo 断幺九
  )

  set /a tmp=hand_sum ^& 2
  if %tmp% neq 0 (
    set /a han+=1
    echo 平和
  )

  set /a tmp=hand_sum ^& 4
  if %tmp% neq 0 (
    set /a han+=1
    echo 自風牌
  )

  set /a tmp=hand_sum ^& 8
  if %tmp% neq 0 (
    set /a han+=1
    echo 場風牌
  )

  set /a tmp=hand_sum ^& 16
  if %tmp% neq 0 (
    set /a han+=1
    echo 白
  )

  set /a tmp=hand_sum ^& 32
  if %tmp% neq 0 (
    set /a han+=1
    echo 發
  )

  set /a tmp=hand_sum ^& 64
  if %tmp% neq 0 (
    set /a han+=1
    echo 中
  )

  set /a tmp=hand_sum ^& 128
  if %tmp% neq 0 (
    set /a han+=6
    echo 清一色
  )

  set /a tmp=hand_sum ^& 256
  if %tmp% neq 0 (
    set /a han+=3
    echo 混一色
  )

  set /a tmp=hand_sum ^& 512
  if %tmp% neq 0 (
    set /a han+=3
    echo 純チャン
  )

  set /a tmp=hand_sum ^& 1024
  if %tmp% neq 0 (
    set /a han+=2
    echo チャンタ
  )

  set /a tmp=hand_sum ^& 2048
  if %tmp% neq 0 (
    set /a han+=2
    echo 混老頭
  )

  set /a tmp=hand_sum ^& 4096
  if %tmp% neq 0 (
    set /a han+=2
    echo 対々和
  )

  set /a tmp=hand_sum ^& 8192
  if %tmp% neq 0 (
    set /a han+=2
    echo 三暗刻
  )

  set /a tmp=hand_sum ^& 16384
  if %tmp% neq 0 (
    set /a han+=2
    echo 三色同刻
  )

  set /a tmp=hand_sum ^& 32768
  if %tmp% neq 0 (
    set /a han+=2
    echo 小三元
  )

  set /a tmp=hand_sum ^& 65536
  if %tmp% neq 0 (
    set /a han+=2
    echo 三槓子
  )

  set /a tmp=hand_sum ^& 131072
  if %tmp% neq 0 (
    set /a han+=2
    echo 三色同順
  )

  set /a tmp=hand_sum ^& 262144
  if %tmp% neq 0 (
    set /a han+=2
    echo 一気通貫
  )

  set /a tmp=hand_sum ^& 524288
  if %tmp% neq 0 (
    set /a han+=2
    echo 一盃口
  )

  set /a tmp=hand_sum ^& 1048576
  if %tmp% neq 0 (
    set /a han+=3
    echo 二盃口
  )

  set /a tmp=hand_sum ^& 2097152
  if %tmp% neq 0 (
    echo %tmp%
    echo 未使用ビットが立ってる！！！！！！！！！！！！！！！！！！！！！
  )

popd && exit /b %han%
