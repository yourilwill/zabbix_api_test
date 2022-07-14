#!/bin/bash

ZabbixWeb=http://192.168.33.50/
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
    "auth": "f6f161169cd80f40a83203e60829f7f5",
    "id": 1
  }
EOS
)

curl -s -d "$REQEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq -r '.result[].hostid'
