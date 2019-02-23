if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 20,13 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 22,14 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 24,15 -P 0 -- -m1M > /dev/null &
	netperf -H $dip4 -t TCP_MAERTS -l $TIME -T 26,13 -P 0 -- -m1M > /dev/null &
	netperf -H $dip4 -t TCP_MAERTS -l $TIME -T 27,14 -P 0 -- -m1M > /dev/null &
	netperf -H $dip4 -t TCP_MAERTS -l $TIME -T 25,15 -P 0 -- -m1M > /dev/null &

sleep $TIME
sleep 3
