# Code for security system

## Requirements

- [CMake](https://cmake.org/download/#candidate)
  - Check "add to path" during install
- [Arm GNU toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
  - Check "add to path" during install
- [Ninja](https://github.com/ninja-build/ninja/releases)
  - Manually add executable to path
- [Just](https://github.com/casey/just/releases/tag/1.14.0)
  - Manually add executable to path
  
- Windows: Add git bash's bin/ directory to path

## To replace eterm

Use extension or compile executable (and add to path) from [this repo](https://github.com/dtekcth/mop_templates).

## File structure

```bash
Code
├── Docs # Documentation 
│   └── ... 
├── import # External Code
│   └── ...
├── lib # Code shared between projects
│   ├── inc # Header files
│   │   └── ...
│   └── src # Source files
│       └── ... 
├── projects
│   ├── central / door / movement
│   │   ├── inc # Header files
│   │   │   └── ...
│   │   ├── src # Source files
│   │   │    ├── main.cpp # Project starting point
│   │   │    └── ...
│   │   └── CMakeLists.txt # Local cmake settings
│   └── projects.cmake # Global cmake settings
├── link.x # Linker script
├── startup.s # Startup assembly
└── justfile # Just-recepies
```
