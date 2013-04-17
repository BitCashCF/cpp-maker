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

macro(_maker_module_set_deps full_module_name)
  foreach(dep_module ${MAKER_MODULE_DEP_MODULES})
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
    
      set(MAKER_MODULE_TARGET_NAME ${MAKER_MODULE_TYPE}_${MAKER_MODULE_NAME})

      maker_module_debug_log("module found")
      maker_include_once_abs(${module_folder}/makerfile)
      
      # Finalize module
      _maker_module_finalize()   
 
      # Find gtests
      _maker_module_create_tests()
    else()
      maker_debug_log("folder does not contain a module")
    endif()
endfunction()

macro(_maker_module_finalize)
  maker_module_debug_log("finalizing")
  
  # include the makerfile in sources to get it to show in xcode etc
  maker_module_set_sources(makerfile)
  
  if(${MAKER_MODULE_TYPE} MATCHES "app")
    # Create app
    add_executable (${MAKER_MODULE_TARGET_NAME} ${MAKER_MODULE_SOURCES})
  endif()
  if(${MAKER_MODULE_TYPE} MATCHES "lib")
    # Create lib
    add_library (${MAKER_MODULE_TARGET_NAME} ${MAKER_MODULE_SOURCES})
    # libs depend on themselves for include etc
    maker_module_depend(${MAKER_MODULE_NAME})
  endif()  

    # Set includes
    _maker_module_set_includes(${MAKER_MODULE_TARGET_NAME})
    # Set link dependancies
    _maker_module_set_deps(${MAKER_MODULE_TARGET_NAME})
endmacro()

macro (_maker_module_create_tests)
	if(EXISTS ${MAKER_MODULE_BASE_PATH}/gtests)
		maker_module_debug_log("found test dir")
		maker_gtest_create_gtest(${MAKER_MODULE_BASE_PATH}/gtests 
			${MAKER_MODULE_TARGET_NAME}_test
			"${MAKER_MODULE_INCLUDE_DIRS} ./"
			${MAKER_MODULE_TARGET_NAME})
	endif()
endmacro()


macro(maker_module_add_raw_module_deps)
	set(MAKER_MODULE_DEP_MODULES ${MAKER_MODULE_DEP_MODULES} ${ARGN})
endmacro()

macro(maker_module_add_raw_include_dirs)
	set(MAKER_MODULE_INCLUDE_DIRS ${MAKER_MODULE_INCLUDE_DIRS} ${ARGN})
endmacro()
