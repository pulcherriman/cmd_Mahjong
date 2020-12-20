:: 配列をシャッフルする

:main :: ref array, count
if "%2" == "" call Errors/occured Error invalid_arguments
set /a _n=%2-1
for /l %%_ in (%_n%,-1,1) do (
	set /a _m=!random!%%^(%%_+1^)
	set /a _tmp=%1[!_m!]
	set /a %1[!_m!]=%1[%%_]
	set /a %1[%%_]=_tmp
)
exit /b