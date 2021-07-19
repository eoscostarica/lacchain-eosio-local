#!/usr/bin/env bash

if [ -f ../.env ]; then
    # Load Environment Variables
    export $(cat ../.env | grep -v '#' | awk '/=/ {print $1}')
fi

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

  pub=${MIDDLEWARE_EOS_WRITER_PUB_KEY}
  priv=${MIDDLEWARE_EOS_WRITER_PRI_KEY}

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


# Use case
create_account() {
    echo 'Call action'

    cleos push action eosio newaccount \
    '{
      "creator" : "localdev",
      "name" : "someconttest",
      "active" : {
          "threshold":2,
          "keys":[ {"weight":1,"key":"EOS5S4diCy497U9Bff2Kqy7QMKL4x5S3xfmzLKtUh1Va911mwK6RS"}],
          "accounts":[{"weight":1, "permission" :{"actor":"writer", "permission":"access"}}], "waits":[]
      },
      "owner" : {
          "threshold":2,
          "keys":[ {"weight":1,"key":"EOS5S4diCy497U9Bff2Kqy7QMKL4x5S3xfmzLKtUh1Va911mwK6RS"}],
          "accounts":[{"weight":1, "permission" :{"actor":"writer", "permission":"access"}}], "waits":[]
      },
    }' -p localdev@active
}

set_ram() {
    cleos push action eosio setram \
    '{
    "entity":"localdev",
    "account":"someconttest",
    "ram_bytes": 200000
  }' -p localdev@active
}

run_lacchain() {
  echo 'Initializing Local LAC-Chain Testnet !'
  set_lacchain_permissioning
  set_full_partner_entity
  create_account
  set_ram
  echo 'LAC Chain Setup Ready !'
}

run_lacchain