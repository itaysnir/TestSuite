ip=127.0.0.1
ip=INADDR_ANY
#numactl  --membind=$core --cpunodebind=$core memcached -l $ip:11211 -m 32768 -d -t 4 -k -r
#numactl  -C 20-27 memcached -l $ip:11211 -m 32768 -d -t 8 -k -r
numactl  -C 20-27 memcached -l $ip3:11211,$ip2:11211 -m 32768 -d -t 8 -k -r
