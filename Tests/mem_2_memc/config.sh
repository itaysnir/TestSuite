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
sudo set_irq_affinity_cpulist.sh 0-15 $if1
sudo set_irq_affinity_cpulist.sh 0-15 $if2

#Get setup info
cd `dirname $0`

`pwd`/Tests/memc/memcahe_suite.sh cleanup
ssh $loader `pwd`/Tests/memc/memcahe_suite.sh cleanup
ssh $loader rm -f $OUT_FILE/memc.out
ssh $loader mkdir -p  $OUT_FILE

