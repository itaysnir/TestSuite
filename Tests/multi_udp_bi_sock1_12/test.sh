if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=30

cpus=`nproc`
let cpus=cpus-1

netperf -H 10.1.130.30 -t UDP_STREAM -l $TIME -T 1,0 &
netperf -H 10.1.130.30 -t UDP_STREAM -l $TIME -T 3,2 &
netperf -H 10.1.130.30 -t UDP_STREAM -l $TIME -T 5,4 &
ssh tapuz30 netperf -H 10.1.130.100 -t UDP_STREAM -l $TIME -T 6,7 &
ssh tapuz30 netperf -H 10.1.130.100 -t UDP_STREAM -l $TIME -T 8,9 &
ssh tapuz30 netperf -H 10.1.130.100 -t UDP_STREAM -l $TIME -T 10,11 &

netperf -H 10.0.130.31 -t UDP_STREAM -l $TIME -T 13,0 &
netperf -H 10.0.130.31 -t UDP_STREAM -l $TIME -T 15,2 &
netperf -H 10.0.130.31 -t UDP_STREAM -l $TIME -T 17,4 &
ssh tapuz31 netperf -H 10.0.130.100 -t UDP_STREAM -l $TIME -T 6,19 &
ssh tapuz31 netperf -H 10.0.130.100 -t UDP_STREAM -l $TIME -T 8,21 &
ssh tapuz31 netperf -H 10.0.130.100 -t UDP_STREAM -l $TIME -T 10,23 &
ssh tapuz31 netperf -H 10.0.130.100 -t UDP_STREAM -l $TIME -T 12,25 &
#ssh tapuz31 netperf -H 10.0.130.100 -t UDP_STREAM -l $TIME -T 14,27 &

wait
