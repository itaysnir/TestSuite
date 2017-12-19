if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

i=1
while [ $i -le $cpus ]
do
	netperf -H $dip4 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K &
	netperf -H $dip2 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K &
	ssh $loader1 netperf -H $ip4 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K &
	ssh $loader2 netperf -H $ip2 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K &
	let i=i+2
done

wait
