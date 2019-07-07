stream=/homes/markuze/misc/stream/stream
sockperf=/homes/markuze/sockperf/sockperf

if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=35
[ -z "$MSG_SIZE" ] && MSG_SIZE='64'
[ -z "$core" ] && core=0


[ -z "$loop" ] && loop=0

function ex {
	echo "$@" >> /tmp/log
	$@
}

j=1
i=8
for cnt in `seq 0 $loop`;
do
	ex sudo numactl -m $j -C $i $stream &
	let  i++
	let j^=1
	ex sudo numactl -m $j -C $i $stream &
	let  i++
	let j^=1
done

ex sudo numactl -C $core $sockperf ping-pong --tcp --tcp-avoid-nodelay -i $dip2 -t $TIME -m $MSG_SIZE

wait
