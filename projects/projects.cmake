# PROJECT SETTINGS ---------------------------------------------------
macro(setup)
    set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
    set(CMAKE_SYSTEM_PROCESSOR arm)

    if (WIN32)
        set(CMAKE_SYSTEM_NAME Generic)
    endif()
endmacro()


macro(get_src_paths)
    set(LIB_SRC "../../lib/src")
    set(HAL_SRC "../../import/STM32F4_lib/STM32F4xx_StdPeriph_Driver/src")

    target_sources(${CMAKE_PROJECT_NAME}
        PRIVATE
            ../../startup.s
            ${LIB_SRC}/startup.c
    )
endmacro()


macro(includes)
    # Add library include paths here
    target_include_directories(${CMAKE_PROJECT_NAME} 
        PUBLIC 
            "inc"
            "../../lib/inc"
            "../../import/STM32F4_lib/CMSIS/Include"
            "../../import/STM32F4_lib/STM32F4xx_StdPeriph_Driver/inc"
    )
endmacro()


macro(compile_settings)
    target_compile_options(${CMAKE_PROJECT_NAME}
        PUBLIC
            -mthumb
            -g -O0
            -mcpu=cortex-M4
            -mno-unaligned-access -mfloat-abi=soft
            -nostdlib -fno-exceptions
            $<$<COMPILE_LANGUAGE:CXX>:
                -fno-rtti
                -Wno-register -Wno-write-strings
            >
    )
endmacro()


macro(link_settings)
    # COMPILE AND LINK SETTINGS ------------------------------------------
    target_link_libraries(${CMAKE_PROJECT_NAME}
        PUBLIC
            gcc
            c_nano
    )

    target_link_options(${CMAKE_PROJECT_NAME}
        PUBLIC
            --specs=nano.specs
            --specs=nosys.specs
            -nostartfiles
            -nostdlib
            -T ${CMAKE_CURRENT_LIST_DIR}/../../link.x
    )
endmacro()


macro(translate_dissasemble)
    # TRANSLATE AND DISSASEMBLE ------------------------------------------
    add_custom_command(
        TARGET 
            ${CMAKE_PROJECT_NAME}
        COMMAND
            arm-none-eabi-objdump -D -S
            ${CMAKE_PROJECT_NAME}
            > ${CMAKE_PROJECT_NAME}.s
        COMMAND
            arm-none-eabi-objcopy -S -O srec
            ${PROJECT_SOURCE_DIR}/build/${CMAKE_PROJECT_NAME}
            ${PROJECT_SOURCE_DIR}/build/${CMAKE_PROJECT_NAME}.s19
        COMMENT "Dissasemble and translate binary")
endmacro()