if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

#cpus=`lscpu|grep -P "^CPU\(s\)"|cut -d: -f2`
cpus=`nproc`
let cpus=cpus-1

for i in `seq 0  $cpus`;
do
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T $i,$i -- -m1M &
#	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T $i,$i -- -m1M &
#	netperf -H $dip3 -t TCP_MAERTS -l $TIME -T $i,$i -- -m1M &
#	netperf -H $dip4 -t TCP_MAERTS -l $TIME -T $i,$i -- -m1M &
done

wait
