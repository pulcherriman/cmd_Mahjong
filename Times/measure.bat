if "%1" == "" call Error/occured invalid_arguments
call Times/get begin
call %*
call Times/get end

call Times/print begin end
exit /b