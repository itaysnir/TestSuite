ip=127.0.0.1
ip=INADDR_ANY
#numactl  --membind=$core --cpunodebind=$core memcached -l $ip:11211 -m 32768 -d -t 4 -k -r
#numactl  -C 20-27 memcached -l $ip:11211 -m 32768 -d -t 8 -k -r
sudo pkill	memcached
sleep 3
ps -ef|grep memcached|grep -v grep
numactl  -C 16,18,20,22,24,26 memcached -l $ip3:11212 -m 16384 -d -t 6 -k -r
numactl  -C 17,19,21,23,25,27 memcached -l $ip2:11211 -m 16384 -d -t 6 -k -r
