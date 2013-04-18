macro(maker_moduletype_add_extra_deps)
  # Libraries depend on themselves for includes etc
  maker_module_depend(${MAKER_MODULE_NAME})
endmacro()

macro(maker_moduletype_create_target)
  add_library (${MAKER_MODULE_TARGET_NAME} ${MAKER_MODULE_SOURCES})  
endmacro()

