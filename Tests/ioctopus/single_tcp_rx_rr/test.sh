if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=15

netperf -H $dip1 -t TCP_MAERTS -T 1,1 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 1,3 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 1,5 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 1,7 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 1,9 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_MAERTS -T 1,11 -l $TIME  -- -m1M  &

wait
