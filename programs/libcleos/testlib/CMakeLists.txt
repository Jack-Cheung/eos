set (TEST_EXECUTABLE_NAME "testlib")
add_executable( ${TEST_EXECUTABLE_NAME} main.cpp ../cleos.hpp )

#configure_file(config.hpp.in config.hpp ESCAPE_QUOTES)

#target_include_directories(${TEST_LIB_NAME} PUBLIC ${Intl_INCLUDE_DIRS} ${CMAKE_CURRENT_BINARY_DIR})

target_link_libraries( ${TEST_EXECUTABLE_NAME}
                      PRIVATE client )