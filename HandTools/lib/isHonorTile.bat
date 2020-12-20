:isHonorTile::string triplets, int head, int seat_wind, int table_wind  -> int
  setlocal
  set triplets=%~1
  set tripletsbit=0,headbit=0,s_windbit=0,t_windbit=0
  rem 1  “Œ
  rem 2  “ì
  rem 4  ¼
  rem 8  –k
  rem 16 ”’
  rem 32 á¢
  rem 64 ’†

  for /l %%i in (0,1,6) do (
    set /a _n="41+%%i"
    if %2 equ !_n! (
      set /a headbit="1<<%%i"
    )
    if %3 equ !_n! (
      set /a t_windbit="1<<%%i"
    )
    if %4 equ !_n! (
      set /a s_windbit="1<<%%i"
    )
  )

  for %%t in (%triplets%) do (
    for /l %%i in (0,1,6) do (
      set /a _n="41+%%i"
      if %%t equ !_n! (
        set /a tripletsbit+="1<<%%i"
      )
    )
  )

  set /a bitmasked=tripletsbit ^& 112
  if %bitmasked% equ 112 (
    exit /b 2097152 ::‘åOŒ³
  )

  set /a bitmasked=tripletsbit ^& 15
  if %bitmasked% equ 15 (
    exit /b 8388608 ::‘ålŠì
  )

  set /a bitmasked=(tripletsbit + headbit) ^& 15
  if %bitmasked% equ 15 (
    exit /b 4194304 ::¬lŠì
  )

  set /a honorsbit=0,bitmasked=(tripletsbit + headbit) ^& 112
  if %bitmasked% equ 112 ( ::¬OŒ³
    set /a honorsbit+=32768
  )

  set /a bitmasked=tripletsbit ^& s_windbit
  if %bitmasked% equ %s_windbit% ( ::©•—”v
    set /a honorsbit+=4
  )

  set /a bitmasked=tripletsbit ^& t_windbit
  if %bitmasked% equ %t_windbit% ( ::ê•—”v
    set /a honorsbit+=8
  )

  set /a bitmasked=tripletsbit ^& 16
  if %bitmasked% equ 16 ( ::”’
    set /a honorsbit+=16
  )

  set /a bitmasked=tripletsbit ^& 32
  if %bitmasked% equ 32 ( ::á¢
    set /a honorsbit+=32
  )

  set /a bitmasked=tripletsbit ^& 64
  if %bitmasked% equ 64 ( ::’†
    set /a honorsbit+=64
  )

exit /b %honorsbit%
