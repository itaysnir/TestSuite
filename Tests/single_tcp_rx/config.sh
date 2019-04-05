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
#sudo ifconfig $if4 $ip4 netmask 255.255.0.0 mtu $mtu
sudo set_irq_affinity_cpulist.sh $NODE $if1
sudo set_irq_affinity_cpulist.sh $NODE $if2
sudo set_irq_affinity_cpulist.sh $NODE $if3
