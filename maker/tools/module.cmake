macro(maker_module_set_full_name full_name)
  maker_utils_debug("setting full name to ${full_name}")
endmacro()

macro(maker_module_set_sources sources)
  foreach (source ${sources})
    set(MAKER_MODULE_SOURCES ${MAKER_MODULE_SOURCES} ${MAKER_MODULE_BASE_PATH}/${sources})			      
  endforeach()
endmacro()

# End every app with this:
macro(maker_module_finalize_app)
  maker_utils_debug("finalizing app ${MAKER_MODULE_NAME}")

  maker_utils_debug("sources for ${MAKER_MODULE_NAME}: ${MAKER_MODULE_SOURCES}")

  if (NOT DEFINED MAKER_MODULE_SOURCES)
    message(FATAL_ERROR "No sources defined for ${MAKER_MODULE_NAME}")
  endif()

  add_executable (app_${MAKER_MODULE_NAME} ${MAKER_MODULE_SOURCES})

  foreach(dep_module ${MAKER_MODULE_DEP_MODULES})
    get_filename_component(_module ${dep_module} NAME)
    target_link_libraries(app_${MAKER_MODULE_NAME} lib_${_module})
  endforeach()
endmacro()

# Find and include module
macro(maker_module_depend module_name)
  maker_utils_debug("finding and including module ${module_name}")
  if (EXISTS ${MAKER_BASE_PATH}/libs/${module_name})
    set (MAKER_MODULE_DEP_MODULES ${MAKER_MODULE_DEP_MODULES} ${MAKER_BASE_DIR}/libs/${module_name})
  else()
    message(FATAL_ERROR "Failed to depend on ${module_name} from ${MAKER_MODULE_NAME}")   
  endif()
endmacro()

# Used to create a scope for another app
function(maker_module_create_app app_folder)
    maker_utils_debug("Trying to create app ${app_folder}")
    if(EXISTS ${potential_app}/makerfile)
      set(MAKER_MODULE_BASE_PATH ${app_folder})
      get_filename_component(MAKER_MODULE_NAME ${app_folder} NAME)
      maker_utils_debug ("Found app ${potential_app}")
      maker_utils_require_abs (${potential_app}/makerfile)
    endif()
endfunction()
