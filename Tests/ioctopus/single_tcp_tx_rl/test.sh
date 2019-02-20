if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=15

netperf -H $dip1 -t TCP_STREAM -T 1,0 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_STREAM -T 1,2 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_STREAM -T 1,4 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_STREAM -T 1,6 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_STREAM -T 1,8 -l $TIME  -- -m1M  &
netperf -H $dip1 -t TCP_STREAM -T 1,10 -l $TIME  -- -m1M  &

wait
