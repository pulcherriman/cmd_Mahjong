:: 対局を開始
call Structure/Table ctor
call Structure/Players create 1 山田
call Structure/Players create 2 田中
call Structure/Players create 3 佐藤
call Structure/Players create 4 木村


:: 局ごとの処理
call Structure/Table shipai
:: TODO:ワンパイ
call Structure/Players act haipai 1 14
call Structure/Players act haipai 2 27
call Structure/Players act haipai 3 40
call Structure/Players act haipai 4 53

:: 描画
cls
call Structure/Table display_Info
call Structure/Players act display 1 1
call Structure/Players act display 2 2
call Structure/Players act display 3 3
call Structure/Players act display 4 4
pause>nul
