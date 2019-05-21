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

if [ -z "$if2" ]; then
	echo "if1 not configured $if1"
	exit -1
fi

if [ -z "$ip2" ]; then
	echo "ip1 not configured $ip1"
	exit -1
fi

[ -z "$core" ] && core=0

sudo set_irq_affinity_bynode.sh $core $if1
sudo set_irq_affinity_bynode.sh $core $if2

