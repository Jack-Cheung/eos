#!/bin/bash
if [ $# -ne 3 ];then
    echo "usage: $0 [nodeos data-dir] [nodeos config-dir] [eosio.token contract-dir]";
    exit 1;
fi

# eosio 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3  EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
#eosio.token [Private key: 5KCcKs67oWgSLFF9F2zc3Yxbb414u6bKnrHpuypWp55SEJ7Ewhr Public key: EOS8APcg6ta4hvwiqk5Xtf7djakytDoWQQAdAD938e6d5YeXNkDef]
#keosd --config-dir "$3"  > "$3/log.txt" &

#private key for  node0 ~ node9
# node0 {"priv_key":"5Jb9puXXLktJv6GaUBX283K6nakfXnxh9AmKozP5TSbVzPyRBMT","pub_key":"EOS6SRVVxe5TEDtBPwAofzsqL13ocEpmruefDLHoawZtEDegKW1R9"}
# node1 {"priv_key":"5KanZezpuWRETcXFcCk9NNwLdi6iQkwUiEDS9e4GFMsqcSqN8Pa","pub_key":"EOS5BaSrRrUF5pt1yNwyLZ6f3PK7qvcK6MxCGv3bg3v2HfiAyY25F"}
# node2 {"priv_key":"5JtunPtxTBhTc7MbDiU7nVxJgVvip8ev1WBat75hbo8aMYDseyq","pub_key":"EOS74VS6sZwSN3pY2W7yRueDYnesrFkVmxrjZXpofghi6Se5uJxVf"}
# node3 {"priv_key":"5KQsu9D32EHqfzussusw5PUE4ugGefPwWKRW6uGBDr3jc8VGq1J","pub_key":"EOS5vSqZLv8iQWtxND98xrQHyhYxM3iv9jjMSaeLSCTekLsgQTkxA"}
# node4 {"priv_key":"5KCoPZTUb8kvUc1uywMBYVLX4Siij8ZUZrHf3jyLdGFo6cQFg7d","pub_key":"EOS54zE7tS2C6qEE4D1m8S2jQgMd3SoL4LoA7mpVzbqpUZEK3dG7w"}
# node5 {"priv_key":"5JcruhDeTM96NN5sYKNCbJRicYzhTu2ft7biNgrkDdhEYZMNfGK","pub_key":"EOS5FtZKobg7MgHui4Upm1C43995PN1363myWiF1pD1unxfdm2LVB"}
# node6 {"priv_key":"5J5Md7vxBSB7UNAVqKxU2Jo8DfWBFqiWPUEKrVTpZAJjauJu9CR","pub_key":"EOS63rTSAANLv1p29MbFGL9vzvuKwo2Y72RRfmjkEbt6885UqTXUZ"}
# node7 {"priv_key":"5Jzev96J75x4mX6R5QNCwkqtpkPwcPZMCiPMWSt8TWxJ3PioJGL","pub_key":"EOS59jKDbmMe2mt6N7MYyab9zerFob5s8GKrGLoSXwQXLJwLVVAqJ"}
# node8 {"priv_key":"5JntR6oDwYkJsUEttW6o8wk5yyMRRYJAQkmThStCy5TGeppHhks","pub_key":"EOS5rPjCDTLZPK9AEYZ8X2Tu6TY52hB1wKAgeUhUgeP6ZyLstueSA"}
# node9 {"priv_key":"5KXV2YA7SZbuaABVwp42PxwdQh9zTA3rhXRTY8TqcakxNKAwrLX","pub_key":"EOS7vA1odf6W9tvEiaHiCbzSBbF2iyJ7JtwKAjKaTb7SZ7Ym1kPqW"}
if [ $? -ne 0 ];then
    echo keosd failed to start up!
    exit 3;
fi

keosd --http-server-address 0.0.0.0:8900  --wallet-dir "." \
      --data-dir "/usr/opt/EOSIO/1.5.0/data/keosd/"  \
      --config-dir "/usr/opt/EOSIO/1.5.0/data/keosd/"  \
      1> "/usr/opt/EOSIO/1.5.0/data/keosd/log.txt"  2>"/usr/opt/EOSIO/1.5.0/data/keosd/log.txt" &

sleep 20;

cleos --wallet-url http://127.0.0.1:8900 wallet create --to-console;
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3;
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5KCcKs67oWgSLFF9F2zc3Yxbb414u6bKnrHpuypWp55SEJ7Ewhr;  

cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5Jb9puXXLktJv6GaUBX283K6nakfXnxh9AmKozP5TSbVzPyRBMT;  
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5KanZezpuWRETcXFcCk9NNwLdi6iQkwUiEDS9e4GFMsqcSqN8Pa;  
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5JtunPtxTBhTc7MbDiU7nVxJgVvip8ev1WBat75hbo8aMYDseyq;  
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5KQsu9D32EHqfzussusw5PUE4ugGefPwWKRW6uGBDr3jc8VGq1J;  
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5KCoPZTUb8kvUc1uywMBYVLX4Siij8ZUZrHf3jyLdGFo6cQFg7d;  
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5JcruhDeTM96NN5sYKNCbJRicYzhTu2ft7biNgrkDdhEYZMNfGK;  
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5J5Md7vxBSB7UNAVqKxU2Jo8DfWBFqiWPUEKrVTpZAJjauJu9CR;  
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5Jzev96J75x4mX6R5QNCwkqtpkPwcPZMCiPMWSt8TWxJ3PioJGL;  
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5JntR6oDwYkJsUEttW6o8wk5yyMRRYJAQkmThStCy5TGeppHhks;  
cleos --wallet-url http://127.0.0.1:8900 wallet import --private-key 5KXV2YA7SZbuaABVwp42PxwdQh9zTA3rhXRTY8TqcakxNKAwrLX;  

#create eosio.token account and set contract

nodeos --data-dir "$1" --config-dir $2   1>"$1/log.txt"   2>"$1/log.txt"  &
if [ $? -ne 0 ];then
    echo nodeos failed to start up!
    exit 2;
fi

sleep 20;

cleos --wallet-url http://127.0.0.1:8900 create account eosio eosio.token  EOS8APcg6ta4hvwiqk5Xtf7djakytDoWQQAdAD938e6d5YeXNkDef -p eosio;
sleep 1;
cleos --wallet-url http://127.0.0.1:8900 create account eosio nodea  EOS6SRVVxe5TEDtBPwAofzsqL13ocEpmruefDLHoawZtEDegKW1R9 -p eosio;
sleep 1
cleos --wallet-url http://127.0.0.1:8900 create account eosio nodeb  EOS5BaSrRrUF5pt1yNwyLZ6f3PK7qvcK6MxCGv3bg3v2HfiAyY25F -p eosio;
sleep 1;
cleos --wallet-url http://127.0.0.1:8900 create account eosio nodec   EOS74VS6sZwSN3pY2W7yRueDYnesrFkVmxrjZXpofghi6Se5uJxVf -p eosio;
sleep 1;
cleos --wallet-url http://127.0.0.1:8900 create account eosio noded  EOS5vSqZLv8iQWtxND98xrQHyhYxM3iv9jjMSaeLSCTekLsgQTkxA -p eosio;
sleep 1;
cleos --wallet-url http://127.0.0.1:8900 create account eosio nodee  EOS54zE7tS2C6qEE4D1m8S2jQgMd3SoL4LoA7mpVzbqpUZEK3dG7w -p eosio;
sleep 1;
cleos --wallet-url http://127.0.0.1:8900 create account eosio nodef   EOS5FtZKobg7MgHui4Upm1C43995PN1363myWiF1pD1unxfdm2LVB -p eosio;
sleep 1;
cleos --wallet-url http://127.0.0.1:8900 create account eosio nodeg   EOS63rTSAANLv1p29MbFGL9vzvuKwo2Y72RRfmjkEbt6885UqTXUZ -p eosio;
sleep 1;
cleos --wallet-url http://127.0.0.1:8900 create account eosio nodeh  EOS59jKDbmMe2mt6N7MYyab9zerFob5s8GKrGLoSXwQXLJwLVVAqJ -p eosio;
sleep 1;
cleos --wallet-url http://127.0.0.1:8900 create account eosio nodei   EOS5rPjCDTLZPK9AEYZ8X2Tu6TY52hB1wKAgeUhUgeP6ZyLstueSA -p eosio;
sleep 1;
cleos --wallet-url http://127.0.0.1:8900 create account eosio nodej   EOS7vA1odf6W9tvEiaHiCbzSBbF2iyJ7JtwKAjKaTb7SZ7Ym1kPqW -p eosio;
sleep 1;



cleos --wallet-url http://127.0.0.1:8900 set contract eosio.token $3  -p eosio.token;
sleep 3;
cleos  --wallet-url http://127.0.0.1:8900 --url http://127.0.0.1:8888  push action eosio.token create '["eosio","100000000.00 QWC"]' -p eosio.token
sleep 3;
cleos  --wallet-url http://127.0.0.1:8900 --url http://127.0.0.1:8888  push action eosio.token  issue  '["eosio","100000000.00 QWC",""]'   -p eosio