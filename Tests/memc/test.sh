#!/bin/bash

cd `dirname $0`
[ -z "$ip1" ] && ip1=10.0.100.30


[ -z "$loader" ] && loader=tapuz31

[ -z "$TIME" ] && TIME=180
[ -z "$OUT_FILE" ] && OUT_FILE=.

scp conf.memc $loader1:/tmp/
scp memcahe_suite.sh $loader1:/tmp
### Memcahed Server
`pwd`/memcahe_suite.sh memcached $ip2 11211
#`pwd`/memcahe_suite.sh memcached $ip2 11211
ssh $loader1 /tmp/memcahe_suite.sh memslap $ip2 11211|`pwd`/sum_memc.pl
#ssh $loader2 `pwd`/memcahe_suite.sh memslap $ip1 21211|`pwd`/sum_memc.pl

sleep $TIME
sleep 10

`pwd`/memcahe_suite.sh cleanup
ssh $loader1 /tmp/memcahe_suite.sh cleanup
#ssh $loader2 `pwd`/memcahe_suite.sh cleanup

