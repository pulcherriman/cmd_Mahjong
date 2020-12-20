@echo off
:printHandList::int hand_sum -> int
  rem NowImplementing
  setlocal
  pushd %~dp0
  rem set hand_sum=%1

  set han=0

  if %hand_sum% geq 2097152 (
    set /a tmp=hand_sum ^& 2097152
    if !tmp! neq 0 (
      set /a han+=13
      echo 大三元
    )

    set /a tmp=hand_sum ^& 4194304
    if !tmp! neq 0 (
      set /a han+=13
      echo 小四喜
    )

    set /a tmp=hand_sum ^& 8388608
    if !tmp! neq 0 (
      set /a han+=26
      echo 大四喜
    )

    set /a tmp=hand_sum ^& 16777216
    if !tmp! neq 0 (
      set /a han+=13
      echo 字一色
    )

    set /a tmp=hand_sum ^& 33554432
    if !tmp! neq 0 (
      set /a han+=13
      echo 緑一色
    )

    set /a tmp=hand_sum ^& 67108864
    if !tmp! neq 0 (
      set /a han+=13
      echo 清老頭
    )

    set /a tmp=hand_sum ^& 134217728
    if !tmp! neq 0 (
      set /a han+=13
      echo 四槓子
    )

    set /a tmp=hand_sum ^& 268435456
    if !tmp! neq 0 (
      if %head% equ %winning_tile% (
        set /a han+=26
        echo 四暗刻単騎
      ) else (
        set /a han+=13
        echo 四暗刻
      )
    )

    set /a tmp=hand_sum ^& 536870912
    if !tmp! neq 0 (
      set /a han+=13
      echo 九蓮宝燈
    )

    set /a tmp=hand_sum ^& 1073741824
    if !tmp! neq 0 (
      set /a han+=26
      echo 純正九蓮宝燈
    )

    popd && exit /b !han!
  )

  if %hand_sum% equ 0 (
    echo 役なし！
    popd && exit /b 0
  )

  if %riichi% equ 1 (
    if %oneshot% neq 0 (
      set /a han+=2
      echo リーチ
      echo 一発
    ) else (
      set /a han+=1
      echo リーチ
    )
  )

  if %riichi% equ 2 (
    if %oneshot% neq 0 (
      set /a han+=3
      echo ダブリー
      echo 一発
    ) else (
      set /a han+=2
      echo ダブリー
    )
  )

  if %haitei% neq 0 (
    set /a han+=1
    if %self_pick% neq 0 (
      echo 海底摸月
    ) else (
      echo 河底撈魚
    )
  )

  if %rinshan% neq 0 (
    set /a han+=1
    echo 嶺上開花
  )

  if %chankan% neq 0 (
    set /a han+=1
    echo 搶槓
  )
  if %self_pick% neq 0 if %open_group_cnt% equ 0 (
    set /a han+=1
    echo ツモ
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

  set /a tmp=hand_sum ^& 12
  if %tmp% equ 12 (
    set /a han+=2
    if %table_wind% equ %seat_wind% (
      if %table_wind% equ 41 (
        echo ダブ東
      ) else if %table_wind% equ 42 (
        echo ダブ南
      )
    ) else (
      if %table_wind% equ 41 echo 東
      if %seat_wind% equ 41 echo 東
      if %table_wind% equ 42 echo 南
      if %seat_wind% equ 42 echo 南
      if %seat_wind% equ 43 echo 西
      if %seat_wind% equ 44 echo 北
    )
  )

  if %tmp% equ 4 (
    set /a han+=1
    if %seat_wind% equ 41 (
      echo 東
    ) else if %seat_wind% equ 42 (
      echo 南
    ) else if %seat_wind% equ 43 (
      echo 西
    ) else (
      echo 北
    )
  )

  if %tmp% equ 8 (
    set /a han+=1
    if %table_wind% equ 41 (
      echo 東
    ) else if %table_wind% equ 42 (
      echo 南
    ) else if %table_wind% equ 43 (
      echo 西
    ) else (
      echo 北
    )
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
    set /a han+="6-(^!^!open_group_cnt)"
    echo 清一色
  )

  set /a tmp=hand_sum ^& 256
  if %tmp% neq 0 (
    set /a han+="3-(^!^!open_group_cnt)"
    echo 混一色
  )

  set /a tmp=hand_sum ^& 512
  if %tmp% neq 0 (
    set /a han+="3-(^!^!open_group_cnt)"
    echo 純チャン
  )

  set /a tmp=hand_sum ^& 1024
  if %tmp% neq 0 (
    set /a han+="2-(^!^!open_group_cnt)"
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
    set /a han+="2-(^!^!open_group_cnt)"
    echo 三色同順
  )

  set /a tmp=hand_sum ^& 262144
  if %tmp% neq 0 (
    set /a han+="2-(^!^!open_group_cnt)"
    echo 一気通貫
  )

  set /a tmp=hand_sum ^& 524288
  if %tmp% neq 0 (
    set /a han+=1
    echo 一盃口
  )

  set /a tmp=hand_sum ^& 1048576
  if %tmp% neq 0 (
    set /a han+=3
    echo 二盃口
  )

  set /a tmp=hand_sum ^& (1^<^<31)
  if %tmp% neq 0 (
    echo %hand_sum%
    echo エラー！！！！！！！！！！！！未使用ビットが立ってる！！！！
  )

popd && exit /b %han%
