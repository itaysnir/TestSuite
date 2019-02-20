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

[ -z "$if1" ] || sudo set_irq_affinity_cpulist.sh 0 $if1
[ -z "$if2" ] || sudo set_irq_affinity_cpulist.sh 0 $if2
[ -z "$if3" ] || sudo set_irq_affinity_cpulist.sh 0 $if3
[ -z "$if4" ] || sudo set_irq_affinity_cpulist.sh 0 $if4


[ -z "$dif1" ] || ssh $loader1 sudo set_irq_affinity_bynode.sh 0 $dif1
