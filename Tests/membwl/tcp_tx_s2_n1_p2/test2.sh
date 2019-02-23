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

netperf -H $dip1 -t UDP_STREAM -l $TIME -T 0,0 -P 0 -- -m63K &
netperf -H $dip2 -t UDP_STREAM -l $TIME -T 1,1 -P 0 -- -m63K &
netperf -H $dip1 -t UDP_STREAM -l $TIME -T 2,2 -P 0 -- -m63K &
netperf -H $dip2 -t UDP_STREAM -l $TIME -T 3,3 -P 0 -- -m63K &
netperf -H $dip1 -t UDP_STREAM -l $TIME -T 4,4 -P 0 -- -m63K &
netperf -H $dip2 -t UDP_STREAM -l $TIME -T 5,5 -P 0 -- -m63K &

#wait
ssh $loader1 netperf -H $ip1 -t UDP_STREAM -l $TIME -T 6,6 -P 0 -- -m63K &
ssh $loader1 netperf -H $ip1 -t UDP_STREAM -l $TIME -T 7,7 -P 0 -- -m63K &
ssh $loader1 netperf -H $ip1 -t UDP_STREAM -l $TIME -T 8,8 -P 0 -- -m63K &
ssh $loader1 netperf -H $ip1 -t UDP_STREAM -l $TIME -T 10,10 -P 0 -- -m63K &
ssh $loader1 netperf -H $ip1 -t UDP_STREAM -l $TIME -T 12,12 -P 0 -- -m63K &
ssh $loader1 netperf -H $ip1 -t UDP_STREAM -l $TIME -T 14,14 -P 0 -- -m63K &
ssh $loader1 netperf -H $ip1 -t UDP_STREAM -l $TIME -T 17,17 -P 0 -- -m63K &
ssh $loader1 netperf -H $ip1 -t UDP_STREAM -l $TIME -T 18,18 -P 0 -- -m63K &
ssh $loader2 netperf -H $ip2 -t UDP_STREAM -l $TIME -T 9,9 -P 0 -- -m63K &
ssh $loader2 netperf -H $ip2 -t UDP_STREAM -l $TIME -T 11,11 -P 0 -- -m63K &
ssh $loader2 netperf -H $ip2 -t UDP_STREAM -l $TIME -T 13,13 -P 0 -- -m63K &
ssh $loader2 netperf -H $ip2 -t UDP_STREAM -l $TIME -T 15,15 -P 0 -- -m63K &
ssh $loader2 netperf -H $ip2 -t UDP_STREAM -l $TIME -T 16,16 -P 0 -- -m63K &

sleep $TIME
sleep 3
