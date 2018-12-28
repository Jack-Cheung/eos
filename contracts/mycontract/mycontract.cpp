#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>
//#include <eosiolib/types.hpp>

using namespace eosio;

class [[eosio::contract]]  mycontract : public contract {
  public:
      using contract::contract;

      [[eosio::action]]
      void hi( name user ) {
         print( "Hello, ", user);
      }
      [[eosio::action]]
      void addstring(uint64_t id, std::string str)
      {
         string_index table(_code, _code.value);
         table.emplace(_code, [&](auto& itm){
            itm.str = str;
            itm.id = id;
         });
      }
      [[eosio::action]]
      void getstring()
      {

      }
   private:
      struct [[eosio::table]] stringtable
      {
         std::string str;
         uint64_t id;
         uint64_t primary_key() const { return id;}
      };
      typedef eosio::multi_index< "stringtable"_n, stringtable > string_index;
};
EOSIO_DISPATCH( mycontract, (hi)(addstring)(getstring))