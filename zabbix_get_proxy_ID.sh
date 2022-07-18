#!/bin/bash

ZabbixWeb=http://zabbix05/
AUTH=`./zabbix_get_token.sh`
REQUEST=$(cat <<EOS
{
    "jsonrpc": "2.0",
    "method": "proxy.get",
    "params": {
        "output": "extend",
        "selectInterface": "extend"
    },
    "auth": "$AUTH",
    "id": 1
}
EOS
)

curl -s -d "$REQUEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq

echo "--------------------------------------------------"
./zabbix_logout.sh $AUTH
