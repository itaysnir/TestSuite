if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

netperf -H $dip1 -t UDP_RR -T 2,0 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,1 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,2 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,3 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,4 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,5 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,6 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,7 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,8 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,9 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,10 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,11 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,12 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,13 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,14 -l $TIME &
netperf -H $dip1 -t UDP_RR -T 2,15 -l $TIME &
wait
