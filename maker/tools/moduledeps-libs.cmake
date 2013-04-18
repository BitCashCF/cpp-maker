macro(maker_moduledeps_dynamic_create module_name folder)
  if (EXISTS ${MAKER_BASE_PATH}/${folder}/${module_name})
    maker_module_add_raw_module_deps(lib_${module_name})
    maker_module_add_raw_include_dirs(
      ${MAKER_BASE_PATH}/${folder}/${module_name}/include)
  endif()
endmacro()