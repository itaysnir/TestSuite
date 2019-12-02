#!/bin/bash

function ex_src {

ssh -i $key $src $@

}

[ -z "$src" ] && exit -1
[ -z "$TIME" ] && TIME=10

ex_src iperf3 -c $sink -t $TIME |grep receiver|grep -Po "\d+\.\d+\s+Gbits"
