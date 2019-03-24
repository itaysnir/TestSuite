#/bin/bash
cd `dirname $0`
[ -z "$sif" ] && sif=$if1
[ -z "$ip" ] && ip=$dip1
[ -z "$core" ] && core=0
[ -z "$dmac" ] && dmac='24:8a:07:b5:7b:34'

echo "[$sif,$ip $dmac]"
[ -z "$sif" ] && exit -1;

./pktgen.sh -i $sif -d $ip -c 1 -t $core -m $dmac -v
#time ./pktgen.sh -i mlx0 -d 1.1.1.1 -m 24:8a:07:b5:7b:34 -v -t 1
#./pktgen_30_p2p1.sh -i p2p1 -t 0 -c 0  -v &
#./pktgen_30_p2p1.sh -i p2p1 -t 1 -c 0  -v &
#./pktgen_30_p2p1.sh -i p2p1 -t 2 -c 0  -v &
#./pktgen_30_p2p1.sh -i p2p1 -t 3 -c 0  -v &
#./pktgen_30_p2p1.sh -i p2p1 -t 4 -c 0  -v &
#./pktgen_30_p2p1.sh -i p2p1 -t 5 -c 0  -v &
#./pktgen_30_p2p1.sh -i p2p1 -t 6 -c 0  -v &
#./pktgen_30_p2p1.sh -i p2p1 -t 7 -c 0  -v &
#./pktgen_30_p2p2.sh -i p2p2 -t 8 -c 0  -v &
#./pktgen_30_p2p2.sh -i p2p2 -t 9 -c 0  -v &
#./pktgen_30_p2p2.sh -i p2p2 -t 10 -c 0  -v &
#./pktgen_30_p2p2.sh -i p2p2 -t 11 -c 0  -v &
#./pktgen_30_p2p2.sh -i p2p2 -t 12 -c 0  -v &
#./pktgen_30_p2p2.sh -i p2p2 -t 13 -c 0  -v &
#./pktgen_30_p2p2.sh -i p2p2 -t 14 -c 0  -v &
#./pktgen_30_p2p2.sh -i p2p2 -t 15 -c 0  -v &

wait
# Print results
#TOTAL=0;

#for ((thread = 0; thread < $THREADS; thread++)); do
#	dev=${DEV}@${thread}
#	pps=`sudo cat /proc/net/pktgen/$dev | grep pps |cut -dp -f1`
#	TOTAL=$(($TOTAL+$pps))
#	#echo "$dev: $pps, $TOTAL"
#done
#echo "$TOTAL Units";
