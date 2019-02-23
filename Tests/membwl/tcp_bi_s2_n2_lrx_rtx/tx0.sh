if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 0,0 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 1,1 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 2,2 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 3,3 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_STREAM -l $TIME -T 4,0 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_STREAM -l $TIME -T 5,1 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_STREAM -l $TIME -T 6,2 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_STREAM -l $TIME -T 7,3 -P 0 -- -m1M > /dev/null &

sleep $TIME
sleep 3
