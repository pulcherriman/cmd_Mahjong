:isHonorTile::string triples, int head, int seat_wind, int table_wind  -> int
  setlocal
  set triples=%~1
  set triplesbit=0,headbit=0,s_windbit=0,t_windbit=0
  rem 1  ��
  rem 2  ��
  rem 4  ��
  rem 8  �k
  rem 16 ��
  rem 32 �
  rem 64 ��

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

  for %%t in (%triples%) do (
    for /l %%i in (0,1,6) do (
      set /a _n="41+%%i"
      if %%t equ !_n! (
        set /a triplesbit+="1<<%%i"
      )
    )
  )

  set /a bitmasked=triplesbit ^& 112
  if %bitmasked% equ 112 (
    exit /b 4194304 ::��O��
  )

  set /a bitmasked=triplesbit ^& 15
  if %bitmasked% equ 15 (
    exit /b 16777216 ::��l��
  )

  set /a bitmasked=(triplesbit + headbit) ^& 15
  if %bitmasked% equ 15 (
    exit /b 8388608 ::���l��
  )

  set /a honorsbit=0,bitmasked=(triplesbit + headbit) ^& 112
  if %bitmasked% equ 112 ( ::���O��
    set /a honorsbit+=32768
  )

  set /a bitmasked=triplesbit ^& s_windbit
  if %bitmasked% equ %s_windbit% ( ::�����v
    set /a honorsbit+=4
  )

  set /a bitmasked=triplesbit ^& t_windbit
  if %bitmasked% equ %t_windbit% ( ::�ꕗ�v
    set /a honorsbit+=8
  )

  set /a bitmasked=triplesbit ^& 16
  if %bitmasked% equ 16 ( ::��
    set /a honorsbit+=16
  )

  set /a bitmasked=triplesbit ^& 32
  if %bitmasked% equ 32 ( ::�
    set /a honorsbit+=32
  )

  set /a bitmasked=triplesbit ^& 64
  if %bitmasked% equ 64 ( ::��
    set /a honorsbit+=64
  )

exit /b %honorsbit%
