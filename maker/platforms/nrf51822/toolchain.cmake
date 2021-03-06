INCLUDE(CMakeForceCompiler)

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION 1)

# This toolchain is built to be as close to the blinky example in the nrf SDK as possible

CMAKE_FORCE_C_COMPILER(/usr/local/gcc-arm-none-eabi-4_9-2015q3/bin/arm-none-eabi-gcc GNU)
CMAKE_FORCE_CXX_COMPILER(/usr/local/gcc-arm-none-eabi-4_9-2015q3/bin/arm-none-eabi-g++ GNU)

SET(TEMPLATE_PATH ${CMAKE_CURRENT_LIST_DIR}/SDK/components/toolchain/gcc)
SET(LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/linkage/gcc_nrf51.ld)
SET(STARTUP_FILE "${CMAKE_CURRENT_LIST_DIR}/linkage/gcc_startup_nrf51.o")

SET(CFLAGS "-DNRF51 -DBOARD_PCA10028 -DBSP_DEFINES_ONLY -mcpu=cortex-m0 -mthumb -mabi=aapcs -Wall -Werror -O3 -g3 -mfloat-abi=soft -ffunction-sections -fdata-sections -fno-strict-aliasing -fno-builtin --short-enums")
SET(LDFLAGS "-Xlinker -Map=output.map -mthumb -mabi=aapcs -L ${TEMPLATE_PATH} -T${LINKER_SCRIPT} -mcpu=cortex-m0 -Wl,--gc-sections --specs=nano.specs  -lnosys -lc  ${STARTUP_FILE}")
SET(ASMFLAGS "-x assembler-with-cpp -DNRF51 -DBOARD_PCA20006 -DBSP_DEFINES_ONLY")

SET(CMAKE_CXX_FLAGS "${CFLAGS}")
SET(CMAKE_C_FLAGS "${CFLAGS}")
SET(CMAKE_ASM_FLAGS "${ASMFLAGS}")
SET(CMAKE_EXE_LINKER_FLAGS "${LDFLAGS}")
