@echo off
echo ========================================
echo Visual Studio Ortam Degiskenlerini Yukleniyor...
echo ========================================
echo.

REM Try to find and run vcvarsall.bat
set VS_PATH=
set VS_YEAR=

REM Check for Visual Studio 2022
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat" (
    set VS_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat
    set VS_YEAR=2022
    goto :found
)

if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvarsall.bat" (
    set VS_PATH=C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvarsall.bat
    set VS_YEAR=2022
    goto :found
)

if exist "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" (
    set VS_PATH=C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat
    set VS_YEAR=2022
    goto :found
)

REM Check for Visual Studio 2019
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" (
    set VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat
    set VS_YEAR=2019
    goto :found
)

if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvarsall.bat" (
    set VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvarsall.bat
    set VS_YEAR=2019
    goto :found
)

REM Check for Visual Studio 2017
if exist "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" (
    set VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat
    set VS_YEAR=2017
    goto :found
)

:notfound
echo HATA: Visual Studio bulunamadi!
echo.
echo Lutfen manuel olarak su adimlari takip edin:
echo.
echo 1. Baslat menusunden "Developer Command Prompt for VS" arayin
echo 2. O komut istemcisini acin
echo 3. Bu klasore gidin: cd "C:\Users\Alper\Desktop\Advanced Computer Graphics Proje"
echo 4. build_and_run.bat dosyasini calistirin
echo.
pause
exit /b 1

:found
echo Visual Studio %VS_YEAR% bulundu!
echo Ortam degiskenleri yukleniyor...
call "%VS_PATH%" x86
if %ERRORLEVEL% NEQ 0 (
    echo HATA: Ortam degiskenleri yuklenemedi!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Derleme basladi...
echo ========================================
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

