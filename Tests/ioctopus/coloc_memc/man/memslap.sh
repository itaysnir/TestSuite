cfg_file=/tmp/conf.memc
[ -z "$TIME" ] && TIME=600
TIME="${TIME}s"

port=11211
MEMSLAP=/home/markuze/libmemcached-1.0.18/clients/memaslap
S='-S 60s'

$MEMSLAP -s 2.2.2.2:11211  -T `nproc` -o 0.5 -d 32 --concurrency=28 -t $TIME -F $cfg_file --win_size=1k & #
$MEMSLAP -s 2.2.2.3:11212  -T `nproc` -o 0.5 -d 32 --concurrency=28 -t $TIME -F $cfg_file --win_size=1k & #
wait
