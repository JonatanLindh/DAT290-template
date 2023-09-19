cmake_minimum_required(VERSION 3.20)
include(../projects.cmake)

setup()

cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME ProjectName)   
string(REPLACE " " "_" ProjectId ${ProjectName})
project(${ProjectName}
    LANGUAGES
        C
        CXX
        ASM
)

# ----------------------------------------------------------------
# ------------------------- EDIT BELOW   -------------------------
# ----------------------------------------------------------------

file(GLOB C_FILES "src/*.c")
file(GLOB CXX_FILES "src/*.cpp")

# Add project source files here
add_executable(${CMAKE_PROJECT_NAME}
    ${C_FILES}
    ${CXX_FILES}
)

get_src_paths()
# Add library source files here
target_sources(${CMAKE_PROJECT_NAME}
    PUBLIC
        ${LIB_SRC}/debug.c

        ${HAL_SRC}/stm32f4xx_gpio.c
        ${HAL_SRC}/stm32f4xx_rcc.c

        ${STARTUP}
)

# ----------------------------------------------------------------
# ------------------------- EDIT ABOVE ---------------------------
# ----------------------------------------------------------------

includes()

compile_settings()
link_settings()

translate_dissasemble()
