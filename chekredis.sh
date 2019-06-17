#!/bin/bash
# auth:peter
# date:2018-08-02
# 先定时任务把所有的redis info追加到一个文件，然后再从文件取相应的值

file=/etc/zabbix/scripts/cronredisinfo.txt

# 这个函数是需要放到定时任务里面跑的
function cronredisinfo() {
    /data/chainup/redis/bin/redis-cli  -h 172.31.39.121  -p 6382 -a bituan1VmVnW info > $file

}

function getredisinfo() {
    case $1 in 
        connected_clients)
            grep -wi $1 $file |awk -F":" '{print $2}'
            ;;
        used_memory)
            grep -wi $1 $file |awk -F":" '{print $2}'
            ;;
        total_commands_processed)
            grep -wi $1 $file|awk -F":" '{print $2}'
            ;;
        used_memory_rss)
            grep -wi $1 $file|awk -F":" '{print $2}'
            ;;
        total_net_input_bytes)
            grep -wi $1 $file|awk -F":" '{print $2}'
            ;;
        total_net_output_bytes)
            grep -wi $1 $file|awk -F":" '{print $2}'
            ;;
        redis_get_key)
            awk -F"[,|=]" 'END{print $2}' $file
            ;;
            *)
                echo "this argument is error!"
    esac 
}

if [ $# -eq 0 ];then
    cronredisinfo
else
    getredisinfo $1
fi 
