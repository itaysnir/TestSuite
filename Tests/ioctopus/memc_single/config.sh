if [ -z "$if2" ]; then
        echo "if3 not configured $if1"
        exit -1
fi

if [ -z "$cfg" ]; then
        echo "cfg nof configured"
        exit -1
fi

if [ -z "$if3" ]; then
        echo "if3 not configured $if1"
        exit -1
fi

if [ -z "$loader1" ]; then
        echo "loader1 not configured $loader1"
        exit -1
fi

if [ -z "$RNODE" ]; then
        echo "RNODE not configured $RNODE"
        exit -1
fi

sudo pkill memcached
sleep 5
sudo set_irq_affinity_cpulist.sh 0 $if2
sudo set_irq_affinity_cpulist.sh 0 $if3

ssh $loader1 sudo set_irq_affinity_bynode.sh $RNODE $dif2

numactl  -m 0 -C 0 memcached -l $ip2:11211,$ip3:11212 -m 32768 -d -t 1 -k -r
numactl  -m 1 -C 1 memcached -l $ip2:11213 -m 32768 -d -t 1 -k -r

echo "scp $cfg $loader1:/tmp/memc.cfg"
scp $cfg $loader1:/tmp/memc.cfg
