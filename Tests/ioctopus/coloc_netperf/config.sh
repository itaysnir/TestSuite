
cd `dirname $0`

[ -z "$conf" ] && conf='l'
[ -z "$server" ] && server='l'

./man/config_${conf}.sh

numactl -C 0-16 unbuffer /homes/markuze/coloc/gapbs/pr -g 27 -k 32 -n 128 > /tmp/pr.log &
sleep 400
