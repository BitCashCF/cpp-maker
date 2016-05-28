# Bootstrap the macros for including other files
set (MAKER_SYSTEM_PATH ${CMAKE_CURRENT_LIST_DIR})
include (${MAKER_SYSTEM_PATH}/tools/include.cmake)

maker_include_once(tools/debug.cmake)
maker_include_once(tools/gtest.cmake)
maker_include_once(tools/module.cmake)
maker_include_once(tools/moduletype.cmake)
maker_include_once(tools/moduledeps.cmake)

# Call once in your topmost CMakeLists.txt to initialize maker
function(maker_init project_name)
  project(${project_name})

  set(MAKER_BASE_PATH ${CMAKE_CURRENT_SOURCE_DIR})

  maker_moduletype_add("app" "apps")
  maker_moduletype_add("lib" "libs")
  maker_moduletype_add("protocol" "protocols")

  maker_moduledeps_add_type("libs" "libs")
  maker_moduledeps_add_type("ext-libs" "ext-libs")
  maker_moduledeps_add_type("protocols" "protocols")

  maker_moduletype_create_modules()
endfunction(maker_init)
