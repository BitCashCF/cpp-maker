# Convenience debug wrapper that adds the module name
function(maker_module_debug_log)
  maker_debug_log(${MAKER_MODULE_NAME} ": " ${ARGN})
endfunction()

# Find and include module
macro(maker_module_depend module_name)
  maker_module_debug_log("adding dependency: ${module_name}")
  
  if (EXISTS ${MAKER_BASE_PATH}/libs/${module_name})
    # TODO: check for special lib file and include that if exists
	maker_module_add_raw_module_deps(lib_${module_name})
	maker_module_add_raw_include_dirs(${MAKER_BASE_PATH}/libs/${module_name}/include)
  elseif(EXISTS ${MAKER_BASE_PATH}/ext-libs/${module_name}.makerfile)
    maker_include_abs (${MAKER_BASE_PATH}/ext-libs/${module_name}.makerfile)
  else()
    maker_debug_fatal("Failed to depend on ${module_name} from ${MAKER_MODULE_NAME}")   
  endif()
endmacro()

# Add sources to module
macro(maker_module_set_sources)
  maker_module_debug_log("adding sources: " ${ARGN})
  
  foreach (source ${ARGN})
    set(MAKER_MODULE_SOURCES ${MAKER_MODULE_SOURCES} ${MAKER_MODULE_BASE_PATH}/${source})			      
  endforeach()
endmacro()


# End every lib with this:
macro(maker_module_finalize)
  maker_module_debug_log("finalizing")
  
  # include the makerfile in sources to get it to show in xcode etc
  maker_module_set_sources(makerfile)
  
  if(${MAKER_MODULE_TYPE} MATCHES "app")
    # Create app
    add_executable (app_${MAKER_MODULE_NAME} ${MAKER_MODULE_SOURCES})

    # Set includes
    _maker_module_set_includes(app_${MAKER_MODULE_NAME})
     # Set link dependancies
    _maker_module_set_deps(app_${MAKER_MODULE_NAME})
  endif()
  if(${MAKER_MODULE_TYPE} MATCHES "lib")
    # Create lib
    add_library (lib_${MAKER_MODULE_NAME} ${MAKER_MODULE_SOURCES})
    
    # libs depend on themselves for include etc
    maker_module_depend(${MAKER_MODULE_NAME})
    # Set includes
    _maker_module_set_includes(lib_${MAKER_MODULE_NAME})
    # Set link dependancies
    _maker_module_set_deps(lib_${MAKER_MODULE_NAME})
  endif()  
endmacro()

macro(_maker_module_set_deps full_module_name)
  foreach(dep_module ${MAKER_MODULE_DEP_MODULES})
    message("xx: " ${dep_module})
    target_link_libraries(${full_module_name} ${dep_module})
  endforeach()
endmacro()

macro(_maker_module_set_includes full_module_name)
  foreach(include_dir ${MAKER_MODULE_INCLUDE_DIRS})
    include_directories(${include_dir})
  endforeach()
endmacro()

# Used to create a scope for another module
function(_maker_module_create_module module_folder module_type)
    maker_debug_log("looking in folder ${module_folder} for a valid module")
    
    if(EXISTS ${module_folder}/makerfile)
      set(MAKER_MODULE_BASE_PATH ${module_folder})
      set(MAKER_MODULE_TYPE ${module_type})

      get_filename_component(MAKER_MODULE_NAME ${module_folder} NAME)
      maker_module_debug_log("module found")
      maker_include_once_abs(${module_folder}/makerfile)
    else()
      maker_debug_log("folder does not contain a module")
    endif()
endfunction()

macro(maker_module_add_raw_module_deps)
	set(MAKER_MODULE_DEP_MODULES ${MAKER_MODULE_DEP_MODULES} ${ARGN})
endmacro()

macro(maker_module_add_raw_include_dirs)
	set(MAKER_MODULE_INCLUDE_DIRS ${MAKER_MODULE_INCLUDE_DIRS} ${ARGN})
endmacro()
