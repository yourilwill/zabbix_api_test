#!/bin/bash

ZabbixWeb=http://zabbix05/
AUTH=`./zabbix_get_token.sh`
REQEST=$(cat << EOS
  {
    "jsonrpc": "2.0",
    "method": "host.get",
    "params": {
      "filter": {
        "host": [
         "$1"
        ]
      }
    },
    "auth": "$AUTH",
    "id": 1
  }
EOS
)

curl -s -d "$REQEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq -r '.result[].hostid'
