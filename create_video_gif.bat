@echo off
echo Creating animated GIF from frames...

REM FFmpeg yolunu kontrol et
set FFMPEG=ffmpeg
if exist "ffmpeg.exe" set FFMPEG=ffmpeg.exe
if exist "ffmpeg\bin\ffmpeg.exe" set FFMPEG=ffmpeg\bin\ffmpeg.exe

REM GIF oluştur (daha küçük boyut için palette kullan)
%FFMPEG% -y -framerate 30 -i frame_%%03d.png -vf "fps=30,scale=800:600:flags=lanczos,palettegen" palette.png
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Error: FFmpeg not found!
    echo.
    echo Please download FFmpeg from: https://www.gyan.dev/ffmpeg/builds/
    echo Extract it and either:
    echo   1. Add ffmpeg.exe to this folder, OR
    echo   2. Add ffmpeg to your system PATH
    pause
    exit /b 1
)

%FFMPEG% -y -framerate 30 -i frame_%%03d.png -i palette.png -lavfi "fps=30,scale=800:600:flags=lanczos[x];[x][1:v]paletteuse" output.gif

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Animated GIF created successfully: output.gif
    del palette.png
) else (
    echo.
    echo Error: FFmpeg not found or failed!
)

pause

