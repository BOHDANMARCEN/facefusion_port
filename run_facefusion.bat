@echo off
setlocal
set "APP_DIR=%~dp0source"
"%~dp0python\python.exe" "%APP_DIR%\facefusion.py" run %*
endlocal
