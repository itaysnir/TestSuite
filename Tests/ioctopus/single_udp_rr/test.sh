if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=60
[ -z "$MSG_SIZE" ] && MSG_SIZE='63K'
[ -z "$core" ] && core=2
[ -z "$rcore" ] && rcore=1

netperf=/homes/markuze/misc/netperf/src/netperf

netperf -H $dip2 -t UDP_RR -T $core,$rcore -l $TIME -- -r $MSG_SIZE #-o TRANSACTION_RATE
#ssh $loader1 netperf -H $ip2 -t TCP_STREAM -T $rcore,$core -l $TIME -- -m $MSG_SIZE
