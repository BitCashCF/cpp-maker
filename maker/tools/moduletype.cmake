# Find and create all makerfile based modules
function(maker_moduletype_create_modules)
  foreach(prefix ${MAKER_MODULETYPE_TYPES})
    maker_include_once_abs(
      "${MAKER_SYSTEM_PATH}/tools/moduletype-${prefix}.cmake")
    maker_debug_log("creating modules for type " ${prefix} " in folder " ${MAKER_MODULETYPE_TYPE_${prefix}_FOLDER})

    file(GLOB potential_apps "${MAKER_MODULETYPE_TYPE_${prefix}_FOLDER}/*")
    foreach (potential_app ${potential_apps})
      _maker_module_create_module(${potential_app} ${prefix})
    endforeach()
  endforeach() 
endfunction()

macro(maker_moduletype_add prefix folder)
  set(MAKER_MODULETYPE_TYPES ${MAKER_MODULETYPE_TYPES} ${prefix})
  set(MAKER_MODULETYPE_TYPE_${prefix}_FOLDER ${folder})
endmacro()
