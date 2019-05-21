if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=60
[ -z "$MSG_SIZE" ] && MSG_SIZE='64K'
[ -z "$core" ] && core=0
[ -z "$rcore" ] && rcore=3


for i in `seq 0 3`;
do
	if [ -z "$TX" ]; then
		netperf -L $ip2 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
		let rcore++
		let core++
		netperf -L $ip3 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
		let rcore++
		let core++
	else
		echo "NO TX"
	fi

	if [ -z "$RX" ]; then
		netperf -L $ip2 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -M $MSG_SIZE,$MSG_SIZE &
		let rcore++
		let core++
		netperf -L $ip3 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -M $MSG_SIZE,$MSG_SIZE &
		let rcore++
		let core++
	else
		echo "NO RX"
	fi
done

wait
