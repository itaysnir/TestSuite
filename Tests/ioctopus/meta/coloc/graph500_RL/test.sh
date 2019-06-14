if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=1200
[ -z "$MSG_SIZE" ] && MSG_SIZE='64K'
[ -z "$core" ] && core=20
[ -z "$rcore" ] && rcore=3

for i in `seq 0 1`;
do
echo "netperf -L $ip2 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &"
netperf -L $ip2 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
#let rcore++
#netperf -L $ip2 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
let rcore++
let core++
echo "netperf -L $ip3 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &"
netperf -L $ip3 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
#let rcore++
#netperf -L $ip3 -H $dip2 -t TCP_STREAM -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
let rcore++
let core++
done

for i in `seq 0 1`;
do
echo "netperf -L $ip2 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -m $MSG_SIZE &"
netperf -L $ip2 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
#let rcore++
#netperf -L $ip2 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
let rcore++
let core++
echo "netperf -L $ip3 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -m $MSG_SIZE &"
netperf -L $ip3 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
#let rcore++
#netperf -L $ip3 -H $dip2 -t TCP_MAERTS -T $core,$rcore -l $TIME -- -m $MSG_SIZE &
let rcore++
let core++
done

wait
