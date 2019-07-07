sudo pkill memcached
sleep 5
cd `dirname $0`
scp ./man/memslap.sh $loader1:/tmp/
scp ./man/conf.memc $loader1:/tmp/

function ex {
	echo "$@"
	$@
}

[ -z "$conf" ] && conf='l'
[ -z "$server" ] && server='l'

ex ./man/config_${conf}.sh
ex ./man/server_${server}.sh

numactl -C 0-16 unbuffer /homes/markuze/coloc/gapbs/pr -g 27 -k 32 -n 128 > /tmp/pr.log &
sleep 400
