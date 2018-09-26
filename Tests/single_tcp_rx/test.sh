if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

#netperf -H $dip4 -t TCP_MAERTS -T 1,2 -l $TIME &
#wait
#netperf -H $dip4 -t TCP_MAERTS -T 1,2 -l $TIME &
#netperf -H $dip2 -t TCP_MAERTS -T 1,1 -l $TIME &
#wait
netperf -H $dip4 -t TCP_MAERTS -T 1,2 -l $TIME &
netperf -H $dip4 -t TCP_MAERTS -T 1,3 -l $TIME &
netperf -H $dip4 -t TCP_MAERTS -T 1,0 -l $TIME &
netperf -H $dip4 -t TCP_MAERTS -T 1,1 -l $TIME &
wait
