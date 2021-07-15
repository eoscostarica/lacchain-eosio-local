create_account() {
    echo 'Call action'
    mkdir -p ./stdout/register
    TEMP_DIR=./stdout/register

    cleos -u http://localhost:8080 -r "Accept-Encoding: identity" push action -j -d -s writer run '{}' -p localdev@writer >$TEMP_DIR/tx1.json

    cleos -u http://localhost:8080 -r "Accept-Encoding: identity" push action -j -d -s eosio newaccount \
    '{
      "creator" : "localdev",
      "name" : "contracttest",
      "active" : {
          "threshold":2,
          "keys":[ {"weight":1,"key":"EOS7fayG3ADPn5F1U737uQyEpK2ybyK1P6ru9guc9pNFsn9S5vd8b"}],
          "accounts":[ {"weight":1, "permission" :{"actor":"writer", "permission":"access"}}], "waits":[]
      },
      "owner" : {
          "threshold":2,
          "keys":[ {"weight":1,"key":"EOS7fayG3ADPn5F1U737uQyEpK2ybyK1P6ru9guc9pNFsn9S5vd8b"}],
          "accounts":[{"weight":1, "permission" :{"actor":"writer", "permission":"access"}}], "waits":[]
      },
    }' >$TEMP_DIR/tx2.json

    jq -s '[.[].actions[]]' $TEMP_DIR/tx1.json $TEMP_DIR/tx2.json >$TEMP_DIR/tx3.json
    jq '.actions = input' $TEMP_DIR/tx1.json $TEMP_DIR/tx3.json >$TEMP_DIR/tx4.json
    cleos -u http://localhost:8080 -r "Accept-Encoding: identity" push transaction $TEMP_DIR/tx4.json -p localdev@writer
}


create_account