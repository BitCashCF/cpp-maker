# Bootstrap the basic macros needed for including files etc
set (MAKER_SYSTEM_PATH ${CMAKE_CURRENT_LIST_DIR})
include (${MAKER_SYSTEM_PATH}/tools/include.cmake)

maker_include_once(tools/debug.cmake)
maker_include_once(tools/gtest.cmake)
maker_include_once(tools/module.cmake)

# Include gtest
add_subdirectory(${MAKER_SYSTEM_PATH}/gtest-1.6.0 ${CMAKE_BINARY_DIR}/gtest-1.6.0/)

function(maker_init project_name)
  project(${project_name})

  set(MAKER_BASE_PATH ${CMAKE_CURRENT_SOURCE_DIR})

  # Create apps from all folders under apps/*
  file(GLOB potential_apps "apps/*")
  foreach (potential_app ${potential_apps})
    _maker_module_create_module(${potential_app} "app")
  endforeach() 

  # Create libs from all folders under libs/*
  file(GLOB potential_libs "libs/*")
  foreach (potential_lib ${potential_libs})
    _maker_module_create_module(${potential_lib} "lib")
  endforeach() 
endfunction(maker_init)