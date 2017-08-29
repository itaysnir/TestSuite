[ -e "./config.sh" ] && source ./config.sh
`dirname $0`/replace.sh
sleep 20
PFC='on'
LRO='on'

sudo ifconfig $if1 $ip1 netmask 255.255.255.0 mtu $mtu
sudo ifconfig $if2 $ip2 netmask 255.255.255.0 mtu $mtu
sudo ifconfig $if3 $ip3 netmask 255.255.255.0 mtu $mtu
sudo ifconfig $if4 $ip4 netmask 255.255.255.0 mtu $mtu

sudo ethtool -G $if1 rx 256 tx 256
sudo ethtool -G $if2 rx 256 tx 256
sudo ethtool -G $if3 rx 256 tx 256
sudo ethtool -G $if4 rx 256 tx 256

sudo ethtool -K $if1 lro $LRO
sudo ethtool -A $if1 rx $PFC tx $PFC
sudo ethtool -K $if2 lro $LRO
sudo ethtool -A $if2 rx $PFC tx $PFC
sudo ethtool -K $if3 lro $LRO
sudo ethtool -A $if3 rx $PFC tx $PFC
sudo ethtool -K $if4 lro $LRO
sudo ethtool -A $if4 rx $PFC tx $PFC

#sudo ethtool -K $if3 lro$LRO
#sudo ethtool -K $if4 lro$LRO
#sudo set_irq_affinity_cpulist.sh 0-15 $if1
#sudo set_irq_affinity_cpulist.sh 0-15 $if2

ssh $loader1 sudo ifconfig $dif1 $dip1 netmask 255.255.255.0 mtu $mtu
ssh $loader2 sudo ifconfig $dif2 $dip2 netmask 255.255.255.0 mtu $mtu
ssh $loader2 sudo ifconfig $dif3 $dip3 netmask 255.255.255.0 mtu $mtu
ssh $loader1 sudo ifconfig $dif4 $dip4 netmask 255.255.255.0 mtu $mtu
ssh $loader1 sudo ethtool -K $dif1 lro $LRO
ssh $loader1 sudo ethtool -A $dif1 rx $PFC tx $PFC
ssh $loader2 sudo ethtool -K $dif2 lro $LRO
ssh $loader2 sudo ethtool -A $dif2 rx $PFC tx $PFC

ssh $loader1 sudo set_irq_affinity.sh $dif1
ssh $loader2 sudo set_irq_affinity.sh $dif2
ssh $loader2 sudo set_irq_affinity_cpulist.sh 0-15 $dif3
ssh $loader1 sudo set_irq_affinity_cpulist.sh 0-15 $dif4

sudo modprobe msr
sudo sh -c "echo 0 > /proc/sys/kernel/nmi_watchdog"
sudo sh -c "echo 10 > /proc/sys/kernel/panic"
#sudo sh -c "echo 1 > /proc/sys/kernel/panic_on_oops"
#ssh $loader1 sudo sh -c "echo 65535 > /proc/sys/net/ipv4/tcp_min_tso_segs"
#ssh $loader2 sudo sh -c "echo 65535 > /proc/sys/net/ipv4/tcp_min_tso_segs"
