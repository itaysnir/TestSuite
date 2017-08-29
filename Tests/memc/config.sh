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

sudo set_irq_affinity.sh  $if1
sudo set_irq_affinity.sh  $if2

TIME=180
repeat=1
DELAY=90
#Get setup info
cd `dirname $0`

`pwd`/Tests/memc/memcahe_suite.sh cleanup
ssh $loader `pwd`/Tests/memc/memcahe_suite.sh cleanup
ssh $loader rm -f $OUT_FILE/memc.out
ssh $loader mkdir -p  $OUT_FILE

