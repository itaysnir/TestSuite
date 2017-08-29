if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

i=0
while [ $i -lt $cpus ]
do
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T $i,$i -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T $i,$i -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T $i,$i -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T $i,$i -P 0 -- -m1M &
	let i=i+2
done

sleep $TIME
sleep 3
