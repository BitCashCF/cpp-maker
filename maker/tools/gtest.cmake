enable_testing()

macro(maker_gtest_create_gtest gtest_folder test_name extra_includes extra_targets)
	maker_debug_log("creating tests in folder "${gtest_folder})
	file(GLOB test_files ${gtest_folder}/*.cpp)
	
	include_directories(${MAKER_SYSTEM_PATH}/gtest-1.6.0/include)
	include_directories(${extra_includes})

	# Add test cpp file
	add_executable(${test_name}
    	${test_files}
	)

	# Link test executable against gtest & gtest_main
	target_link_libraries(${test_name} gtest_main ${extra_targets})

	add_test(
    	NAME ${test_name}
	    COMMAND ${test_name})

endmacro()