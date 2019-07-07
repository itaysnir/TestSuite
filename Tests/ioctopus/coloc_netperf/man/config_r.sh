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


sudo set_irq_affinity_cpulist.sh 16,18,20,22,24,26 $if3
sudo set_irq_affinity_cpulist.sh 17,19,21,23,25,27 $if2


ssh $loader1 sudo set_irq_affinity.sh $dif2
