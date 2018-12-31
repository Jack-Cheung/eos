#ifndef _CLEOS_HPP
#define _CLEOS_HPP

#include <stdint.h>
int new_transaction(uint64_t id, const char* trx);
const char* get_transaction(uint64_t id);
#endif