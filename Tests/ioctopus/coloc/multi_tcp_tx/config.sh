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

[ -z "$NODE" ] && NODE=0
[ -z "$RNODE" ] && RNODE=1

sudo set_irq_affinity.sh $if1
sudo set_irq_affinity_bynode.sh $NODE $if2
if [ "$NODE" -eq 0 ]; then
	NODE=1
else
	NODE=0
fi
sudo set_irq_affinity_bynode.sh $NODE $if3

ssh $loader1 sudo set_irq_affinity.sh $dif2
