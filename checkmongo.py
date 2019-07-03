#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@File    :   mongodb.py
@Time    :   2019/06/14 16:31:52
@Author  :   Peter
@Version :   1.0
@Contact :   sky_pipi@163.com
@License :   (C)Copyright 2017-2018, Liugroup-NLPR-CASIA
@Desc    :   None
'''

import json
import sys
import socket
from pymongo import MongoClient


listparasm = [
["connections","available"],
["connections","current"],
["connections","totalCreated"],
["globalLock","activeClients","readers"],
["globalLock","activeClients","total"],
["globalLock","activeClients","writers"],
["globalLock","currentQueue","readers"],
["globalLock","currentQueue","total"],
["globalLock","currentQueue","writers"],
["mem","mappedWithJournal"],
["mem","mapped"],
["mem","resident"],
["mem","virtual"],
["metrics","document","deleted"],
["metrics","document","inserted"],
["metrics","document","returned"],
["metrics","document","updated"],
["network","bytesIn"],
["network","bytesOut"],
["network","numRequests"],
["opcounters","command"],
["opcounters","delete"],
["opcounters","getmore"],
["opcounters","insert"],
["opcounters","query"],
["opcounters","update"],
["opcountersRepl","command"],
["opcountersRepl","delete"],
["opcountersRepl","getmore"],
["opcountersRepl","insert"],
["opcountersRepl","query"],
["opcountersRepl","update"]
]


baseitem = "mongodb.status"
hostname = socket.gethostbyname(socket.getfqdn(socket.gethostname()))
file="mongostatus.txt"

# 清空文件先，避免中途取值有问题，定时任务发送上次的数据
f = open(file,'w')

try:
    mo = MongoClient('47.112.113.7', 27017, connectTimeoutMS=5000)
except Exception as e:
    print ('Can\'t connect to '+ '127.0.0.1')
    print ("ERROR:", e)
    sys.exit(1)
res = mo.admin.command('serverStatus')

for item in listparasm:
    if len(item) == 2:
        value = res[item[0]][item[1]]
    elif len(item) == 3:
        value = res[item[0]][item[1]][item[2]]
    else:
        continue
    param = ",".join(item)
    line = hostname + "  "+baseitem+"["+param+"]"+" " + str(value)
    f.write(line+"\n")

f.close()
