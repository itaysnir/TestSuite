sudo pkill memcache
sleep 5
cd `dirname $0`
scp ../man/memslap.sh $loader1:/tmp/
scp ../man/conf.memc $loader1:/tmp/

../man/config_r.sh
../man/server_r.sh
