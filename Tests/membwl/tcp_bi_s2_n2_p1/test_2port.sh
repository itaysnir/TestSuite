if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

## TX 0 : 7 = 4 + 4 (0-6/7-13: 0-3)
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 0,0 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 1,1 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 2,2 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 3,3 -P 0 -- -m1M > /dev/null &

	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 7,0 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 8,1 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 9,2 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 10,3 -P 0 -- -m1M > /dev/null &

## RX 0 : 7 = 4 +4 (0-6/7-13: 4-7)
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 4,4 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 5,5 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 6,6 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 0,7 -P 0 -- -m1M > /dev/null &

	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 11,4 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 12,5 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 13,6 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 8,7 -P 0 -- -m1M > /dev/null &

## TX 1 : 7 = 4 + 4 (14-20/21-27: 8-11)
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 14,8 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 15,9 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 16,10 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 17,11 -P 0 -- -m1M > /dev/null &

	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 21,8 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 22,9 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 23,10 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 24,11 -P 0 -- -m1M > /dev/null &

## RX 1 : 7 = 4 +4 (14-20/21-27: 12-15)

	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 18,12 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 19,13 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 20,14 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 19,15 -P 0 -- -m1M > /dev/null &

	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 25,12 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 26,13 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 27,14 -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 21,15 -P 0 -- -m1M > /dev/null &

sleep $TIME
sleep 3
