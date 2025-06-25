@echo off
setlocal
set "APP_DIR=%~dp0source"
set "PATH=%~dp0python;%PATH%"
"%~dp0python\python.exe" "%APP_DIR%\facefusion.py" run %*
endlocal
