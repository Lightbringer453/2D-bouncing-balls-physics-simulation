# Bouncing Balls Sim

A 2D bouncing balls physics simulation — Advanced Computer Graphics course project.

Written in C++, this particle simulation includes gravity and collisions. Each frame is saved as a PNG; you can optionally produce an MP4 or GIF with FFmpeg.

## Features

- 15 balls with random size, color, and velocity
- Gravity plus wall and ball–ball collisions (impulse-based)
- Sub-stepping for more stable physics (4 sub-steps per frame)
- Software rasterization via filled circle drawing
- 300 PNG frames → MP4 / GIF

## Requirements

- **C++ compiler:** Visual Studio (MSVC) or MinGW/GCC
- **FFmpeg** (optional, for video) — [ffmpeg.org](https://ffmpeg.org/download.html)

## Build and run

### Visual Studio (recommended)

```bat
setup_and_build.bat
```

Or from a Developer Command Prompt:

```bat
build_and_run.bat
```

### GCC / MinGW

```bat
build_gcc.bat
```

The program writes `frame_000.png` … `frame_299.png`.

## Create video / GIF

```bat
create_video.bat              REM output.mp4
create_video_high_quality.bat REM higher-quality MP4
create_video_gif.bat          REM GIF
```

## Project structure

```
├── Lab/
│   ├── main.cpp      # Simulation and rendering
│   ├── Image.h       # PNG writing (ColorImage)
│   ├── PNG/          # libpng
│   └── zlib/         # zlib
├── Lab.sln           # Visual Studio solution
├── build_*.bat       # Build scripts
└── create_video*.bat # FFmpeg scripts
```

## Simulation parameters

| Parameter | Value |
|-----------|--------|
| Resolution | 800 × 600 |
| Frame count | 300 |
| Physics FPS | 60 |
| Ball count | 15 |
| Gravity | 500 |
| Wall restitution | 0.9 |
| Ball–ball restitution | 1.0 |

Tweaks live in the constants at the top of `Lab/main.cpp`.

## License

This project is for educational use.
