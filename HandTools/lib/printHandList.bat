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
      echo ��O��
    )

    set /a tmp=hand_sum ^& 8388608
    if !tmp! neq 0 (
      set /a han+=13
      echo ���l��
    )

    set /a tmp=hand_sum ^& 16777216
    if !tmp! neq 0 (
      set /a han+=26
      echo ��l��
    )

    set /a tmp=hand_sum ^& 33554432
    if !tmp! neq 0 (
      set /a han+=13
      echo ����F
    )

    set /a tmp=hand_sum ^& 67108864
    if !tmp! neq 0 (
      set /a han+=13
      echo �Έ�F
    )

    set /a tmp=hand_sum ^& 134217728
    if !tmp! neq 0 (
      set /a han+=13
      echo ���V��
    )

    set /a tmp=hand_sum ^& 268435456
    if !tmp! neq 0 (
      set /a han+=13
      echo �l�Ȏq
    )

    set /a tmp=hand_sum ^& 536870912
    if !tmp! neq 0 (
      set /a han+=13
      echo �l�Í�
    )

    set /a tmp=hand_sum ^& 1073741824
    if !tmp! neq 0 (
      set /a han+=13
      echo ��@��
    )

    popd && exit /b !han!
  )

  if %hand_sum% equ 0 (
    echo ���Ȃ��I
    popd && exit /b 0
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

  set /a tmp=hand_sum ^& 4
  if %tmp% neq 0 (
    set /a han+=1
    echo �����v
  )

  set /a tmp=hand_sum ^& 8
  if %tmp% neq 0 (
    set /a han+=1
    echo �ꕗ�v
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
    set /a han+=6
    echo ����F
  )

  set /a tmp=hand_sum ^& 256
  if %tmp% neq 0 (
    set /a han+=3
    echo ����F
  )

  set /a tmp=hand_sum ^& 512
  if %tmp% neq 0 (
    set /a han+=3
    echo ���`����
  )

  set /a tmp=hand_sum ^& 1024
  if %tmp% neq 0 (
    set /a han+=2
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
    set /a han+=2
    echo �O�F����
  )

  set /a tmp=hand_sum ^& 262144
  if %tmp% neq 0 (
    set /a han+=2
    echo ��C�ʊ�
  )

  set /a tmp=hand_sum ^& 524288
  if %tmp% neq 0 (
    set /a han+=2
    echo ��u��
  )

  set /a tmp=hand_sum ^& 1048576
  if %tmp% neq 0 (
    set /a han+=3
    echo ��u��
  )

  set /a tmp=hand_sum ^& 2097152
  if %tmp% neq 0 (
    echo %tmp%
    echo ���g�p�r�b�g�������Ă�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I�I
  )

popd && exit /b %han%
