#!/bin/bash

ZabbixWeb=http://zabbix05/
AUTH=`zabbix_get_token.sh`

PRE_IFS=$IFS
IFS=$'\n'

HOSTGROUP_NAME=$1
REQEST=$(cat << EOS
{
  "jsonrpc": "2.0",
  "method": "hostgroup.get",
  "params": {
    "output": "extend",
    "filter": {
      "name": [
        "${HOSTGROUP_NAME}"
      ]
    }
  },
  "auth": "$AUTH",
  "id": 1
}
EOS
)

HOSTGROUP_ID=$(curl -s -d "$REQEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | gawk -F'"' '{print $10}')
echo $HOSTGROUP_NAME: $HOSTGROUP_ID
