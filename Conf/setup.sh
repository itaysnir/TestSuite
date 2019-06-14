[ -e "./config.sh" ] && source ./config.sh
`dirname $0`/replace.sh
PFC='on'
GRO='on'

[ -z "$LRO" ] && LRO='on'
[ -z "$TSO" ] && TSO='on'
[ -z "$GSO" ] && GSO=$TSO

[ -z "$RING" ] && RING=1024
[ -z "$TX_RING" ] && TX_RING=1024
[ -z "$TX_CACHE" ] && TX_CACHE='off'


function die
{
	echo "$@"
	exit -1;
}

for i in `seq 1 6`;
do
	name="if$i"
	eval if=\$$name;
	name="ip$i"
	eval ip=\$$name;

	if [ ! -z "$if" ]; then
		[ -z "$ip" ] && die "ERROR: echo ip$i ($ip) not configured for $if"

		sudo ifconfig $if $ip netmask 255.255.255.0 mtu $mtu
		sudo ethtool -G $if rx $RING tx $TX_RING
		sudo ethtool -K $if lro $LRO
		sudo ethtool -K $if gro $GRO
		sudo ethtool -K $if gso $GSO
		sudo ethtool -K $if tso $TSO
		sudo ethtool -A $if rx $PFC tx $PFC
		#sudo ethtool -K $if1 tx-nocache-copy $TX_CACHE
		sudo ethtool -g $if
		sudo ethtool -k $if
		sudo ethtool -a $if
	fi
done

function setup_peers {

	if [ ! -z "$loader1" ]; then
		ssh $loader1 sudo ifconfig $dif1 $dip1 netmask 255.255.255.0 mtu $mtu
		ssh $loader1 sudo ifconfig $dif2 $dip2 netmask 255.255.255.0 mtu $mtu
		ssh $loader1 sudo ethtool -G $dif1 rx $RING tx $TX_RING
		ssh $loader1 sudo ethtool -G $dif2 rx $RING tx $TX_RING
		ssh $loader1 sudo ethtool -K $dif1 lro $LRO
		ssh $loader1 sudo ethtool -A $dif1 rx $PFC tx $PFC
		ssh $loader1 sudo ethtool -K $dif2 lro $LRO
		ssh $loader1 sudo ethtool -A $dif2 rx $PFC tx $PFC
		ssh $loader1 sudo set_irq_affinity.sh $dif1
		ssh $loader1 sudo set_irq_affinity.sh $dif2
	fi

	if [ ! -z "$loader2" ]; then
		ssh $loader2 sudo ifconfig $dif2 $dip2 netmask 255.255.255.0 mtu $mtu
		ssh $loader2 sudo ifconfig $dif3 $dip3 netmask 255.255.255.0 mtu $mtu
		ssh $loader2 sudo ethtool -K $dif2 lro $LRO
		ssh $loader2 sudo ethtool -A $dif2 rx $PFC tx $PFC

		ssh $loader2 sudo set_irq_affinity.sh $dif2
		ssh $loader2 sudo set_irq_affinity.sh $dif3
	fi
}

sudo ./setup_dual.sh
setup_peers

sudo modprobe msr
sudo sh -c "echo 8 > /proc/sys/vm/percpu_pagelist_fraction"
sudo sh -c "echo 0 > /proc/sys/kernel/nmi_watchdog"
sudo sh -c "echo 10 > /proc/sys/kernel/panic"
#sudo sh -c "echo 1 > /proc/sys/kernel/panic_on_oops"
#ssh $loader1 sudo sh -c "echo 65535 > /proc/sys/net/ipv4/tcp_min_tso_segs"
#ssh $loader2 sudo sh -c "echo 65535 > /proc/sys/net/ipv4/tcp_min_tso_segs"

echo "Ring size: $RING"
echo "TX no cache: $TX_CACHE"

[ -z  "$SOCK_SIZE" ] && exit

echo "Sock size: $SOCK_SIZE"
#SOCK_SIZE=1073741824
#SOCK_SIZE=270217728
#sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/optmem_max"
sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/rmem_max"
sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/wmem_max"
sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/rmem_default"
sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/wmem_default"

#if [ ! -z "$loader1" ]; then
#	sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/rmem_max"
#	sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/wmem_max"
#	sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/rmem_default"
#	sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/wmem_default"
#fi


#cat /proc/sys/net/core/optmem_max
cat /proc/sys/net/core/rmem_max
cat /proc/sys/net/core/wmem_max
cat /proc/sys/net/core/rmem_default
cat /proc/sys/net/core/wmem_default
