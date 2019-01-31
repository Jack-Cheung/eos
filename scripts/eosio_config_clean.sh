#!/bin/bash
variant=$1
# kill keosd and nodeos
ps -aux | egrep 'nodeos|keosd' | awk '{ print $2}'  | \
while read line
do
    kill -2 $line
done
#remove   keosd and nodeos old installation
if  [  $variant   ];then
echo "remove all the file" 
rm  /usr/opt/EOSIO/* -rf
else
echo remove config file
rm /usr/opt/EOSIO/1.5.0/data/nodeos/config/config.ini
rm /usr/opt/EOSIO/1.5.0/data/keosd/config.int
fi

