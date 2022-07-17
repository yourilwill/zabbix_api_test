#!/bin/bash

ZabbixWeb=http://zabbix05/
AUTH=`./zabbix_get_token.sh`
TEMPLATE_FILE=host_template.json

ask_execution(){
  while true; do
    read -p "Do you continue host deletion? (Y/n) " answer

    case "$answer" in
      [Yy]* ) return 0;;
      [Nn]* ) exit 1;;
      * ) echo "Please answer yes or no.";;
    esac
  done
}

while read LINE <&3; do

  HOST_NAME=`echo $LINE | cut -f 1 -d ","`
  IP_ADDRESS=`echo $LINE | cut -f 2 -d ","`
  echo "Next Host: $HOST_NAME, $IP_ADDRESS"

  if ask_execution; then

    HOST_ID=`./zabbix_get_hosts.sh $HOST_NAME`
    REQUEST=$(cat << EOS
    {
      "auth": "$AUTH",
      "method": "host.delete",
      "id": 3,
      "params": [
        "$HOST_ID"
      ],
      "jsonrpc": "2.0"
    }
EOS
    )

    echo $REQUEST | jq
    curl -s -d "$REQUEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq

    echo ""

  else

    exit 0

  fi

  echo ""
  echo "--------------------------------------------------"
  echo ""

done 3< host_list

./zabbix_logout.sh $AUTH
