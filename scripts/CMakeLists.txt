

set(DESC "desc")
set(URL "")
set(EMAIL "374511110@qq.com")
configure_file(eosio-tn_bounce.sh eosio-tn_bounce.sh COPYONLY)
configure_file(eosio-tn_down.sh eosio-tn_down.sh COPYONLY)
configure_file(eosio-tn_roll.sh eosio-tn_roll.sh COPYONLY)
configure_file(eosio-tn_up.sh eosio-tn_up.sh COPYONLY)
configure_file(abi_is_json.py abi_is_json.py COPYONLY)
configure_file(generate_package.sh.in generate_package.sh ESCAPE_QUOTES @ONLY)
configure_file(generate_rpm.sh generate_rpm.sh COPYONLY)
configure_file(generate_deb.sh generate_deb.sh COPYONLY)
configure_file(generate_tarball.sh generate_tarball.sh COPYONLY)
configure_file(nodeos-config.ini nodeos-config.ini COPYONLY)
configure_file(keosd-config.ini keosd-config.ini COPYONLY)
configure_file(eosio_config.sh eosio_config.sh COPYONLY)




