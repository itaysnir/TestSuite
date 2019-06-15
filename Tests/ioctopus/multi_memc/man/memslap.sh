cfg_file=/tmp/conf.memc
#TIME=300s
TIME=120s
REMOTE=127.0.0.1
port=11211
MEMSLAP=/home/markuze/libmemcached-1.0.18/clients/memaslap

$MEMSLAP -s 2.2.2.2:11211  -T `nproc` -o 0.5 -d 32 --concurrency=28 -t $TIME -S 60s -F $cfg_file --win_size=1k & #
$MEMSLAP -s 2.2.2.3:11212  -T `nproc` -o 0.5 -d 32 --concurrency=28 -t $TIME -S 60s -F $cfg_file --win_size=1k & #
wait
