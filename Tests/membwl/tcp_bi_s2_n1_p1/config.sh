if [ -z "$mtu" ]; then
	mtu=1500
fi

if [ -z "$if1" ]; then
	echo "if3 not configured $if1"
	exit -1
fi

if [ -z "$ip1" ]; then
	echo "ip1 not configured $ip1"
	exit -1
fi

if [ -z "$if2" ]; then
	echo "if3 not configured $if2"
	exit -1
fi

if [ -z "$ip2" ]; then
	echo "ip1 not configured $ip1"
	exit -1
fi

sudo set_irq_affinity.sh  0 $if1
sudo set_irq_affinity.sh  1 $if2
sudo set_irq_affinity.sh  0 $if3
sudo set_irq_affinity.sh  1 $if4
