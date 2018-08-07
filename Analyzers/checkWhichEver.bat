:Main::int num, StringIter iter -> bool
  setlocal
  set isContained=0
  for %%i in (%~2) do (
    if %1 equ %%i (
      set isContained=1
      goto exit_Main
    )
  )
:exit_Main
exit /b %isContained%
