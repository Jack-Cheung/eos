#!/bin/bash
if [ $# -ne 5 ];then
    echo "usage: $0 [nodeos data-dir] [nodeos config-dir] [keosd config-dir] [keosd data-dir] [eosio.token contract-dir]";
    exit 1;
fi

# eosio 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3  EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
#eosio.token [Private key: 5KCcKs67oWgSLFF9F2zc3Yxbb414u6bKnrHpuypWp55SEJ7Ewhr Public key: EOS8APcg6ta4hvwiqk5Xtf7djakytDoWQQAdAD938e6d5YeXNkDef]
keosd --config-dir "$3" --wallet-dir "$4" > "$3/log.txt" &
if [ $? -ne 0 ];then
    echo keosd failed to start up!
    exit 3;
fi
cleos wallet create --to-console;
cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3;
cleos wallet import --private-key 5KCcKs67oWgSLFF9F2zc3Yxbb414u6bKnrHpuypWp55SEJ7Ewhr;
#create eosio.token account and set contract

nodeos --data-dir "$1" --config-dir $2 >"$1/log.txt" &
if [ $? -ne 0 ];then
    echo "nodeos --data-dir $1 --config-dir $2 1> $1/log.txt 2>$1/error.txt &";
    echo nodeos failed to start up!
    exit 2;
fi

sleep 10;

cleos create account eosio eosio.token  EOS8APcg6ta4hvwiqk5Xtf7djakytDoWQQAdAD938e6d5YeXNkDef -p eosio;
cleos set contract eosio.token $5  -p eosio.token;