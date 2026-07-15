@echo off
set GCC_PATH=C:\msys64\ucrt64\bin\gcc.exe
set GPP_PATH=C:\msys64\ucrt64\bin\g++.exe

echo Compiling C files with gcc...
"%GCC_PATH%" -c -O2 -ILab Lab\PNG\png.c Lab\PNG\pngerror.c Lab\PNG\pngget.c Lab\PNG\pngmem.c Lab\PNG\pngpread.c Lab\PNG\pngread.c Lab\PNG\pngrio.c Lab\PNG\pngrtran.c Lab\PNG\pngrutil.c Lab\PNG\pngset.c Lab\PNG\pngtrans.c Lab\PNG\pngwio.c Lab\PNG\pngwrite.c Lab\PNG\pngwtran.c Lab\PNG\pngwutil.c Lab\zlib\adler32.c Lab\zlib\compress.c Lab\zlib\crc32.c Lab\zlib\deflate.c Lab\zlib\gzclose.c Lab\zlib\gzlib.c Lab\zlib\gzread.c Lab\zlib\gzwrite.c Lab\zlib\infback.c Lab\zlib\inffast.c Lab\zlib\inflate.c Lab\zlib\inftrees.c Lab\zlib\trees.c Lab\zlib\uncompr.c Lab\zlib\zutil.c

if %ERRORLEVEL% NEQ 0 (
    echo C compilation failed!
    pause
    exit /b 1
)

echo Linking with g++...
"%GPP_PATH%" -O2 -ILab main.cpp *.o -o main.exe

if %ERRORLEVEL% NEQ 0 (
    echo Linking failed!
    del *.o 2>nul
    pause
    exit /b 1
)

echo Cleaning up object files...
del *.o 2>nul

echo Build successful!

