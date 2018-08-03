@echo off
setlocal enabledelayedexpansion
cd /d %~dp0
echo %random%>nul

rem main関数群。再帰の都合上分割。
:Main
rem 初期化、トップ画面まで
	mode con cols=90 lines=25
	call :FolderSearch %1
	call :YamaSet
	call :Initialize
	call :Cursor 0 4
	call :Top

:Main2
rem 局の進行、洗牌、初回だけ全員分の理牌
	call :NextRound
	call :Sipai
	call :AllRipai

:Main3
rem 手番の移動、ツモ
	call :NextTurn
	call :Tumo
	call :Tehai%aiturn%
	if %nokori% == 0 (
		call :Ryukyoku
		goto Main2
	)
	call :PonJudge %turn%
	goto Main3

:Top
	cls
	if %testmode% == 0 (
		set tempstr1=
	) else set tempstr1=test mode
	echo 麻雀 ver.%version%  %tempstr1%
	echo  %cursor[1]%対局開始 %cursor[2]%ログ取得 %cursor[3]%バージョン情報 %cursor[4]%終了
	choice /c adws >nul
	set selected=%errorlevel%
	if %selected% leq 2 (
		call :Cursor %selected%
		goto Top
	)
	if %selected% == 4 (
		set /a testmode+=1,testmode%%=2
		goto Top
	)
	if %cursor% == 4 exit
	if %cursor% == 3 (
		call version.bat
		goto Main
	)
	if %cursor% == 2 call :logging Main2
	exit /b

:Initialize
rem 半荘ごとに設定する変数
	set player=4
	set gamecount=41
	set kyoku=0
	set tumibou=0
	set tumiboureset=1
	set cursor=1
	set testmode=0
	set EPstr=〇一二三四五六七八九無①②③④⑤⑥⑦⑧⑨無１２３４５６７８９無東南西北白發中無無無　
	for /l %%i in (1,1,14) do set cursor[%%i]=　
	call :Roll
	exit /b

:FolderSearch
	for /f "tokens=2" %%i in ('findstr /n "β" "%cd%\version.bat"') do set version=%%i
	set tempint1=0
	set tempstr1=%cd%
	for /l %%a in (1,1,100) do (
		for /f "delims=\" %%b in ("!tempstr1!") do (
			if "%%b" neq "" (
				set foldername[%%a]=%%b
				set tempstr1=!tempstr1:%%b=!
				set /a tempint1+=1
			) else goto FolderSearch2
		)
	)
:FolderSearch2
	if not "MJ%version%" == "!foldername[%tempint1%]!" call testmode.bat "%cd%" %version%
	pushd ..
	if "%1" == "ren" del /q "%cd%\renaming.bat">nul
	popd
	exit /b

:NextRound
rem 局ごとに設定、変化する変数。
rem sutehai[番号]...捨て牌の枚数
rem sutehaiEP[番号][枚数]...各捨て牌のEP
rem sutehaistr[番号]...捨て牌の列表示
	set agari=0
	for /l %%i in (1,1,%player%) do (
		set fCount[%%i]=0
		set sutehaistr[%%i]=
		set sutehai[%%i]=0
		set reach[%%i]=F
		set poncheck[%%i]=0
		for /l %%j in (1,1,24) do set sutehaiEP[%%i][%%j]=
		for /l %%j in (1,1,47) do set PU[%%i][%%j]=0
	)
	set poncheck[1]=1
	
rem 場風の設定
	call :TPtoEP %gamecount% bEP

rem 流れ時/連荘時の親番、局、積み棒の設定
	if %tumiboureset% == 1 (
		set /a kyoku+=1,tumibou=0
		if !kyoku! gtr %player% set /a gamecount+=1,kyoku=1
		if !gamecount! == 43 goto finish
		for /l %%i in (1,1,%player%) do (
			set /a jTP[%%i]-=1
			if !jTP[%%i]! lss 41 set jTP[%%i]=4%player%
			call :TPtoEP !jTP[%%i]! jEP[%%i]
		)
	) else set /a tumibou+=1
	set kyokuEP=!EPstr:~%kyoku%,1!
	set tumibouEP=!EPstr:~%tumibou%,1!
	exit /b

:NextTurn
rem 巡ごとに変化する変数。
	exit /b

:Ryukyoku
rem 流局時の変数。
set >>hensu.txt
	echo 流局
	echo 聴牌判定、処理
	pause
	exit /b

rem =ここまで変数の管理=============

:Tumo
rem ツモる
	set /a NP[%turn%][14]=yama[%nokori%],aiturn=(turn+1)/3
	call :NPtoTP !NP[%turn%][14]! TP[%turn%][14] EP[%turn%][14]
rem PU[turn]に加算。
	set /a PU[%turn%][!tp[%turn%][14]!]+=1
	exit /b

:Tehai0
rem プレイヤー用手牌ラベル(tehai0→tehai)
	set /a tehaicount[1]=14-fCount[1]*3
	set command[1]=Z：ツモ
	set selectkey[1]=z
	if %reach[1]% == F (
		set command[2]=X：リーチ
		set selectkey[2]=x
	) else (
		set command[2]=　　　　　
		set selectkey[2]=
	)
rem 槓可能かどうか
	call :KanJudge 1
	if %kanable[1]% geq 1 (
	set command[3]=C:カン
	set selectkey[3]=c
	) else (
		set command[3]=　　　　
		set selectkey[3]=
	)
	call :Cursor 0 %tehaicount[1]%

:Tehai
	call :Display 1
	cls
	echo %jEP[4]%家手牌：%str[4]%
	echo 　　捨牌：%sutehaistr[4]%
	echo ■■■■■■■■■■■■■■■■■■■■
	echo %jEP[3]%家手牌：%str[3]%
	echo 　　捨牌：%sutehaistr[3]%
	echo ■■■■■■■■■■■■■■■■■■■■
	echo %jEP[2]%家手牌：%str[2]%
	echo 　　捨牌：%sutehaistr[2]%
	echo ■■■■■■■■■■■■■■■■■■■■
	echo %bEP%%kyokuEP%局 %tumibouEP%本場 
	echo ドラ表示牌：%dEP[0]%　残：%nokori%
	echo ■■■■■■■■■■■■■■■■■■■■
	echo 　　捨牌：%sutehaistr[1]%
	echo.
	echo %jEP[1]%家手牌：%str[1]%
	echo 　　　　　%str2%
	echo (槓可能か)%str3%
	echo %command[1]%　%command[2]%　%command[3]%
	choice /c adw%selectkey[1]%%selectkey[2]%%selectkey[3]% >nul
	set selected=%errorlevel%
	if %selected% leq 2 (
		call :Cursor %selected%
		goto Tehai
	)
	if %selected% == 3 (
		if %cursor% == %tehaicount[1]% set cursor=14
		call :Dahai !cursor!
		exit /b
	)
	if %selected% geq 4 call :Unimplemented
	exit
	
:Dahai
rem 引数１に打牌する牌番号。鳴いている場合のツモ切りは14
	set /a sutehai[%turn%]+=1
	set sutehai[%turn%][!sutehai[%turn%]!]=!EP[%turn%][%1]!
	set sutehaistr[%turn%]=!sutehaistr[%turn%]!!EP[%turn%][%1]!
	set NP[%turn%][%1]=!NP[%turn%][14]!
	set ldNP=!NP[%turn%][%1]!
	set ldTP=!TP[%turn%][%1]!
	set ldEP=!EP[%turn%][%1]!
	set /a PU[%turn%][!TP[%turn%][%1]!]-=1
	set /a PU[1][!TP[%turn%][%1]!]+=1,PU[2][!TP[%turn%][%1]!]+=1,PU[3][!TP[%turn%][%1]!]+=1,PU[4][!TP[%turn%][%1]!]+=1
	if %1 neq 14 call :Ripai %turn%
	exit /b

:Tehai1
rem コンピュータ用手牌ラベル
	call :display %turn%
	cls
	echo %jEP[4]%家手牌：%str[4]%
	echo 　　捨牌：%sutehaistr[4]%
	echo ■■■■■■■■■■■■■■■■■■■■
	echo %jEP[3]%家手牌：%str[3]%
	echo 　　捨牌：%sutehaistr[3]%
	echo ■■■■■■■■■■■■■■■■■■■■
	echo %jEP[2]%家手牌：%str[2]%
	echo 　　捨牌：%sutehaistr[2]%
	echo ■■■■■■■■■■■■■■■■■■■■
	echo %bEP%%kyokuEP%局 %tumibouEP%本場 
	echo ドラ表示牌：%dEP[0]%　残：%nokori%
	echo ■■■■■■■■■■■■■■■■■■■■
	echo 　　捨牌：%sutehaistr[1]%
	echo.
	echo %jEP[1]%家手牌：%str[1]%
	set aidahai=14
	if !tp[%turn%][13]! geq 41 set aidahai=13
	call :Dahai %aidahai%
	exit /b

rem =ここから汎用ラベル=============

:KanJudge
rem loop...カンできるかの考慮をする１枚目
rem loop2...カンできるかの考慮をする２枚目
rem loop3...カンできるかの考慮をする３枚目
rem loop4...カンできるかの考慮をする４枚目
rem kanable[P番号]...そのPが何回カンできるか
rem kanable[P番号][カンできる幾つ目の組み合わせか（kanable[P番号]）]...0なら暗槓、1なら明槓
rem kanabletehai[1~14]...１ならカン可能、０なら不可能
	set /a loop=0,kanable[%1]=0,tempint1=12-fCount[1]*3
	for /l %%i in (1,1,14) do set kanabletehai[%%i]=0

:KanJudge2
rem 暗槓の判定
	set /a loop+=1,loop1=loop,loop2=loop+1,loop3=loop+2,loop4=loop+3
	if %loop% geq %tempint1% goto KanJudge3
	if !TP[%1][%loop%]! neq !TP[%1][%loop3%]! goto KanJudge2
	if !TP[%1][%loop%]! == !TP[%1][14]! (
		set /a kanable[%1]+=1,loop+=2
		set kanable[%1][!kanable[%1]!]=0
		set kanabletehai[%loop1%]=1
		set kanabletehai[%loop2%]=1
		set kanabletehai[%loop3%]=1
		set kanabletehai[14]=1
		goto KanJudge2
	)
	if !TP[%1][%loop%]! == !TP[%1][%loop4%]! (
		set /a kanable[%1]+=1,loop+=3
		set kanable[%1][!kanable[%1]!]=0
		set kanabletehai[%loop1%]=1
		set kanabletehai[%loop2%]=1
		set kanabletehai[%loop3%]=1
		set kanabletehai[%loop4%]=1
		goto KanJudge2
	)
	set /a loop+=2
	goto KanJudge2

:Kanjudge3
rem 明槓の判定
	for /l %%i in (1,1,!fCount[%1]!) do (
		for /l %%j in (1,1,10) do (
			if !fDisp[%1][%%i]! == !TP[%1][%%j]! (
				set kanable[%1][!kanable[%1]!]=1
				set kanabletehai[%%j]=1	
			)
		)
		if !fDisp[%1][%%i]! == !TP[%1][14]! set kanabletehai[14]=1
	)
	set /a tehaicount=13-fCount[%1]*3
	set str3=
	for /l %%i in (1,1,%tehaicount%) do (
		if !kanabletehai[%%i]! == 1 (
			set str3=!str3!槓
		) else set str3=!str3!＿
	)
	for /l %%i in (1,1,!fcount[%1]!) do set str3=!str3!         
	if !kanabletehai[14]! == 1 (
		set str3=!str3! 槓
	) else set str3=!str3! ＿
	exit /b

:PonJudge
rem 各プレイヤーの打牌後、他のプレイヤーがその牌をポンできるかどうかの確認
	set /a turn=turn%%4+1,loop=0
	if %turn% == %1 (
		set /a turn=turn%%4+1
		goto ChiJudge
	)
	if !poncheck[%turn%]! == 0 goto PonJudge
:PonJudge2
	set /a loop+=1,loop2=loop+1,tempint1=13-fCount[%turn%]*3,tempint5=tempint1-2,nakivector=(%1+4-%turn%)%%4
	if !TP[%turn%][%loop%]! == %ldTP% if !TP[%turn%][%loop2%]! == %ldTP% (
		call :Cursor 0 2
		set cursor=2
		goto PonCheck
	)
	
	if %loop2% lss %tempint1% goto PonJudge2
	goto Ponjudge
:PonCheck
	cls
	call :PlainDisplay %turn%
	echo !jEP[%1]!家捨牌：!sutehaistr[%1]!
	echo.
	echo 　　手牌：%str[1]%
	echo.
	echo 【!jEP[%turn%]!家：プレイヤー%turn%】は、【!jEP[%1]!家：プレイヤー%1】の捨牌【!ldEP!】をポンできます。
	echo ポンしますか？
	echo !cursor[1]!はい !cursor[2]!いいえ
	choice /c adw >nul
	if %errorlevel% leq 2 (
		call :Cursor %errorlevel%
		goto PonCheck
	)
	if %cursor% == 2 exit /b
	set /a fCount[%turn%]+=1,sutehai[%1]-=1
	set tempstr=!sutehaistr[%1]!
	set sutehaistr[%1]=!tempstr:~0,-1!
rem 	鳴いた時の共通処理
	set tempint6=!fCount[%turn%]!
	set /a NP[%turn%][%loop%]=999,NP[%turn%][%loop2%]=999,NP[%turn%][14]=999,fMents[%turn%][%tempint6%]=ldTP
	if %nakivector% == 1 set fDispMents[%turn%][%tempint6%]=%ldEP%%ldEP%[%ldEP%]
	if %nakivector% == 2 set fDispMents[%turn%][%tempint6%]=%ldEP%[%ldEP%]%ldEP%
	if %nakivector% == 3 set fDispMents[%turn%][%tempint6%]=[%ldEP%]%ldEP%%ldEP%
	set fDisp[%turn%][%tempint6%]=%ldEP%
rem 鳴き回数ごとの処理
	set /a tempint7=tempint6*3-2,tempint8=tempint6*3-1,tempint9=tempint6*3
	set /a furohai[%turn%][%tempint7%]=ldNP,furohai[%turn%][%tempint8%]=ldNP,furohai[%turn%][%tempint9%]=ldNP

	call :Ripai %turn%
	set /a NP[%turn%][14]=NP[%turn%][%tempint5%],NP[%turn%][%tempint5%]=999
	call :Ripai %turn%
	call :NPtoTP !NP[%turn%][14]! TP[%turn%][14] EP[%turn%][14]
	set /a PU[%turn%][%ldTP%]-=2
	set /a PU[1][%ldTP%]+=2,PU[2][%ldTP%]+=2,PU[3][%ldTP%]+=2,PU[4][%ldTP%]!]+=2
	if %turn% == 1 goto Tehai0
	goto Tehai1

:ChiJudge
rem turnに、打牌したPの右のPの番号を代入してある
rem ldTPを基準に、チーできる組み合わせがあれば、それを記録
rem 	for /l %%i in (1,1,13) do set /p <nul="!TP[%turn%][%%i]!,"
rem 	pause
rem ここまで来たならば、プレイヤーごとの打牌処理が終了したことになる。
rem よって、次のPの自摸に移るので、それに必要な処理をここで行う。
rem 
	set /a nokori-=1
	exit /b
	
:Display
rem 引数１のプレイヤーの手牌表示
rem str2はカーソル列。tehai[1][14]のカーソルは[14]ではなく[14-鳴き回数*3]
	set /a tehaicount=13-fCount[%1]*3
	set str[%1]=
	if %1 == 1 set str2=
	for /l %%i in (1,1,%tehaicount%) do (
		set str[%1]=!str[%1]!!EP[%1][%%i]!
		if %1 == 1 set str2=!str2!!cursor[%%i]!
	)
	set str[%1]=!str[%1]! !EP[%1][14]!
	if %1 == 1 set str2=!str2! !cursor[%tehaicount[1]%]!
	for /l %%i in (!fCount[%1]!,-1,1) do set str[%1]=!str[%1]! !fDispMents[%1][%%i]!
	exit /b

:PlainDisplay
	set /a tehaicount=13-fCount[%1]*3
	set str[%1]=
	for /l %%i in (1,1,%tehaicount%) do set str[%1]=!str[%1]!!EP[%1][%%i]!
	exit /b
	
:Roll
rem 親決め
	set /a tempint1=%random%*player/32768
	for /l %%i in (1,1,%player%) do (
		set /a tempint1+=1
		if !tempint1! gtr %player% set /a turn=%%i,tempint1=1
		set /a jTP[%%i]=tempint1%%4+41
	)
	set /a turn=(turn+2)%%4+1
	exit /b

:NPtoTP
rem 引数1のtehaiをTPに変換して、引数2に指定された名前の変数に保存。
rem 引数3が存在する場合、引数3を引数2としてTPtoEPに引き継ぐ。
	set /a %2=(%1-1)/4+(%1-1)/36+11
	if not "%3" == "" call :TPtoEP !%2! %3
	exit /b

:TPtoEP
rem 引数1のTPをEPに変換して、引数2に指定された名前の変数に保存
	set /a tempint0=%1-10
	set %2=!EPstr:~%tempint0%,1!
	exit /b

:Sipai
rem yama2.txtの内容を抽出
	set /a nokori=0,loop=0
	if not exist yama2.txt (
		cls
		echo wait...
		call :Wait
		goto Sipai
	)
	call :YamaSet
	cls
	echo OK
	for /f %%i in (%cd%\yama2.txt) do (
		set /a nokori+=1
		set yama[!nokori!]=%%i
	)
	
	if %testmode% == 1 (
		set nokori=0
		start /b /wait testmode.bat
		for /f %%i in (%cd%\yama2.txt) do (
			set /a nokori+=1
			set yama[!nokori!]=%%i
		)
	)

	:Sipai2
		if %nokori% geq 127 (
			set /a tempint1=136-nokori
			set dNP[!tempint1!]=!yama[%nokori%]!
			call :NPtoTP !yama[%nokori%]! dTP[!tempint1!] dEP[!tempint1!]
			set /a nokori-=1
			goto Sipai2
		)
		if %nokori% geq 123 (
			set /a tempint1=127-nokori
			set rNP[!tempint1!]=!yama[%nokori%]!
			call :NPtoTP !yama[%nokori%]! rTP[!tempint1!] rEP[!tempint1!]
			set /a nokori-=1
			goto Sipai2
		)
		set /a PU[1][%dTP[0]%]+=1,PU[2][%dTP[0]%]+=1,PU[3][%dTP[0]%]+=1,PU[4][%dTP[0]%]+=1
	:Sipai3
		if %loop% == %player% (
			set /a nokori+=1
			exit /b
		)
		set /a loop+=1,loop2=0
	:Sipai4
		set /a loop2+=1
		set NP[%loop%][%loop2%]=!yama[%nokori%]!
		set /a nokori-=1
		if %loop2% == 13 goto Sipai3
		goto Sipai4

:AllRipai
rem 全プレイヤー一括ripai
	set loop2=0
	:AllRipai2
		set /a loop2+=1
		call :Ripai %loop2%
		for /l %%i in (1,1,13) do set /a PU[%loop2%][!TP[%loop2%][%%i]!]+=1
		if %loop2% == %player% exit /b
		goto AllRipai2

:Ripai
rem 引数1のプレイヤー番号の手牌をplayernumに代入してripai
rem 鳴かれた牌はtehai999/TP51として普通に理牌。
	set /a tempint2=agari+13,loop=0
	echo.>tehai.txt
	for /l %%i in (1,1,%tempint2%) do (
		set /a tempint1=!NP[%1][%%i]!+1000
		echo !tempint1!>>tehai.txt
	)
	sort "%cd%\tehai.txt" /o "%cd%\tehai.txt"
	for /f %%i in (%cd%\tehai.txt) do (
		set /a loop+=1
		set /a NP[%1][!loop!]=%%i-1000
	)
	for /l %%i in (1,1,%tempint2%) do call :NPtoTP !NP[%1][%%i]! TP[%1][%%i] EP[%1][%%i]
	exit /b

:YamaSet
rem シーパイするためにtxtを作成するバッチを起動する。
rem 並列で起動するため別のbatに。
	start /belownormal /min %cd%\yamaset.bat
	exit /b

:Unimplemented
rem 未実装の時に表示。表示だけしかできずexit /bするのでバグる。確認用
	echo 未実装
	pause
	exit /b

:Cursor
rem カーソル移動関連
rem 引数...012(/array)
	if not "%2" == "" set /a array=%2
	set cursor[%cursor%]=　
	call :Cursor_%1
	set cursor[%cursor%]=●
	exit /b

	:Cursor_0
		exit /b
	:Cursor_1
		set /a cursor=(cursor+array-2)%%array+1
		exit /b
	:Cursor_2
		set /a cursor=cursor%%array+1
		exit /b

:GetTime
rem 引数１つなら、その番号を使って時間を登録
rem 引数２つなら、１つ目の番号を使って時間を登録。そこから２つ目の番号を開始時間、１つ目の番号を終了時間として経過時間を算出・表示
	set T[%1]=%TIME%
	for /f "tokens=1-4 delims=:." %%a in ("!T[%1]!") do set /a MT[%1]=%%a0*36000+1%%b*6000+1%%c*100+1%%d-610100
	if "%2" == "" exit /b
	set /a D=MT[%2]-MT[%1]
	set /a D1=%D:~0,-2%0/10,D2=10%D:~-2,2%%%100+100
	set D2=%D2:~1,2%
	echo.
	echo 開始時間：!T[%2]!
	echo 終了時間：!T[%1]!
	echo 経過時間：%D1%.%D2%sec （%D%ms）
	pause >nul
	exit /b

:Wait
rem １秒待機。
	timeout /t 1 /nobreak >nul
	exit /b

:Logging
rem ログ取得用ラベル。完了と同時に削除
	set fName=%cd%\%date:~0,4%%date:~5,2%%date:~8,2%
	prompt $s
	@echo on
	for /l %%i in (1,1,100) do if not exist "%fName%_%%i.log" call :%1 > "%fName%_%%i.log" 2>&1