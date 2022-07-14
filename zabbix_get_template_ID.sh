ZabbixWeb=http://zabbix05/
AUTH=`./zabbix_get_token.sh`
REQUEST=$(cat << EOF
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
EOF
)

curl -s -d "$REQUEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq -r '.result[].templateid'
