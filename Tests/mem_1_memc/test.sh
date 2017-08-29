#!/bin/bash

cd `dirname $0`
[ -z "$ip1" ] && ip1=10.0.100.30


[ -z "$loader" ] && loader=tapuz31

[ -z "$OUT_FILE" ] && OUT_FILE=.


### Memcahed Server
`pwd`/memcahe_suite.sh memcached $ip1
ssh $loader `pwd`/memcahe_suite.sh memslap $ip1|`pwd`/sum_memc.pl

wait
`pwd`/memcahe_suite.sh cleanup
ssh $loader `pwd`/memcahe_suite.sh cleanup

