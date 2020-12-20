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
      echo ��O��
    )

    set /a tmp=hand_sum ^& 4194304
    if !tmp! neq 0 (
      set /a han+=13
      echo ���l��
    )

    set /a tmp=hand_sum ^& 8388608
    if !tmp! neq 0 (
      set /a han+=26
      echo ��l��
    )

    set /a tmp=hand_sum ^& 16777216
    if !tmp! neq 0 (
      set /a han+=13
      echo ����F
    )

    set /a tmp=hand_sum ^& 33554432
    if !tmp! neq 0 (
      set /a han+=13
      echo �Έ�F
    )

    set /a tmp=hand_sum ^& 67108864
    if !tmp! neq 0 (
      set /a han+=13
      echo ���V��
    )

    set /a tmp=hand_sum ^& 134217728
    if !tmp! neq 0 (
      set /a han+=13
      echo �l�Ȏq
    )

    set /a tmp=hand_sum ^& 268435456
    if !tmp! neq 0 (
      if %head% equ %winning_tile% (
        set /a han+=26
        echo �l�Í��P�R
      ) else (
        set /a han+=13
        echo �l�Í�
      )
    )

    set /a tmp=hand_sum ^& 536870912
    if !tmp! neq 0 (
      set /a han+=13
      echo ��@��
    )

    set /a tmp=hand_sum ^& 1073741824
    if !tmp! neq 0 (
      set /a han+=26
      echo ������@��
    )

    popd && exit /b !han!
  )

  if %hand_sum% equ 0 (
    echo ���Ȃ��I
    popd && exit /b 0
  )

  if %riichi% equ 1 (
    if %oneshot% neq 0 (
      set /a han+=2
      echo ���[�`
      echo �ꔭ
    ) else (
      set /a han+=1
      echo ���[�`
    )
  )

  if %riichi% equ 2 (
    if %oneshot% neq 0 (
      set /a han+=3
      echo �_�u���[
      echo �ꔭ
    ) else (
      set /a han+=2
      echo �_�u���[
    )
  )

  if %haitei% neq 0 (
    set /a han+=1
    if %self_pick% neq 0 (
      echo �C��̌�
    ) else (
      echo �͒ꝝ��
    )
  )

  if %rinshan% neq 0 (
    set /a han+=1
    echo ���J��
  )

  if %chankan% neq 0 (
    set /a han+=1
    echo ����
  )
  if %self_pick% neq 0 if %open_group_cnt% equ 0 (
    set /a han+=1
    echo �c��
  )

  set /a tmp=hand_sum ^& 1
  if %tmp% neq 0 (
    set /a han+=1
    echo �f���
  )

  set /a tmp=hand_sum ^& 2
  if %tmp% neq 0 (
    set /a han+=1
    echo ���a
  )

  set /a tmp=hand_sum ^& 12
  if %tmp% equ 12 (
    set /a han+=2
    if %table_wind% equ %seat_wind% (
      if %table_wind% equ 41 (
        echo �_�u��
      ) else if %table_wind% equ 42 (
        echo �_�u��
      )
    ) else (
      if %table_wind% equ 41 echo ��
      if %seat_wind% equ 41 echo ��
      if %table_wind% equ 42 echo ��
      if %seat_wind% equ 42 echo ��
      if %seat_wind% equ 43 echo ��
      if %seat_wind% equ 44 echo �k
    )
  )

  if %tmp% equ 4 (
    set /a han+=1
    if %seat_wind% equ 41 (
      echo ��
    ) else if %seat_wind% equ 42 (
      echo ��
    ) else if %seat_wind% equ 43 (
      echo ��
    ) else (
      echo �k
    )
  )

  if %tmp% equ 8 (
    set /a han+=1
    if %table_wind% equ 41 (
      echo ��
    ) else if %table_wind% equ 42 (
      echo ��
    ) else if %table_wind% equ 43 (
      echo ��
    ) else (
      echo �k
    )
  )

  set /a tmp=hand_sum ^& 16
  if %tmp% neq 0 (
    set /a han+=1
    echo ��
  )

  set /a tmp=hand_sum ^& 32
  if %tmp% neq 0 (
    set /a han+=1
    echo �
  )

  set /a tmp=hand_sum ^& 64
  if %tmp% neq 0 (
    set /a han+=1
    echo ��
  )

  set /a tmp=hand_sum ^& 128
  if %tmp% neq 0 (
    set /a han+="6-(^!^!open_group_cnt)"
    echo ����F
  )

  set /a tmp=hand_sum ^& 256
  if %tmp% neq 0 (
    set /a han+="3-(^!^!open_group_cnt)"
    echo ����F
  )

  set /a tmp=hand_sum ^& 512
  if %tmp% neq 0 (
    set /a han+="3-(^!^!open_group_cnt)"
    echo ���`����
  )

  set /a tmp=hand_sum ^& 1024
  if %tmp% neq 0 (
    set /a han+="2-(^!^!open_group_cnt)"
    echo �`�����^
  )

  set /a tmp=hand_sum ^& 2048
  if %tmp% neq 0 (
    set /a han+=2
    echo ���V��
  )

  set /a tmp=hand_sum ^& 4096
  if %tmp% neq 0 (
    set /a han+=2
    echo �΁X�a
  )

  set /a tmp=hand_sum ^& 8192
  if %tmp% neq 0 (
    set /a han+=2
    echo �O�Í�
  )

  set /a tmp=hand_sum ^& 16384
  if %tmp% neq 0 (
    set /a han+=2
    echo �O�F����
  )

  set /a tmp=hand_sum ^& 32768
  if %tmp% neq 0 (
    set /a han+=2
    echo ���O��
  )

  set /a tmp=hand_sum ^& 65536
  if %tmp% neq 0 (
    set /a han+=2
    echo �O�Ȏq
  )

  set /a tmp=hand_sum ^& 131072
  if %tmp% neq 0 (
    set /a han+="2-(^!^!open_group_cnt)"
    echo �O�F����
  )

  set /a tmp=hand_sum ^& 262144
  if %tmp% neq 0 (
    set /a han+="2-(^!^!open_group_cnt)"
    echo ��C�ʊ�
  )

  set /a tmp=hand_sum ^& 524288
  if %tmp% neq 0 (
    set /a han+=1
    echo ��u��
  )

  set /a tmp=hand_sum ^& 1048576
  if %tmp% neq 0 (
    set /a han+=3
    echo ��u��
  )

  set /a tmp=hand_sum ^& (1^<^<31)
  if %tmp% neq 0 (
    echo %hand_sum%
    echo �G���[�I�I�I�I�I�I�I�I�I�I�I�I���g�p�r�b�g�������Ă�I�I�I�I
  )

popd && exit /b %han%
