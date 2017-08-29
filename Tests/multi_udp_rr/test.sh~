if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`lscpu|grep -P "^CPU\(s\)"|cut -d: -f2`
let cpus=cpus-1

for i in `seq 0  $cpus`;
do
	netperf -H $dip1 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip1 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip1 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip1 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip1 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip1 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip1 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip1 -t UDP_RR -l $TIME -T $i,$i&

	netperf -H $dip2 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip2 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip2 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip2 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip2 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip2 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip2 -t UDP_RR -l $TIME -T $i,$i&
	netperf -H $dip2 -t UDP_RR -l $TIME -T $i,$i&
done

wait
