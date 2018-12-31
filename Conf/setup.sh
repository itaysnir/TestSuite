[ -e "./config.sh" ] && source ./config.sh
`dirname $0`/replace.sh
PFC='on'
LRO='on'
GRO='on'
RING=256

sudo ifconfig $if1 $ip1 netmask 255.255.255.0 mtu $mtu
sudo ifconfig $if2 $ip2 netmask 255.255.255.0 mtu $mtu
sudo ifconfig $if3 $ip3 netmask 255.255.255.0 mtu $mtu
sudo ifconfig $if4 $ip4 netmask 255.255.255.0 mtu $mtu

#sudo set_irq_affinity_cpulist.sh 0 $if1
#sudo set_irq_affinity_cpulist.sh 0 $if2
#sudo set_irq_affinity_cpulist.sh 0 $if3
#sudo set_irq_affinity_cpulist.sh 0 $if4

sudo ethtool -G $if1 rx $RING tx $RING
sudo ethtool -G $if2 rx $RING tx $RING
sudo ethtool -G $if3 rx $RING tx $RING
sudo ethtool -G $if4 rx $RING tx $RING

sudo ethtool -K $if1 lro $LRO
sudo ethtool -K $if1 gro $GRO
sudo ethtool -A $if1 rx $PFC tx $PFC
sudo ethtool -K $if2 lro $LRO
sudo ethtool -K $if1 gro $GRO
sudo ethtool -A $if2 rx $PFC tx $PFC
sudo ethtool -K $if3 lro $LRO
sudo ethtool -K $if1 gro $GRO
sudo ethtool -A $if3 rx $PFC tx $PFC
sudo ethtool -K $if4 lro $LRO
sudo ethtool -K $if1 gro $GRO
sudo ethtool -A $if4 rx $PFC tx $PFC

#sudo ethtool -K $if3 lro$LRO
#sudo ethtool -K $if4 lro$LRO
#sudo set_irq_affinity_cpulist.sh 0-15 $if1
#sudo set_irq_affinity_cpulist.sh 0-15 $if2

#ssh $loader1 sudo ifconfig $dif1 $dip1 netmask 255.255.255.0 mtu $mtu
ssh $loader2 sudo ifconfig $dif2 $dip2 netmask 255.255.255.0 mtu $mtu
ssh $loader2 sudo ifconfig $dif3 $dip3 netmask 255.255.255.0 mtu $mtu
#ssh $loader1 sudo ifconfig $dif4 $dip4 netmask 255.255.255.0 mtu $mtu
#ssh $loader1 sudo ethtool -K $dif1 lro $LRO
#ssh $loader1 sudo ethtool -A $dif1 rx $PFC tx $PFC
ssh $loader2 sudo ethtool -K $dif2 lro $LRO
ssh $loader2 sudo ethtool -A $dif2 rx $PFC tx $PFC

#ssh $loader1 sudo set_irq_affinity.sh $dif1
#ssh $loader1 sudo set_irq_affinity.sh $dif4
ssh $loader2 sudo set_irq_affinity.sh $dif2
ssh $loader2 sudo set_irq_affinity.sh $dif3
#ssh $loader2 sudo set_irq_affinity_cpulist.sh 0-15 $dif3
#ssh $loader1 sudo set_irq_affinity_cpulist.sh 0-15 $dif4

sudo modprobe msr
sudo sh -c "echo 8 > /proc/sys/vm/percpu_pagelist_fraction"
sudo sh -c "echo 0 > /proc/sys/kernel/nmi_watchdog"
sudo sh -c "echo 10 > /proc/sys/kernel/panic"
#sudo sh -c "echo 1 > /proc/sys/kernel/panic_on_oops"
#ssh $loader1 sudo sh -c "echo 65535 > /proc/sys/net/ipv4/tcp_min_tso_segs"
#ssh $loader2 sudo sh -c "echo 65535 > /proc/sys/net/ipv4/tcp_min_tso_segs"
sudo ethtool -K $if1 tx-nocache-copy off
sudo ethtool -K $if2 tx-nocache-copy off
sudo ethtool -K $if3 tx-nocache-copy off
sudo ethtool -K $if4 tx-nocache-copy off

exit
SOCK_SIZE=1073741824
sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/optmem_max"
sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/rmem_max"
sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/wmem_max"
sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/rmem_default"
sudo sh -c "echo $SOCK_SIZE > /proc/sys/net/core/wmem_default"


cat /proc/sys/net/core/optmem_max
cat /proc/sys/net/core/rmem_max
cat /proc/sys/net/core/wmem_max
cat /proc/sys/net/core/rmem_default
cat /proc/sys/net/core/wmem_default
