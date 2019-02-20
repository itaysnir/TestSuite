if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

for i in `seq 0  $cpus`;
do
m=$(( $i % 2))
[ $m == 0 ] && netperf -H $dip1 -t TCP_MAERTS -l $TIME -T $i,$i -- -m1M &
[ $m == 0 ] && netperf -H $dip1 -t TCP_MAERTS -l $TIME -T $i,$i -- -m1M &
done

wait
