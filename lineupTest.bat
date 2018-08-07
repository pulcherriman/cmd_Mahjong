@echo off
cd %~dp0
setlocal EnableDelayedExpansion

choice /n /m "ƒƒO‚ðŽæ“¾‚µ‚Ü‚·‚©H(Y/N)"
if %errorlevel% == 1 call :echoon
if %errorlevel% == 2 call :Main
exit /b

:echoon
  @echo on
  call :Main > lineupTest.log 2>&1
exit /b

:Main
call Times/get begin
set tp[0]=32
set tp[1]=32
set tp[2]=32
set tp[3]=33
set tp[4]=33
set tp[5]=33
set tp[6]=34
set tp[7]=34
set tp[8]=34
set tp[9]=35
set tp[10]=36
set tp[11]=37
set tp[12]=38
set tp[13]=38
echo ”vŽp: %tp[0]% %tp[1]% %tp[2]% %tp[3]% %tp[4]% %tp[5]% %tp[6]% %tp[7]% %tp[8]% %tp[9]% %tp[10]% %tp[11]% %tp[12]% %tp[13]%
call Analyzers/lineup tp tp[0]
call Times/get end

call Times/print begin end

pause>nul
exit
