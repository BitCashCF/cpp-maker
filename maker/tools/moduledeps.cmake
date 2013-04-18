# Create dep from currently processed module to another module
macro(maker_moduledeps_create_dep module_name)
  foreach(type ${MAKER_MODULEDEPS_TYPES_HANDLED}) 
    maker_include_abs(
      "${MAKER_SYSTEM_PATH}/tools/moduledeps-${type}.cmake")
    maker_moduledeps_dynamic_create(
      ${module_name} 
      ${MAKER_MODULEDEPS_TYPE_${type}_FOLDER})
  endforeach()
endmacro()

macro(maker_moduledeps_add_type type folder)
  set(MAKER_MODULEDEPS_TYPE_${type}_FOLDER ${folder})
  set(MAKER_MODULEDEPS_TYPES_HANDLED 
    ${MAKER_MODULEDEPS_TYPES_HANDLED} 
    ${type})
endmacro()