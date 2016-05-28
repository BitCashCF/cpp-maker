# enable_testing is required for us to hook into the cmake test system
enable_testing()

# Include gtest
add_subdirectory(
  ${MAKER_SYSTEM_PATH}/googletest-release-1.7.0/
  ${CMAKE_BINARY_DIR}/googletest-release-1.7.0/)

# Create a gtest (automatically called for modules)
macro(maker_gtest_create_gtest gtest_folder
    test_name
    extra_includes
    extra_targets)

  maker_debug_log("creating tests in folder ${gtest_folder}")
  file(GLOB test_files ${gtest_folder}/*.cpp)

  include_directories(${MAKER_SYSTEM_PATH}/googletest-release-1.7.0/include)
  include_directories(${extra_includes})

  # Add test cpp file
  add_executable(
    ${test_name}
    ${test_files})

  # Link test executable against gtest & gtest_main
  target_link_libraries(
    ${test_name}
    gtest_main
    ${extra_targets})

  # Add the test to the cmake test system (make test/ninja test etc)
  add_test(
    NAME ${test_name}
    COMMAND ${test_name})
endmacro()
