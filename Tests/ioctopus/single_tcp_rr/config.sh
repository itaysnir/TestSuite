if [ -z "$mtu" ]; then
	mtu=1500
fi

if [ -z "$if1" ]; then
	echo "if1 not configured $if1"
	exit -1
fi

if [ -z "$ip1" ]; then
	echo "ip1 not configured $ip1"
	exit -1
fi

sockperf=/homes/markuze/sockperf/sockperf

[ -z "$NODE" ] && NODE=0
[ -z "$RNODE" ]&& RNODE=1

sudo set_irq_affinity_cpulist.sh $NODE $if2
sudo set_irq_affinity_cpulist.sh $NODE $if3

ssh $loader1 sudo pkill sockperf
scp $sockperf $loader1:/tmp/
ssh $loader1 sudo sudo numactl -C $RNODE /tmp/sockperf server --daemonize --tcp &
ssh $loader1 sudo set_irq_affinity_cpulist.sh $RNODE $dif2

echo "NODE = $NODE , RNODE = $RNODE"
