if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=60
[ -z "$MSG_SIZE" ] && MSG_SIZE='64K'
[ -z "$core" ] && core=2
[ -z "$rcore" ] && rcore=0

netperf=/homes/markuze/misc/netperf/src/netperf

#ssh $loader1 netperf -H $ip2 -t TCP_STREAM -T $rcore,$core -l $TIME -- -m $MSG_SIZE
#netperf -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -m $MSG_SIZE,$MSG_SIZE -M $MSG_SIZE,$MSG_SIZE
$netperf -L $ip2 -H $dip2 -t TCP_MAERTS -T $core,0 -l $TIME -- -M 64K &
$netperf -L $ip2 -H $dip2 -t TCP_MAERTS -T $core,1 -l $TIME -- -M 64K &
wait
#$netperf -H $ip3 $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -M 64K
