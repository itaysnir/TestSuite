if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

for i in `seq 0  $cpus`;
do
m=$(( $i % 4))
[ $m == 0 ] && netperf -H $dip1 -t TCP_STREAM -l $TIME -T $i,$i -- -m1M &
[ $m == 1 ] && netperf -H $dip2 -t TCP_STREAM -l $TIME -T $i,$i -- -m1M &
[ $m == 3 ] && netperf -H $dip3 -t TCP_STREAM -l $TIME -T $i,$i -- -m1M &
[ $m == 3 ] && netperf -H $dip4 -t TCP_STREAM -l $TIME -T $i,$i -- -m1M &

done
#cpus=15

#for i in `seq 0  $cpus`;
#do
#	let j=i*2
#	netperf -H $dip1 -t TCP_STREAM -l $TIME -T $j,$i -- -m1M &
#done
#
#for i in `seq 0  $cpus`;
#do
#	let j=i*2
#	let j=j+1
#	netperf -H $dip2 -t TCP_STREAM -l $TIME -T $j,$i -- -m1M &
#done

wait
