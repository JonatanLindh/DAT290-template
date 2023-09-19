# Build
default: build

#? ----------------------------------
export CC := "arm-none-eabi-gcc"
export CXX := "arm-none-eabi-g++"

#? ----------------------------------
# Generates build config in ./build/
[no-cd]
cmake:
    cmake -S . -B build -G "Ninja"

alias cm := cmake


#? ----------------------------------
# Builds with cmake & ninja. Runs "just cmake" if ./build/ does not exist.
[no-cd]
@build:
    if ! [ -d "./build" ]; then just cmake; fi
    cmake --build build

alias b := build

#? ----------------------------------
# Removes ./build/
[no-cd]
clean:
    -rm ./build -rf

alias c := clean

#? ----------------------------------
# Load binary to target
[no-cd]
@load bin="$(ls build/*.s19 | head -1)":
    echo "Loading {{bin}} to md407..."
    md407_win_rs load --filename {{bin}} --port $(md407_win_rs query)


# Start execution on target
[no-cd]
@go:
    md407_win_rs go --port $(md407_win_rs query)

# Enters interactive session with target
[no-cd]
@interactive:
    md407_win_rs interactive --port $(md407_win_rs query)

#? ----------------------------------
# Build, load, go
@run: build load go

# Build, load, interactive
@bli: build load interactive
