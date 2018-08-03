@echo off
setlocal enabledelayedexpansion
cd %~dp0

if "%1" neq "" goto Renaming

set /a loop=0,error=0
for /l %%i in (11,1,47) do set /a haisyu[%%i]=0,koyuu[%%i]=%%i*4-43
for /l %%i in (21,1,29) do set /a koyuu[%%i]-=4
for /l %%i in (31,1,39) do set /a koyuu[%%i]-=8
for /l %%i in (41,1,47) do set /a koyuu[%%i]-=12

rem haisyu[]...その牌種が何枚使用されたか？
rem koyuu[]...牌種n番の牌の現在の固有番号は何か？
rem tehai[]...手牌n番目の牌種番号は何か？
rem result[]...手牌n番目の固有番号は何か？

:Select
	cls
	echo Tips:C…チューレン、K…国士　を自動で設定します
	echo      20,30,40のいずれかを入力で、その牌はランダムになります
	if %error% == 1 echo ERROR:未入力状態でエンターキーが押されました
	if %error% == 2 echo ERROR:入力された文字は、設定できる値ではありません
	if %error% == 3 echo ERROR:その牌は４枚登録済みです
	set /a loop+=1,error=0
	set tehai=
	set /p tehai="手牌%loop%枚目の牌種番号？"
	set /a judge_test=0+tehai,tehai[%loop%]=tehai
rem 入力されていない……error=1
	if "%tehai%" == "" set /a loop-=1,error=1& goto Select	
rem 入力が特殊番号だった場合……error=201,202...
	if %tehai% == C set /a loop-=1,error=201& goto Select_Ex
	if %tehai% == K set /a loop-=1,error=202& goto Select_Ex
rem 入力が<=10,>=48,%10=0である（＝範囲外）……error=2
	if %judge_test% lss 11 set /a loop-=1,error=2& goto Select
	if %judge_test% gtr 47 set /a loop-=1,error=2& goto Select
rem その牌種がすでに４枚使用されている……error=3
	if !haisyu[%tehai%]! == 4 set /a loop-=1,error=3& goto Select
rem 牌番号登録処理
	set /a haisyu[%tehai%]+=1
	set /a result[%loop%]=koyuu[%tehai%],koyuu[%tehai%]+=1
	if %loop% lss 13 goto Select
	goto Change

:Select_Ex
rem 牌番号一括登録処理
	if %error% == 201 (
		set /a tehai[1]=11,tehai[2]=11,tehai[3]=11,tehai[4]=12,tehai[5]=13,tehai[6]=14,tehai[7]=15,tehai[8]=16
		set /a tehai[9]=17,tehai[10]=18,tehai[11]=19,tehai[12]=19,tehai[13]=19
	)
	if %error% == 202 (
		set /a tehai[1]=11,tehai[2]=19,tehai[3]=21,tehai[4]=29,tehai[5]=31,tehai[6]=39,tehai[7]=41,tehai[8]=42
		set /a tehai[9]=43,tehai[10]=44,tehai[11]=45,tehai[12]=46,tehai[13]=47
	)
	for /l %%i in (1,1,13) do (
		set /a haisyu[!tehai[%%i]!]+=1
		set /a result[%%i]=koyuu[!tehai[%%i]!],koyuu[!tehai[%%i]!]+=1
	)
	goto Change

:Change
	cls
	for /l %%i in (1,1,13) do set /p <nul="!result[%%i]! "
	echo.
	echo 設定します。
	timeout /t 1 /nobreak  >nul
	for /l %%i in (1,1,13) do (
		set /a tempint0=109+%%i
		for /l %%j in (1,1,136) do (
			if !yama[%%j]! == !result[%%i]! (
				set /a tempint11=yama[!tempint0!]
				set yama[!tempint0!]=!result[%%i]!
				set yama[%%j]=!tempint11!
			)
		)
	)
	del /q "%cd%\yama2.txt"
	for /l %%i in (1,1,136) do echo !yama[%%i]!>>"%cd%\yama2.txt"
	exit

:Renaming
	cd ..
	echo timeout /t 2 /nobreak^>nul>"%cd%\renaming.bat"
	echo ren %1 MJ%2>>"%cd%\renaming.bat"
	echo start %cd%\MJ%2\MJ.bat ren>>"%cd%\renaming.bat"
	echo exit>>"%cd%\renaming.bat"
	start "%cd%\renaming.bat"
	exit