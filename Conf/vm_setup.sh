#!/bin/bash

cnt=`lsmod|grep -c cbn`

[ $cnt -eq "1" ] && exit -2

cd ~/ENV
./setup_link.sh
./setup_ktcp.sh
