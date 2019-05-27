if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=60
[ -z "$MSG_SIZE" ] && MSG_SIZE='64K'
[ -z "$core" ] && core=0
[ -z "$rcore" ] && rcore=3


netperf -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
#let rcore++
#netperf -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
#let rcore++
#netperf -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
#let rcore++
#let rcore++
#netperf -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
#let rcore++
#netperf -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
wait
