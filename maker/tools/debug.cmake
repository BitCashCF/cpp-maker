# Debug functions

# Output messages during cmake configuration phase
function(maker_debug_log)
  set(MAKER_PRINT_DEBUG "ON" CACHE BOOL "Turn on maker debugging")
  if(${MAKER_PRINT_DEBUG} MATCHES "ON")
    message(${ARGN})	  
  endif()
endfunction()

# Output messages during cmake configuration phase
function(maker_debug_fatal)
  message(FATAL_ERROR ${ARGN})			  
endfunction()