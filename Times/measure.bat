pushd %~dp0..

if "%1" == "" call Errors/occured Error invalid_arguments
call Times/get begin
call %*
call Times/get end

call Times/print begin end
popd && exit /b
