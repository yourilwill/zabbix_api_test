# $1: auth string got by zabbix_get_token.sh

REQUEST=$(cat <<EOS
{
    "jsonrpc": "2.0",
    "method": "user.logout",
    "params": [],
    "id": 1,
    "auth": "$1"
}
EOS
)

curl -s -d "$REQUEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | jq
