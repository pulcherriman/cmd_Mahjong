@echo off
setlocal enabledelayedexpansion
del /q "%cd%\yama.txt"
del /q "%cd%\yama2.txt"
for /l %%i in (1,1,136) do set [%%i]=%%i
for /l %%i in (136,-1,1) do (
	set /a tempnum=[%%i],int=!random!*%%i/32768+1
	set /a [%%i]=[!int!],[!int!]=tempnum
)
for /l %%i in (1,1,136) do echo ![%%i]!>>"%cd%\yama.txt"
ren "%cd%\yama.txt" yama2.txt
exit
