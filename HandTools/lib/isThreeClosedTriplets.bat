:isThreeClosedTriplets::int pon_cnt, int open_kan_cnt, int head, int winning, int self_pick -> int
  setlocal
  rem �����ł͏��q��1�����c�܂܂�Ă���ꍇ�̎O�Í�����̂ݍs���B�΁X�a�ƕ�������ꍇ�̎O�Í������ classifyAllTripletWin �ōs���B
  set /a open_triplet_cnt=%1+%2
  if %open_triplet_cnt% neq 0 (
    exit /b 0
  )
  if %3 equ %4 (
    exit /b 8192 ::�O�Í�
  ) else if %5 neq 0 (
    exit /b 8192 ::�O�Í�
  )

exit /b 0
