if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=20

cpus=`nproc`
let cpus=cpus-1

#for i in `seq 0  $cpus`;
#do
#	netperf -H $dip1 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K &
#	netperf -H $dip2 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K &
#
#	ssh $loader1	netperf -H $ip1 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K &
#	ssh $loader2 	netperf -H $ip2 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K &
#done

echo "netperf -H $dip2 -t TCP_STREAM -l $TIME -T 1,0 -P 0 -- -m1M &"
netperf -H $dip2 -t TCP_STREAM -l $TIME -T 1,0 -P 0 -- -m1M &
netperf -H $dip2 -t TCP_STREAM -l $TIME -T 2,2 -P 0 -- -m1M &
netperf -H $dip2 -t TCP_STREAM -l $TIME -T 3,4 -P 0 -- -m1M &
netperf -H $dip2 -t TCP_STREAM -l $TIME -T 4,5 -P 0 -- -m1M &

sleep $TIME
sleep 3
