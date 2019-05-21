#!/bin/bash

cd `dirname $0`

[ -z "$loader" ] && loader=dante733

[ -z "$TIME" ] && TIME=60
[ -z "$core" ] && core=0
[ -z "$OUT_FILE" ] && OUT_FILE=.

scp conf.memc $loader1:/tmp/
scp memcahe_suite.sh $loader1:/tmp

### Memcahed Server
#`pwd`/memcahe_suite.sh memcached $ip2 11211
echo "runnig on NODE $core"
numactl  --membind=$core --physcpubind=$core memcached -l $ip2:11211 -m 32768 -d -t 2
#`pwd`/memcahe_suite.sh memcached $ip2 11211
ssh $loader1 TIME=$TIME /tmp/memcahe_suite.sh single $ip2 11211 #|`pwd`/sum_memc.pl
#ssh $loader2 `pwd`/memcahe_suite.sh memslap $ip1 21211|`pwd`/sum_memc.pl

sleep $TIME

`pwd`/memcahe_suite.sh cleanup
ssh $loader1 /tmp/memcahe_suite.sh cleanup
#ssh $loader2 `pwd`/memcahe_suite.sh cleanup

