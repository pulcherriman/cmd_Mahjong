pushd %~dp0..

chcp 932>nul
mode con cols=74 lines=28
color 2f
call ExternalTools/ansiconSetting

popd