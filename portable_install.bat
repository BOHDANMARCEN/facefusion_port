@echo off
setlocal
set "DEST=D:\facefusion"

echo Installing FaceFusion portable version to %DEST%

if not exist "%DEST%" (
    mkdir "%DEST%"
)

rem Copy repository files
xcopy /E /I /Y "%~dp0" "%DEST%\source" >nul

cd /d "%DEST%\source"

set "PYVER=3.10.11"
set "PY_URL=https://www.python.org/ftp/python/%PYVER%/python-%PYVER%-embed-amd64.zip"
set "PY_ARCHIVE=%DEST%\python.zip"

if not exist "%DEST%\python" (
    echo Downloading portable Python %PYVER%...
    powershell -Command "Invoke-WebRequest -Uri '%PY_URL%' -OutFile '%PY_ARCHIVE%'"
    powershell -Command "Expand-Archive -LiteralPath '%PY_ARCHIVE%' -DestinationPath '%DEST%\python'"
    del "%PY_ARCHIVE%"
)

set "PATH=%DEST%\python;%PATH%"
%DEST%\python\python.exe -m ensurepip
%DEST%\python\python.exe -m pip install -r requirements.txt
%DEST%\python\python.exe install.py --onnxruntime default --skip-conda

copy "%~dp0run_facefusion.bat" "%DEST%\run_facefusion.bat" >nul

echo Installation complete.
echo Use run_facefusion.bat inside %DEST% to start FaceFusion.
pause
endlocal
