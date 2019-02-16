if [ -z "$mtu" ]; then
	mtu=1500
fi
echo "$if1"
if [ -z "$if1" ]; then
	echo "if1 not configured $if1"
	exit 22
fi

if [ -z "$ip1" ]; then
	echo "ip1 not configured $ip1"
	exit 22
fi

if [ -z "$if2" ]; then
	echo "if1 not configured $if1"
	exit 22
fi

if [ -z "$ip2" ]; then
	echo "ip1 not configured $ip1"
	exit 22
fi

sudo set_irq_affinity.sh $if1 $if2
sudo set_irq_affinity.sh $if3 $if4

#sudo set_irq_affinity_bynode.sh  0 $if1
#sudo set_irq_affinity_bynode.sh  1 $if2
#sudo set_irq_affinity_bynode.sh  0 $if3
#sudo set_irq_affinity_bynode.sh  1 $if4
