maker_utils_require(module.cmake)

function (maker_folders_default_root)
  set(MAKER_BASE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
  file(GLOB potential_apps "apps/*")
  foreach (potential_app ${potential_apps})
    maker_module_create_app(${potential_app})
  endforeach() 
endfunction ()