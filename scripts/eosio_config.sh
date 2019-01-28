#!/bin/bash
if [ $# -ne 3 ];then
    echo "usage: $0 [nodeos data-dir] [nodeos config-dir] [eosio.token contract-dir]";
    exit 1;
fi

# eosio 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3  EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
#eosio.token [Private key: 5KCcKs67oWgSLFF9F2zc3Yxbb414u6bKnrHpuypWp55SEJ7Ewhr Public key: EOS8APcg6ta4hvwiqk5Xtf7djakytDoWQQAdAD938e6d5YeXNkDef]
#keosd --config-dir "$3"  > "$3/log.txt" &
if [ $? -ne 0 ];then
    echo keosd failed to start up!
    exit 3;
fi

keosd --http-server-address 0.0.0.0:8900  --wallet-dir "." \
      --data-dir "/usr/opt/EOSIO/1.5.0/data/keosd/"  \
      > "/usr/opt/EOSIO/1.5.0/data/keosd/log.txt" &

sleep 20;

cleos wallet create --to-console;
cleos wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3;
cleos wallet import --private-key 5KCcKs67oWgSLFF9F2zc3Yxbb414u6bKnrHpuypWp55SEJ7Ewhr;
#create eosio.token account and set contract

nodeos --data-dir "$1" --config-dir $2 >"$1/log.txt" &
if [ $? -ne 0 ];then
    echo nodeos failed to start up!
    exit 2;
fi

sleep 20;

cleos create account eosio eosio.token  EOS8APcg6ta4hvwiqk5Xtf7djakytDoWQQAdAD938e6d5YeXNkDef -p eosio;

sleep 3;

cleos set contract eosio.token $3  -p eosio.token;