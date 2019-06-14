if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=60
[ -z "$MSG_SIZE" ] && MSG_SIZE='64K'
[ -z "$core" ] && core=0
[ -z "$rcore" ] && rcore=1

for i in `seq 0 12`;
do
	if [ -z "$L" ]; then
		netperf -L $ip2 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
	fi

	let rcore++
	let core++

	if [ -z "$R" ]; then
		netperf -L $ip3 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
	fi

	let rcore++
	let core++
done

wait
