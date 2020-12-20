
:: 対局を開始
call Structure/Players ctor

:: TODO: そのうち定数ではなくしたい
call Structure/Players create 10001 CPU1
call Structure/Players create 10002 CPU2
call Structure/Players create 10003 CPU3
call Structure/Players create 1 Player
call Structure/Table ctor $Players.Id
call Structure/Table set_player 1

:: 親決め
call Utils/Display Cls
call Structure/Table display_Players
call Structure/Table decide_Chicha

:: 局ごとの処理
call Structure/Table start_section

:: 描画
call Structure/Table display_Info

call Utils/Display pause ここから先は開発中です。何かキーを押すとトップに戻ります。

