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

sudo ifconfig $if1 $ip1 netmask 255.255.0.0 mtu $mtu
sudo ifconfig $if2 $ip2 netmask 255.255.0.0 mtu $mtu
sudo set_irq_affinity_cpulist.sh 0-7 $if1
sudo set_irq_affinity_cpulist.sh 8-15 $if2

echo "Config... complete"
