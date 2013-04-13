# Include file relative the current file, but only if not already included
macro(maker_include_once relative_file)
  maker_include_once_abs(${CMAKE_CURRENT_LIST_DIR}/${relative_file}) 
endmacro()

macro(maker_include_once_abs abs_file)
  if (NOT DEFINED _MAKER_INCLUDE_GUARD_${abs_file})
    set(_MAKER_INCLUDE_GUARD_${abs_file} 1)
    include(${abs_file})
  else()
    maker_debug_log("already included ${abs_file}")
  endif()
endmacro()

# Include file relative the current file, even if included before
macro(maker_include relative_file)
  maker_include_abs(${CMAKE_CURRENT_LIST_DIR}/${relative_file}) 
endmacro()

# Include file relative the current file, even if included before
macro(maker_include_abs abs_file)
  include(${abs_file}) 
endmacro()