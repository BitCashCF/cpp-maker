macro(maker_moduledeps_dynamic_create module_name folder)
  if (EXISTS ${MAKER_BASE_PATH}/${folder}/${module_name})
    maker_module_add_raw_module_deps(protocol_${module_name})
    # TODO: should be in protocol seperate folders...
    maker_module_add_raw_include_dirs(${CMAKE_CURRENT_BINARY_DIR}) 
  endif()
endmacro()
