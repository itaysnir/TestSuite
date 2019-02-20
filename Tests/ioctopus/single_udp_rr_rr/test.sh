if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

netperf -H $dip1 -t UDP_RR -T 3,3 -l $TIME &
wait
