numactl -m 0 -C 16,18,20,22,24,26 memcached -l $ip2:11211 -m 24576 -d -t 6 -k -r
numactl -m 1 -C 17,19,21,23,25,27 memcached -l $ip3:11212 -m 24576 -d -t 6 -k -r
