sudo set_irq_affinity_cpulist.sh 2 $if2
sudo set_irq_affinity_cpulist.sh 2 $if3

numactl  -m 0 -C 0 memcached -l $ip2:11211,$ip3:11212 -m 32768 -d -t 1 -k -r
numactl  -m 1 -C 1 memcached -l $ip2:11213 -m 32768 -d -t 1 -k -r
