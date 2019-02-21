set (TEST_LIB_NAME "client")
add_library( ${TEST_LIB_NAME} STATIC main.cpp httpc.cpp help_text.cpp localize.hpp config.hpp CLI11.hpp cleos.hpp)
find_package(Intl REQUIRED)
configure_file(config.hpp.in config.hpp ESCAPE_QUOTES)
target_include_directories(${TEST_LIB_NAME} PUBLIC ${Intl_INCLUDE_DIRS} ${CMAKE_CURRENT_BINARY_DIR})
target_link_libraries( ${TEST_LIB_NAME}
                      PRIVATE appbase chain_api_plugin producer_plugin chain_plugin http_plugin eosio_chain fc ${CMAKE_DL_LIBS} ${PLATFORM_SPECIFIC_LIBS} ${Intl_LIBRARIES} )
add_subdirectory(testlib)