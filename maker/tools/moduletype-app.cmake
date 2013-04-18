macro(maker_moduletype_add_extra_deps)
endmacro()

macro(maker_moduletype_create_target)
  # Create app
  add_executable (${MAKER_MODULE_TARGET_NAME} ${MAKER_MODULE_SOURCES})
endmacro()
