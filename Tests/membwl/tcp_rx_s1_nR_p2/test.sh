if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

function run {
## TX 0 : 7 = 4 + 4 (0-6/7-13: 0-3)
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 1,0 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 3,1 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 5,2 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 7,3 -P 0 -- -m1M > /dev/null &

## RX 0 : 7 = 4 +4 (0-6/7-13: 4-7)
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 11,4 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 13,5 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 15,6 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 17,7 -P 0 -- -m1M > /dev/null &

## TX 1 : 7 = 4 + 4 (14-20/21-27: 8-11)
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 19,8 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 21,9 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 23,10 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 25,11 -P 0 -- -m1M > /dev/null &

## RX 1 : 7 = 4 +4 (14-20/21-27: 12-15)

	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 27,12 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 1,13 -P 0 -- -m1M > /dev/null &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 3,14 -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T 5,15 -P 0 -- -m1M > /dev/null &
}

run
wait
