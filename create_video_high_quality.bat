@echo off
echo Creating high quality video from frames...

REM FFmpeg yolunu kontrol et
set FFMPEG=ffmpeg
if exist "ffmpeg.exe" set FFMPEG=ffmpeg.exe
if exist "ffmpeg\bin\ffmpeg.exe" set FFMPEG=ffmpeg\bin\ffmpeg.exe

REM Yüksek kaliteli video (daha yavaş, daha büyük dosya) - 30 FPS
%FFMPEG% -y -framerate 30 -i frame_%%03d.png -c:v libx264 -pix_fmt yuv420p -crf 15 -preset slow output_hq.mp4

if %ERRORLEVEL% EQU 0 (
    echo.
    echo High quality video created successfully: output_hq.mp4
) else (
    echo.
    echo Error: FFmpeg not found or failed!
)

pause

