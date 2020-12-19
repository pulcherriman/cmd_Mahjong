:: ‘Î‹Ç‚ðŠJŽn
pushd %~dp0../..

cls
call Utils/shipai yama 136

call Times/get begin

for %%i in (14 27 40 53) do call Utils/sort yama %%i 13

call Times/get end
cls
call Times/print begin end

echo ‰¤”v(14–‡)
call Utils/display yama 0 14
echo.

echo ”z”v(13–‡*4)
for %%i in (14 27 40 53) do call Utils/display yama %%i 13

echo.
echo ŽR”v(70–‡)
for %%i in (66 80 94 108 122) do call Utils/display yama %%i 14

pause>nul
call Structure/Players create p1
call Structure/Players create p2
call Structure/Players create p3
call Structure/Players create p4
call Structure/Players act haipai p1 14
call Structure/Players act haipai p2 27
call Structure/Players act haipai p3 40
call Structure/Players act haipai p4 53
call Structure/Players act display p1 1
call Structure/Players act display p2 2
call Structure/Players act display p3 3
call Structure/Players act display p4 4
pause>nul
popd