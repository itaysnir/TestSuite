if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 14,10 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 15,11 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 16,12 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 17,13 -P 0 -- -m1M > /dev/null &
	netperf -H $dip4 -t TCP_STREAM -l $TIME -T 18,10 -P 0 -- -m1M > /dev/null &
	netperf -H $dip4 -t TCP_STREAM -l $TIME -T 19,11 -P 0 -- -m1M > /dev/null &
	netperf -H $dip4 -t TCP_STREAM -l $TIME -T 20,12 -P 0 -- -m1M > /dev/null &
	netperf -H $dip4 -t TCP_STREAM -l $TIME -T 21,13 -P 0 -- -m1M > /dev/null &

sleep $TIME
sleep 3
