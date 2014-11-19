macro(maker_moduletype_add_extra_deps)
  # Protocols depend on themselves for includes etc
  maker_module_depend(protobuf)
  maker_module_depend(${MAKER_MODULE_NAME})
endmacro()

macro(maker_moduletype_create_target)
  PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${MAKER_MODULE_SOURCES})
  include_directories(${CMAKE_CURRENT_BINARY_DIR})
  add_library (${MAKER_MODULE_TARGET_NAME} ${PROTO_SRCS} ${PROTO_HDRS} ${MAKER_MODULE_SOURCES})  
endmacro()
