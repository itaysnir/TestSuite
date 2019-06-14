cfg_file=/tmp/conf.memc
TIME=60s
REMOTE=127.0.0.1
port=11211
MEMSLAP=/home/markuze/libmemcached-1.0.18/clients/memaslap

numactl  -C 0-19 $MEMSLAP -s $REMOTE:$port  -T 20 -o 0.5 -d 16 --concurrency=320 -t $TIME -F $cfg_file -S 6s
