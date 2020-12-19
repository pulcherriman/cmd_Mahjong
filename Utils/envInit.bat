pushd %~dp0..

chcp 932>nul
mode con cols=74 lines=26
color 2f
call ExternalTools/ansiconSetting

popd