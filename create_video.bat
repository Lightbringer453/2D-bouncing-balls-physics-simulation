@echo off
echo Creating video from frames...

REM FFmpeg yolunu kontrol et
set FFMPEG=ffmpeg
if exist "ffmpeg.exe" set FFMPEG=ffmpeg.exe
if exist "ffmpeg\bin\ffmpeg.exe" set FFMPEG=ffmpeg\bin\ffmpeg.exe

REM FFmpeg komutu - 30 FPS video oluşturur
%FFMPEG% -y -framerate 30 -i frame_%%03d.png -c:v libx264 -pix_fmt yuv420p -crf 18 output.mp4

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Video created successfully: output.mp4
) else (
    echo.
    echo Error: FFmpeg not found or failed!
    echo Make sure FFmpeg is installed and in your PATH.
    echo.
    echo You can download FFmpeg from: https://ffmpeg.org/download.html
)

pause

