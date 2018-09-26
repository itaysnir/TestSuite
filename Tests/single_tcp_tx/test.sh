if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=15

#netperf -H $dip4 -t TCP_STREAM -T 1,2 -l $TIME -- -m1M &
#netperf -H $dip2 -t TCP_STREAM -T 1,3 -l $TIME -- -m1M &
#netperf -H $dip2 -t TCP_STREAM -T 1,4 -l $TIME -- -m1M &
#netperf -H $dip4 -t TCP_STREAM -T 1,5 -l $TIME -- -m1M &
#wait
#netperf -H $dip4 -t TCP_STREAM -T 1,2 -l $TIME -- -m1M &
#netperf -H $dip2 -t TCP_STREAM -T 1,3 -l $TIME -- -m1M &

netperf -H $dip1 -t TCP_STREAM -T 1,1 -l $TIME  -- -m1M -s16M &
netperf -H $dip1 -t TCP_STREAM -T 1,2 -l $TIME  -- -m1M -s16M &
netperf -H $dip1 -t TCP_STREAM -T 1,3 -l $TIME  -- -m1M -s16M &
netperf -H $dip1 -t TCP_STREAM -T 1,4 -l $TIME  -- -m1M -s16M &
netperf -H $dip1 -t TCP_STREAM -T 1,5 -l $TIME  -- -m1M -s16M &
wait
