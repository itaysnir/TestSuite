if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=60
[ -z "$MSG_SIZE" ] && MSG_SIZE='64K'
[ -z "$core" ] && core=0
[ -z "$rcore" ] && rcore=0

netperf=/homes/markuze/misc/netperf/src/netperf

for i in `seq 0 12`;
do
	if [ -z "$L" ]; then
		netperf -L $ip2 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -m 64K,64K -M $MSG_SIZE,$MSG_SIZE &
	fi
	let rcore++
	let core++

	if [ -z "$R" ]; then
		netperf -L $ip3 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -m 64K,64K -M $MSG_SIZE,$MSG_SIZE &
	fi
	let rcore++
	let core++
done

echo "$core"
wait
