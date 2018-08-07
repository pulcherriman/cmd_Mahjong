:Main::ref int[11-47] tmp -> bool
  setlocal EnableDelayedExpansion
  set isKokusi=1
  for %%i in (11 19 21 29 31 39 41 42 43 44 45 46 47) do (
    if !%1[%%i]! equ 0 (
      set isKokusi=0
      goto exit_Main
    ) else if !%1[%%i]! geq 3 (
      set isKokusi=0
      goto exit_Main
    ) else if !%1[%%i]! equ 2 (
      if !isKokusi! neq 1 (
        set isKokusi=0
        goto exit_Main
      )
      set isKokusi=%%i
    )
  )
:exit_Main
exit /b %isKokusi%
