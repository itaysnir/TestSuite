[ -z "$TIME" ] && TIME=20
[ -z "$RNODE" ] && RNODE=1

TIME="${TIME}s"

cfg=/tmp/memc.cfg
MEMSLAP=/home/markuze/libmemcached-1.0.18/clients/memaslap

[ -z "$port" ] && port=11211

if [ "$RNODE" -eq 1 ]; then
	ssh $loader1 numactl -m 1 -N 1 $MEMSLAP -s $ip2:$port  -T 14 -o 0.5 $D --concurrency=14 -t $TIME -F $cfg --win_size=1k
else
	ssh $loader1 numactl -m 0 -N 0 $MEMSLAP -s $ip3:11212  -T 14 -o 0.5 $D --concurrency=14 -t $TIME -F $cfg --win_size=1k
fi
