//#include <eosiolib/eosio.hpp>
//#include <eosiolib/types.hpp>TODO why cannot find it
#include <eosiolib/transaction.hpp>
#include <eosiolib/asset.hpp>
#include "include/types.hpp"
using namespace eosio;


class [[eosio::contract]]  delaytrans : public contract {
  public:
      using contract::contract;
      [[eosio::action]]
      void send( name from, name to, asset amount, std::string memo, uint64_t delay) {
         require_auth(from);
         print( "Hello, ", from);
         transaction t{};
         t.actions.emplace_back(
         permission_level(from, "active"_n), // with `from@active` permission
         "eosio.token"_n, // You're sending this to `eosio.token`
         "transfer"_n,   // to their `transfer` action
         std::make_tuple(from, to, amount, memo));  // with the appropriate args
         t.delay_sec = delay; // Set the delay
         t.send(string_to_name(memo.c_str()), from); // Send the transaction with some ID derived from the memo
      }
   /* private:
      struct [[eosio::table]] stringtable
      {
         std::string str;
         uint64_t id;
         uint64_t primary_key() const { return id;}
      };
      typedef eosio::multi_index< "stringtable"_n, stringtable > string_index; */
};
EOSIO_DISPATCH( delaytrans , (send))