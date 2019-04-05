if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=60
[ -z "$MSG_SIZE" ] && MSG_SIZE='64K'
[ -z "$core" ] && core=0

netperf=/homes/markuze/misc/netperf/src/netperf

$netperf -H $dip1 -t TCP_MAERTS -T $core,2 -l $TIME -- -M $MSG_SIZE &
$netperf -H $dip1 -t TCP_MAERTS -T $core,3 -l $TIME -- -M $MSG_SIZE &
#$netperf -H $dip1 -t TCP_MAERTS -T $core,0 -l $TIME -- -M $MSG_SIZE &
#$netperf -H $dip1 -t TCP_MAERTS -T $core,4 -l $TIME -- -M $MSG_SIZE &
wait
