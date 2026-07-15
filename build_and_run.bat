@echo off
echo ========================================
echo Bouncing Balls Simulation - Build Script
echo ========================================
echo.

REM Check if Visual Studio compiler is available
where cl >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo HATA: Visual Studio compiler bulunamadi!
    echo.
    echo Lutfen su adimlari takip edin:
    echo 1. Visual Studio Installer'i acin
    echo 2. "Developer Command Prompt for VS" veya "x64 Native Tools Command Prompt" arayin
    echo 3. O komut istemcisini acin ve bu klasore gidin
    echo 4. Bu script'i tekrar calistirin
    echo.
    pause
    exit /b 1
)

echo Derleme basladi...
echo.

REM Compile all source files
cl /EHsc /I"Lab" /O2 main.cpp ^
   Lab\PNG\png.c Lab\PNG\pngerror.c Lab\PNG\pngget.c Lab\PNG\pngmem.c ^
   Lab\PNG\pngpread.c Lab\PNG\pngread.c Lab\PNG\pngrio.c Lab\PNG\pngrtran.c ^
   Lab\PNG\pngrutil.c Lab\PNG\pngset.c Lab\PNG\pngtrans.c Lab\PNG\pngwio.c ^
   Lab\PNG\pngwrite.c Lab\PNG\pngwtran.c Lab\PNG\pngwutil.c ^
   Lab\zlib\adler32.c Lab\zlib\compress.c Lab\zlib\crc32.c Lab\zlib\deflate.c ^
   Lab\zlib\gzclose.c Lab\zlib\gzlib.c Lab\zlib\gzread.c Lab\zlib\gzwrite.c ^
   Lab\zlib\infback.c Lab\zlib\inffast.c Lab\zlib\inflate.c Lab\zlib\inftrees.c ^
   Lab\zlib\trees.c Lab\zlib\uncompr.c Lab\zlib\zutil.c ^
   /Fe:main.exe

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Derleme BASARISIZ!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Derleme BASARILI!
echo ========================================
echo.
echo Program calistiriliyor...
echo.

REM Run the program
main.exe

echo.
echo Program tamamlandi!
echo Olusturulan frame dosyalarini kontrol edin.
echo.
pause

