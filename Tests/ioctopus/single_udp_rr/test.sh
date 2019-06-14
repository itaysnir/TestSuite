if [ -z "$dip1" ]; then
	echo "dip not set..."
	exit -1
fi

[ -z "$TIME" ] && TIME=10
[ -z "$MSG_SIZE" ] && MSG_SIZE='1024'
[ -z "$core" ] && core=0

sockperf=/homes/markuze/sockperf/sockperf
sudo numactl -C $core $sockperf ping-pong -i $dip2 -t $TIME -m $MSG_SIZE


