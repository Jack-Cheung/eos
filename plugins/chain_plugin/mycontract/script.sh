# 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3  
# EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV  develop key

#   mycontract key
#Private key: 5K5iT9EdUCQbS7uCqa5LVFJSpVE3UDXs1yYXTy1j5FuzEaE4PWV
#Public key: EOS7niHAT62uCvPjPhxMT4m3LJ6BbV9wh4bTJ3LRB8eG5zmjJUX46
git clone https://github.com/Jack-Cheung/eos.git --recursive

keosd  --http-server-address=0.0.0.0:8900

nodeos --config-dir ~/contracts/eosio/config/ --data-dir ~/contracts/eosio/data \
 --replay-blockchain --hard-replay-blockchain

cleos wallet create 

cleos wallet import 5K5iT9EdUCQbS7uCqa5LVFJSpVE3UDXs1yYXTy1j5FuzEaE4PWV 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

cleos create account eosio mycontract EOS7niHAT62uCvPjPhxMT4m3LJ6BbV9wh4bTJ3LRB8eG5zmjJUX46

cleos set contract mycontract ~/github/eos/contracts/mycontract -p mycontract

cleos  --url http://192.168.1.125:8888/  --wallet-url  http://192.168.1.125:8900/  \
push action mycontract addstring '[2, "strcontant"]' -p mycontract

curl --request POST   --url http://127.0.0.1:8888/v1/chain/get_string   --data '{"idx":10}'
#清空表数据 
cleos push action mycontract clear '[]'  -p mycontract