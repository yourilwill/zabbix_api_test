#!/bin/bash

#####################################################################################
### ホストグループ名をホストグループIDに変換する                                      ###
#####################################################################################
### 使い方
###  ./hostgroup_name_to_ID.sh "ホストグループ名"
###
### 使用例
###  ./hostgroup_name_to_ID.sh "Zabbix servers"
###
#####################################################################################
### 変数定義                                                                       ###
#####################################################################################

####ZabbixWeb画面のURL。環境に合わせて要修正
ZabbixWeb=http://zabbix05/

###ZabbixAPIの認証
auth=`bash zabbix_get_token.sh`

###csv読み取りのための設定。修正不要
PRE_IFS=$IFS
IFS=$'\n'

#####################################################################################

### ホストグループ名をホストグループIDに変換する
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
  "auth": "${auth}",
  "id": 1
}
EOS
)
HOSTGROUP_ID=$(curl -s -d "$REQEST" -H "Content-Type: application/json-rpc" ${ZabbixWeb}api_jsonrpc.php | gawk -F'"' '{print $10}')
echo $HOSTGROUP_NAME: $HOSTGROUP_ID
