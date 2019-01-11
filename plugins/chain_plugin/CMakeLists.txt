add_subdirectory(mycontract)

#   execute_process(
#   COMMAND cat 
#       ${CMAKE_CURRENT_SOURCE_DIR}/mycontract/mycontract.abi
#   COMMAND tr 
#       -d "'\n'"
#   RESULT_VARIABLE "abi_Res"
#   OUTPUT_VARIABLE "COMPRESSED_MYCONTRACT_ABI"
#   #OUTPUT_STRIP_TRAILING_WHITESPACE
#   )
set(MYCONTRACT_PRIVATE_KEY 5K5iT9EdUCQbS7uCqa5LVFJSpVE3UDXs1yYXTy1j5FuzEaE4PWV)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/include/config.hpp.ini
 ${CMAKE_CURRENT_SOURCE_DIR}/include/config.hpp ESCAPE_QUOTES)

file(GLOB HEADERS "include/eosio/chain_plugin/*.hpp")
add_library( chain_plugin
             chain_plugin.cpp
             ${HEADERS} )

target_link_libraries( chain_plugin eosio_chain appbase )
target_include_directories( chain_plugin PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/include" "${CMAKE_CURRENT_SOURCE_DIR}/../chain_interface/include" "${CMAKE_CURRENT_SOURCE_DIR}/../../libraries/appbase/include")
