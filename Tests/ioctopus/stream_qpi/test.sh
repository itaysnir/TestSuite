stream=/homes/markuze/misc/stream/stream
if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=35
[ -z "$MSG_SIZE" ] && MSG_SIZE='64K'
[ -z "$core" ] && core=2
[ -z "$rcore" ] && rcore=5


[ -z "$loop" ] && loop=0

function ex {
	echo "$@" >> /tmp/log
	$@
}

j=1
i=8
if [ $loop -ge 0 ]; then

	for cnt in `seq 0 $loop`;
	do
		ex sudo numactl -m $j -C $i $stream &
		let  i++
		let j^=1
		ex sudo numactl -m $j -C $i $stream &
		let  i++
		let j^=1
	done
fi

netperf -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -M $MSG_SIZE,$MSG_SIZE &
wait
