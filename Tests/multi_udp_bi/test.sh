if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=60

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


for i in `seq 1 2 $cpus`
do
	ssh $loader1 netperf -H $ip4 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K > /dev/null &
	ssh $loader2 netperf -H $ip2 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K > /dev/null &
	netperf -H $dip2 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K > /dev/null &
	netperf -H $dip4 -t UDP_STREAM -l $TIME -T $i,$i -P 0 -- -m63K > /dev/null &
done
sleep 5
sudo sh -c "echo 1 > /sys/kernel/debug/alloc_trace/active"
sudo sh -c "cat /sys/kernel/debug/alloc_trace/active"

sleep $TIME
sleep 10
