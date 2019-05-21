numactl  -C 0 memcached -l $ip3:11212,$ip2:11211 -m 32768 -d -t 1 -k -r
