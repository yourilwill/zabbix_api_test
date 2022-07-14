#!/bin/bash

ZabbixWeb=http://zabbix05/
AUTH=`./zabbix_get_token.sh`
REQUEST=$(cat << EOS
{
  "jsonrpc": "2.0",
  "method": "template.get",
  "params": {
    "output": "extend",
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

curl -s -d "$REQUEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq -r '.result[].templateid'
