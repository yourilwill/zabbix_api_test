#!/bin/bash

ZabbixWeb=http://192.168.33.50/

TOKEN=$(curl -s -d '{
  "jsonrpc": "2.0",
  "method": "user.login",
  "params": {
      "user": "Admin",
      "password": "zabbix"
  },
  "id": 1,
  "auth": null
}' -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | gawk -F'"' '{print $8}')

echo ${TOKEN}
