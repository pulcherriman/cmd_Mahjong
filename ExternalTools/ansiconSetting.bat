pushd %~dp0..

start ExternalTools/ansicon -i
set ccon_esc=[
@REM set ccon_clear=%ccon_esc%0m
@REM set ccon_black=0
@REM set ccon_red=1
@REM set ccon_green=2
@REM set ccon_yellow=3
@REM set ccon_blue=4
@REM set ccon_magenta=5
@REM set ccon_cian=6
@REM set ccon_white=7
@REM set ccon_fore=30
@REM set ccon_back=40
@REM set ccon_bright=60

set ccon_default=%ccon_esc%97m%ccon_esc%42m
popd
