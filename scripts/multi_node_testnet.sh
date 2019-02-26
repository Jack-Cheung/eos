#!/bin/bash
if [ $# -ne 1 ];then
    echo "usage $0 <number of nodes> \n note:[3~9]expected"
    exit
fi
node_num=$1
echo "I will create $node_num node(s)"
key_pairs=(
    "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV=KEY:5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"
    "EOS6FDRMXLyJAoN7kBCKiXaVRUw33PHK7NtQokfx8UpaCrNgzds2d=KEY:5J4TKkxA6YHJpnFH9UhzMAPr4CqLzaa6Pft9o78C8FzYXh11XFx"
    "EOS6rZhuV15h14Rp2PfkJQo6q1uiWdLKmCgRzP1HKHiFx9zzYUYii=KEY:5J4ZVVyfmjgMBQkEGcjakJkTu8253UPnnPhqwTHzmvSVgbqvoQt"
    "EOS7SGCNUcMA2rh8HsdNDsZvAy72Wwn3kBBYF1Fhm5BpG1QeW38sY=KEY:5HwV7L5KRKySzajEPh8bmtt6f5yrG5aoWqfLm4fVxUeV5V3LERT"
    "EOS8Pufp4VVCKnF96dQJJXjwLExLpJDEcz2CicqezW3iDwNFVGXs7=KEY:5JTELew9CzDEF4zWBmGR2dmCLuvJAzQFVsRivug8ARLU51U7ixj"
)
#create folder and config file
root_dir=~/multi_node_test_net
mkdir -p ${root_dir}/keosd
this_dir=`dirname $0`
for  i in `seq 1 ${node_num}`
do
    node_dir=${root_dir}/node_$i
    mkdir -p ${node_dir}/data
    mkdir ${node_dir}/config
    cat ${this_dir}/nodeos-config-test.ini | sed "s/0.0.0.0:8888/0.0.0.0:888${i}/g" \
    | sed "s/signature-provider =.*$/signature-provider = ${key_pairs[$i-1]}/g"  \
    | sed "s/p2p-listen-endpoint = 0.0.0.0:9876/p2p-listen-endpoint = 0.0.0.0:987${i}/g" \
    | sed "s/p2p-max-nodes-per-host = 1/p2p-max-nodes-per-host = 10/g" \
     > ${node_dir}/config.ini
    #| sed "s/bnet-endpoint = 0.0.0.0:4321/bnet-endpoint = 0.0.0.0:432${i}/" \
    if [ $i -ne 1 ]
    then 
        sed -i "s/enable-stale-production = true/enable-stale-production = false/g"  ${node_dir}/config.ini
    fi
    for j in `seq 1 ${node_num}`
    do
        if [ $j -ne $i ];then
            echo "p2p-peer-address = 127.0.0.1:987${j}" >> ${node_dir}/config.ini
        fi
        if [ $j -ne 1 ];then
            echo "producer-name = node${j}" >>  ${node_dir}/config.ini
        fi
    done
done

#start multi-node testnet
#start keosd
keosd_dir=${root_dir}/keosd
keosd --http-server-address 0.0.0.0:8900  --wallet-dir "." \
      --data-dir "${keosd_dir}"  \
      --config-dir "${keosd_dir}"  \
      &>"${keosd_dir}/log.txt" &
cleos --wallet-url http://127.0.0.1:8900 wallet create --to-console  &> "${keosd_dir}/passwd.txt"
#import keys
for k in ${key_pairs[@]}
do
    array=(${k//=KEY:/ })
    cleos --wallet-url http://127.0.0.1:8900  \
    wallet import --private-key  ${array[1]};  
done
#start producer node
data_dir=${root_dir}/node_1/data
config_dir=${root_dir}/node_1
nodeos  --data-dir ${data_dir} --config-dir ${config_dir}   &>"${data_dir}/log.txt" &
echo "--data-dir ${data_dir} --config-dir ${config_dir}"
sleep 10
#set bios contract
cleos --wallet-url http://127.0.0.1:8900 --url http://127.0.0.1:8881 set contract eosio ${this_dir}/../build/contracts/eosio.bios
sleep 10
#start other nodeos
for i in `seq 2 $node_num`
do
    k=${key_pairs[$i-1]}
    arr=(${k//=KEY:/ })
    public_key=${arr[0]}
    cleos --wallet-url http://127.0.0.1:8900  \
    --url http://127.0.0.1:8881 \
    create account eosio node$i  $public_key -p eosio 
    sleep 5
    data_dir=${root_dir}/node_$i/data
    config_dir=${root_dir}/node_$i
    nodeos  --data-dir ${data_dir} --config-dir ${config_dir}   &>"${data_dir}/log.txt" &
done

# change producer
#cleos --wallet-url http://127.0.0.1:8900 --url http://127.0.0.1:8881  push action eosio setprods \ 
#"{ \"schedule\": [{\"producer_name\": \"node2\",\"block_signing_key\": \"EOS6FDRMXLyJAoN7kBCKiXaVRUw33PHK7NtQokfx8UpaCrNgzds2d\"}]}" -p eosio@active