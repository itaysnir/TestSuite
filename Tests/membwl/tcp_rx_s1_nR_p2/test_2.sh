if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

for i in `seq 0  9`;
do
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T $i,$i -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T $i,$i -P 0 -- -m1M > /dev/null &
done

for i in `seq 10  18`;
do
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T $i,$i -P 0 -- -m1M > /dev/null &
	netperf -H $dip3 -t TCP_STREAM -l $TIME -T $i,$i -P 0 -- -m1M > /dev/null &
done

for i in `seq 19  24`;
do

	netperf -H $dip4 -t TCP_MAERTS -l $TIME -T $i,$i -P 0 -- -m1M > /dev/null &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T $i,$i -P 0 -- -m1M > /dev/null &
done

for i in `seq 25  $cpus`;
do
	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T $i,$i -P 0 -- -m1M > /dev/null &
	netperf -H $dip4 -t TCP_MAERTS -l $TIME -T $i,$i -P 0 -- -m1M > /dev/null &
done

sleep $TIME
sleep 3
