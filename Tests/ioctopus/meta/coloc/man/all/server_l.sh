ip=127.0.0.1
ip=INADDR_ANY
#numactl  --membind=$core --cpunodebind=$core memcached -l $ip:11211 -m 32768 -d -t 4 -k -r
#numactl  -C 20-27 memcached -l $ip:11211 -m 32768 -d -t 8 -k -r
#sudo pkill memcached
numactl  -N 0 memcached -l $ip2:11211 -m 32768 -d -t 14 -k -r
numactl  -N 1 memcached -l $ip3:11212 -m 32768 -d -t 14 -k -r
#numactl  -C 20,22,24,26 memcached -l $ip2:11211 -m 32768 -d -t 4 -k -r
#numactl  -C 21,23,25,27 memcached -l $ip3:11212 -m 32768 -d -t 4 -k -r
