if [ -z "$mtu" ]; then
	mtu=1500
fi

[ -z "$NODE" ] && NODE=0

sudo set_irq_affinity_cpulist.sh $NODE $if2
sudo set_irq_affinity_cpulist.sh $NODE $if3
#Get setup info
pwd
echo $0
cd `dirname $0`
echo "cleanup"
./memcahe_suite.sh cleanup
ssh $loader1 /tmp/memcahe_suite.sh cleanup
ssh $loader1 sudo set_irq_affinity.sh  $dif2

