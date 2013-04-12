macro(maker_module_set_full_name full_name)
  maker_utils_debug("setting full name to ${full_name}")
endmacro()

macro(maker_module_set_sources sources)
  foreach (source ${sources})
    set(MAKER_MODULE_SOURCES ${MAKER_MODULE_SOURCES} ${MAKER_MODULE_BASE_PATH}/${source})			      
  endforeach()
endmacro()

macro(_maker_module_set_deps full_module_name)
  foreach(dep_module ${MAKER_MODULE_DEP_MODULES})
    target_link_libraries(${full_module_name} ${dep_module})
  endforeach()
endmacro()

macro(_maker_module_set_includes full_module_name)
  foreach(include_dir ${MAKER_MODULE_INCLUDE_DIRS})
  	message (${include_dir})
    include_directories(${include_dir})
  endforeach()
endmacro()


# End every app with this:
macro(maker_module_finalize_app)
  maker_utils_debug("finalizing app ${MAKER_MODULE_NAME} with sources: ${MAKER_MODULE_SOURCES}")
  _maker_module_set_includes(app_${MAKER_MODULE_NAME})
  maker_module_set_sources(makerfile)
  add_executable (app_${MAKER_MODULE_NAME} ${MAKER_MODULE_SOURCES})

  _maker_module_set_deps(app_${MAKER_MODULE_NAME})
endmacro()

# End every lib with this:
macro(maker_module_finalize_lib)
  maker_utils_debug("finalizing lib ${MAKER_MODULE_NAME} with sources: ${MAKER_MODULE_SOURCES}")
  # libs depend on themselves for include etc
  maker_module_depend(${MAKER_MODULE_NAME})
  _maker_module_set_includes(lib_${MAKER_MODULE_NAME})
  maker_module_set_sources(makerfile)
  add_library (lib_${MAKER_MODULE_NAME} ${MAKER_MODULE_SOURCES})

  _maker_module_set_deps(lib_${MAKER_MODULE_NAME})
endmacro()

# Find and include module
macro(maker_module_depend module_name)
  maker_utils_debug("finding and including module ${module_name}")
  if (EXISTS ${MAKER_BASE_PATH}/libs/${module_name})
  #TODO: check for special lib file and include that if exists
	maker_module_add_raw_module_dep(lib_${module_name})
	maker_module_add_raw_include_dir(${MAKER_BASE_PATH}/libs/${module_name}/include)
  else()
    message(FATAL_ERROR "Failed to depend on ${module_name} from ${MAKER_MODULE_NAME}")   
  endif()
endmacro()

# Used to create a scope for another module
function(maker_module_create_module module_folder)
    maker_utils_debug("Trying to create module ${module_folder}")
    if(EXISTS ${module_folder}/makerfile)
      set(MAKER_MODULE_BASE_PATH ${module_folder})
      get_filename_component(MAKER_MODULE_NAME ${module_folder} NAME)
      maker_utils_debug ("Found module ${module_folder}")
      maker_utils_require_abs (${module_folder}/makerfile)
    endif()
endfunction()

macro(maker_module_add_raw_module_dep raw_module_name)
	set(MAKER_MODULE_DEP_MODULES ${MAKER_MODULE_DEP_MODULES} ${raw_module_name})
endmacro()

macro(maker_module_add_raw_include_dir raw_include_dir)
	set(MAKER_MODULE_INCLUDE_DIRS ${MAKER_MODULE_INCLUDE_DIRS} ${raw_include_dir})
endmacro()
