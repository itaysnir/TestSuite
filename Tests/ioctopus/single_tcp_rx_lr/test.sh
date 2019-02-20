if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=15

netperf -H $dip1 -t TCP_MAERTS -T 0,1 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 0,3 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 0,5 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 0,7 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 0,9 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 0,11 -l $TIME  -- -m1M  &

wait
