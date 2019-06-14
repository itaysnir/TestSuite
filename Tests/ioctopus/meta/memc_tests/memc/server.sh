core=0
ln=127.0.0.1
numactl  --membind=$core --cpunodebind=$core memcached -l $ln:11211 -m 32768 -d -t 1

