pushd %~dp0..

if "%3" == "" call Errors/occured invalid_arguments
call :Main %1 %2 %3
popd && exit /b

:Main::ref arr, int left, int count
	set /a left=%2,right=%2+%3-1
	call :Sort %1 %left% %right%
exit /b

:Sort
rem ë}ì¸É\Å[Ég
set /a st=%2+1
for /l %%i in (%st%,1,%3) do (
    set /a k=%%i-1
    for /l %%j in (%2,1,!k!) do (
		set /a tmp="%1[%%i]+(%1[%%i]+9)%%10/9*5-%1[%%j]-(%1[%%j]+9)%%10/9*5"
		if !tmp! lss 0 (
            set /a tmp=%1[%%i]
			for /l %%k in (%%i,-1,%%j) do (
				if %%k neq %%j (
					set /a nxt=%%k-1
					set /a %1[%%k]=%1[!nxt!]
				)
			)
            set /a %1[%%j]=tmp
        )
    )
)
exit /b