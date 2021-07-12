#!/usr/bin/env bash

set_lacchain_permissioning() {
  echo 'Set Writer RAM'
  cleos push action eosio setalimits '["writer", 10485760, 0, 0]' -p eosio

  echo 'Create Network Groups'
  cleos push action eosio netaddgroup '["v1", ["eosio"]]' -p eosio@active
  cleos push action eosio netaddgroup '["b1", []]' -p eosio@active
  cleos push action eosio netaddgroup '["b2", []]' -p eosio@active
  cleos push action eosio netaddgroup '["w1", []]' -p eosio@active
  cleos push action eosio netaddgroup '["o1", []]' -p eosio@active

  echo 'Inspect Groups Table'
  cleos get table eosio eosio netgroup
}

set_full_partner_entity() {
  echo 'Create BIOS Partner Account'

  keys=($(cleos create key --to-console))
  pub=${keys[5]}
  priv=${keys[2]}

  mkdir -p ./secrets
  echo $priv >./secrets/entity.priv
  echo $pub >./secrets/entity.pub

  cleos wallet import --private-key $priv

  echo 'Create Partner Entity'
  cleos push action eosio addentity '["localdev", 1, '$pub']' -p eosio@active

  echo 'Get Partner Entity Account'
  cleos get account localdev

  echo 'Set Entity Info'
  cleos push action eosio setentinfo '{"entity":"localdev", "info": "'$(printf %q $(cat $WORK_DIR/entity-node-info/entity.json | tr -d "\r"))'"}' -p localdev@active

  echo 'Inspect entity Table'
  cleos get table eosio eosio entity

  echo 'Register Writer'
  cleos push action eosio addwriter \
    '{
	"name": "localnode",
	"entity": "localdev",
	"writer_authority": {
		"threshold": 1,
		"keys": [{
			"key": "'$pub'",
			"weight": 1
		}],
		"accounts": [],
		"waits": []
	  }
  }' -p localdev@active

  echo 'Set Writer Node Group'
  cleos push action eosio netsetgroup '["localnode", ["b1"]]' -p eosio@active

  echo 'Set Writer Node Info'
  cleos push action eosio setnodeinfo '{"node":"localnode", "info": "'$(printf %q $(cat $WORK_DIR/entity-node-info/writer.json | tr -d "\r"))'"}' -p localdev@active

  echo 'Show writer account'
  cleos get account writer

  echo 'Check Nodes Table'
  cleos get table eosio eosio node
}

run_lacchain() {
  echo 'Initializing Local LAC-Chain Testnet !'
  set_lacchain_permissioning
  set_full_partner_entity
  echo 'LAC Chain Setup Ready !'
}

run_lacchain