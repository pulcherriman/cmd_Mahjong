
:: �΋ǂ��J�n
call Structure/Players ctor

:: TODO: ���̂����萔�ł͂Ȃ�������
call Structure/Players create 10001 CPU1
call Structure/Players create 10002 CPU2
call Structure/Players create 10003 CPU3
call Structure/Players create 1 Player
call Structure/Table ctor $Players.Id
call Structure/Table set_player 1

:: �e����
call Utils/Display Cls
call Structure/Table display_Players
call Structure/Table decide_Chicha

:: �ǂ��Ƃ̏���
call Structure/Table start_section

:: �`��
call Structure/Table display_Info

call Utils/Display pause ���������͊J�����ł��B�����L�[�������ƃg�b�v�ɖ߂�܂��B

