@echo off
setlocal enabledelayedexpansion

:: Set the path to ffmpeg.exe (assumes it's in the same folder as this script)
set "FFMPEG=%~dp0ffmpeg.exe"

:: Check if ffmpeg exists
if not exist "%FFMPEG%" (
    echo Error: ffmpeg.exe not found in script directory.
    pause
    exit /b 1
)

:: Ask for input directory
set /p "INPUT_DIR=Enter the path to the folder containing FLAC files: "

:: Remove quotes if present
set "INPUT_DIR=%INPUT_DIR:"=%"

:: Check if folder exists
if not exist "%INPUT_DIR%" (
    echo Error: The specified directory does not exist.
    pause
    exit /b 1
)

:: Process each .flac file in the folder
for %%F in ("%INPUT_DIR%\*.flac") do (
    set "INPUT_FILE=%%F"
    set "OUTPUT_FILE=%%~dpnF.m4a"
    echo Converting "%%F" to "!OUTPUT_FILE!" ...
    "%FFMPEG%" -y -i "%%F" -acodec alac "!OUTPUT_FILE!"
)

echo Conversion complete.
pause