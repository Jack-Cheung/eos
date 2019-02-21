/**
 *  @file
 *  @copyright defined in eos/LICENSE.txt
 */
#pragma once
#include <eosiolib/types.h>
#include <functional>
#include <tuple>
#include <string>

namespace eosio {

   /**
    *  Converts a base32 symbol into its binary representation, used by string_to_name()
    *
    *  @brief Converts a base32 symbol into its binary representation, used by string_to_name()
    *  @param c - Character to be converted
    *  @return constexpr char - Converted character
    *  @ingroup types
    */
   static constexpr  char char_to_symbol( char c ) {
      if( c >= 'a' && c <= 'z' )
         return (c - 'a') + 6;
      if( c >= '1' && c <= '5' )
         return (c - '1') + 1;
      return 0;
   }


   /**
    *  Converts a base32 string to a uint64_t. This is a constexpr so that
    *  this method can be used in template arguments as well.
    *
    *  @brief Converts a base32 string to a uint64_t.
    *  @param str - String representation of the name
    *  @return constexpr uint64_t - 64-bit unsigned integer representation of the name
    *  @ingroup types
    */
   static constexpr uint64_t string_to_name( const char* str ) {

      uint32_t len = 0;
      while( str[len] ) ++len;

      uint64_t value = 0;

      for( uint32_t i = 0; i <= 12; ++i ) {
         uint64_t c = 0;
         if( i < len && i <= 12 ) c = uint64_t(char_to_symbol( str[i] ));

         if( i < 12 ) {
            c &= 0x1f;
            c <<= 64-5*(i+1);
         }
         else {
            c &= 0x0f;
         }

         value |= c;
      }

      return value;
   }


} // namespace eosio


