:isOutSide::int head, ref int[] time, int endIdxTime, ref int[] order, int endIdxOrder -> int
  setlocal
  rem �����`�F�b�N
  set /a tmp="(1-%1%%10)*(%1%%10%%9)*(%1/10%%10%%4)"
  if %tmp% neq 0 ( exit /b 0 )
  rem ���q�`�F�b�N
  for /l %%n in (1,1,%5) do (
    set /a tmp="(1-%4[%%n]%%10)*(%4[%%n]%%10%%7)"
    if !tmp! neq 0 ( exit /b 0 )
  )
  for /l %%n in (1,1,%3) do (
    set /a tailnum="%2[%%n]%%10"
    if !tailnum! neq 1 if !tailnum! neq 9 if !%2[%%n]! lss 40 ( exit /b 0 )
    if !%2[%%n]! geq 40 ( exit /b 32 ::���S�ћ��)
  )
  if %1 geq 40 ( exit /b 32 ::���S�ћ��)
exit /b 64 ::���S�ћ��
