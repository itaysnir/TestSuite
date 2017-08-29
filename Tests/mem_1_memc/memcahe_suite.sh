#! /bin/bash

TEST=$1
MEMSLAP=/home/markuze/libmemcached-1.0.18/clients/memaslap
IP=$2
RCPU=16
TIME=40s

CPU_LINE=` lscpu|grep -P '^CPU\(s\):'|cut -d: -f2`
cfg_file="`dirname $0`/conf.memc"

function set_memcached {

	LOCAL=$1
        mport=11211

		taskset -c 0 memcached -l $LOCAL:$mport -m 1024 -d -t 1 -I 1M
		let mport++
		taskset -c 2 memcached -l $LOCAL:$mport -m 1024 -d -t 1 -I 1M
		let mport++
		taskset -c 4 memcached -l $LOCAL:$mport -m 1024 -d -t 1 -I 1M
		let mport++
		taskset -c 6 memcached -l $LOCAL:$mport -m 1024 -d -t 1 -I 1M
		let mport++
		taskset -c 8 memcached -l $LOCAL:$mport -m 1024 -d -t 1 -I 1M
		let mport++
		taskset -c 10 memcached -l $LOCAL:$mport -m 1024 -d -t 1 -I 1M
		let mport++
		taskset -c 12 memcached -l $LOCAL:$mport -m 1024 -d -t 1 -I 1M
		let mport++
		taskset -c 14 memcached -l $LOCAL:$mport -m 1024 -d -t 1 -I 1M
		let mport++
}

function lunch_memcslap {

	REMOTE=$1
	cpu=$CPU_LINE

	if [ -z "$TIME" ]; then
		TIME=40s
	fi

        port=11211

	taskset -c 0 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	taskset -c 1 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	let port++
	taskset -c 2 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	taskset -c 3 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	let port++
	taskset -c 4 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	taskset -c 5 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	let port++
	taskset -c 6 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	taskset -c 7 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	let port++
	taskset -c 8 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	taskset -c 9 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	let port++
	taskset -c 10 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	taskset -c 11 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	let port++
	taskset -c 12 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	taskset -c 13 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	let port++
	taskset -c 14 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
	taskset -c 15 $MEMSLAP -s $REMOTE:$port  -T 1 -o 0.5 -d 4 --concurrency=128 -t $TIME -F $cfg_file &
}

function cleanup {
	echo "sudo pkill -9 memcached"
	sudo pkill -9 memcached
}

case "$TEST" in

"memcached")
	echo "seting up memcached"
	if [ -z "$IP" ]; then
		echo "usage $0 $TEST <IP>"
	fi
	set_memcached $IP
    ;;
"memslap")
	echo  "staring memslap"
	if [ -z "$IP" ]; then
		echo "usage $0 $TEST <IP>"
	fi
	lunch_memcslap $IP
    ;;
"cleanup")
	echo "Cleanup"
	cleanup
	;;
*) 	echo "ERROR : Unsuported switch $1"
   ;;
esac


