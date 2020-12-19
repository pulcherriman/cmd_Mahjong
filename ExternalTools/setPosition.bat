if "%2" == "" call Errors/occured Error invalid_arguments
set /a _row=%1
set /a _column=%2
set /p _=%ccon_esc%%_row%;%_column%H<nul
exit /b