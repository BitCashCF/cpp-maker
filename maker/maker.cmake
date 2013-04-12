# Bootstrap the basic macros needed for including files etc
set (MAKER_SYSTEM_PATH ${CMAKE_CURRENT_LIST_DIR})

include (${MAKER_SYSTEM_PATH}/tools/utils.cmake)

maker_utils_require(tools/folders.cmake)
maker_utils_require(tools/module.cmake)

macro(maker_init)
      maker_folders_default_root()
endmacro(maker_init)