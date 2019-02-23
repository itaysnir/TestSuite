if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 0,3 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 2,4 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 4,5 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 6,3 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 8,4 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 10,5 -P 0 -- -m1M > /dev/null &

sleep $TIME
sleep 3
