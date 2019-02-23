if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

function run {
## TX 0 : 7 = 4 + 4 (0-6/7-13: 0-3)
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 0,0 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 3,1 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 4,2 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 7,3 -P 0 -- -m1M > /dev/null &

## RX 0 : 7 = 4 +4 (0-6/7-13: 4-7)
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 10,4 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 13,5 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 16,6 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 17,7 -P 0 -- -m1M > /dev/null &

## TX 1 : 7 = 4 + 4 (14-20/21-27: 8-11)
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 18,8 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 21,9 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 20,10 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 25,11 -P 0 -- -m1M > /dev/null &

## RX 1 : 7 = 4 +4 (14-20/21-27: 12-15)

	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 27,12 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 22,13 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 23,14 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 21,15 -P 0 -- -m1M > /dev/null &
}

run
wait
