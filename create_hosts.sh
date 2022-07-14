#!/bin/bash

ZabbixWeb=http://zabbix05/
AUTH=`./zabbix_get_token.sh`

while read LINE
do
  HOST_NAME=`echo $LINE | cut -f 1 -d ","`
  IP_ADDRESS=`echo $LINE | cut -f 2 -d ","`
  cp -f host_template.json ./hosts/${HOSTNAME}.json
  sed -i -e "s/{{ HOSTNAME }}/$HOST_NAME/" ./hosts/${HOST_NAME}.json
  sed -i -e "s/{{ IP_ADDRESS }}/$IP_ADDRESS/" ./hosts/${HOST_NAME}.json
  sed -i -e "s/{{ AUTH }}/$AUTH/" ./hosts/${HOST_NAME}.json
  REQUEST=`<./hosts/${HOST_NAME}.json`
  #echo $REQUEST | jq
  #curl -s -d "$REQUEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq

  echo ""

  HOST_ID=`./zabbix_get_hosts.sh $HOST_NAME`

  UPDATE_REQUEST=$(cat << EOS
  {
    "auth": "$AUTH",
    "method": "host.update",
    "id": 3,
    "params": {
      "hostid": "$HOST_ID",
      "status": 1
    },
    "jsonrpc": "2.0"
  }
EOS
)

  curl -s -d "$UPDATE_REQUEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php

done < host_list

echo ""
