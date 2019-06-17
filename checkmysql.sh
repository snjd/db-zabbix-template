#!/bin/bash

## 执行这个之前先执行其他的语句获取状态文件，避免每取一个值都读取一遍
## mysqladmin -h 172.31.39.105 -P 4461 -u exchange_r -pbituanVUB7FM extended-status > /etc/zabbix/scripts/extended-status.txt
##

ARGS=2
if [ $# -ne "$ARGS" ];then
    echo "Please input one arguement:"
fi

filename=/etc/zabbix/scripts/$1

[ ! -f $filename ] && echo "Please input one regular file" && exit 10 

case $2 in
    Uptime)
        result=`cat $filename |cut -f2 -d":"|cut -f1 -d"T"`
                echo $result
                ;;
    Com_update)
        result=`cat $filename |grep -w "Com_update"|cut -d"|" -f3`
                echo $result
                ;;
    Slow_queries)
        result=`cat $filename  |cut -f5 -d":"|cut -f1 -d"O"`
                echo $result
                ;;
    Com_select)
        result=`cat $filename |grep -w "Com_select"|cut -d"|" -f3`
                echo $result
                ;;
    Com_rollback)
        result=`cat $filename |grep -w "Com_rollback"|cut -d"|" -f3`
                echo $result
                ;;
    Questions)
        result=`cat $filename |cut -f4 -d":"|cut -f1 -d"S"`
                echo $result
                ;;
    Com_insert)
        result=`cat $filename |grep -w "Com_insert"|cut -d"|" -f3`
                echo $result
                ;;
    Com_delete)
        result=`cat $filename |grep -w "Com_delete"|cut -d"|" -f3`
                echo $result
                ;;
    Com_commit)
        result=`cat $filename |grep -w "Com_commit"|cut -d"|" -f3`
                echo $result
                ;;
    Bytes_sent)
        result=`cat $filename |grep -w "Bytes_sent" |cut -d"|" -f3`
                echo $result
                ;;
    Bytes_received)
        result=`cat $filename |grep -w "Bytes_received" |cut -d"|" -f3`
                echo $result
                ;;
    Com_begin)
        result=`cat $filename |grep -w "Com_begin"|cut -d"|" -f3`
                echo $result
                ;;                        
    rows_deleted)
        result=`cat $filename |grep  "$2"|cut -d"|" -f3`
                echo $result
                ;;                        
    rows_inserted)
        result=`cat $filename |grep  "$2"|cut -d"|" -f3`
                echo $result
                ;;                        
    rows_updated)
        result=`cat $filename |grep "$2"|cut -d"|" -f3`
                echo $result
                ;;                        
    rows_read)
        result=`cat $filename |grep "$2"|cut -d"|" -f3`
                echo $result
                ;;                        
    Threads_connected|thread_conn)
        result=`cat $filename |grep "Threads_connected"|cut -d"|" -f3`
                echo $result
                ;;                        
    Max_used_connections|max_conn)
        result=`cat $filename |grep -w "Max_used_connections"|cut -d"|" -f3`
                echo $result
                ;;                        
    Connections)
        result=`cat $filename |grep "$2"|cut -d"|" -f3`
                echo $result
                ;;                        
    Threads_running|thread_run)
        result=`cat $filename |grep "Threads_running"|cut -d"|" -f3`
                echo $result
                ;;                        
        *)
        echo "Usage:$0(Uptime|Com_update|Slow_queries|Com_select|Com_rollback|Questions)"
        ;;
esac
