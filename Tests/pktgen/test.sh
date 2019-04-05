#/bin/bash
cd `dirname $0`
[ -z "$sif" ] && sif=$if1
[ -z "$ip" ] && ip=$dip1
[ -z "$core" ] && core=0
[ -z "$pkt_size" ] && pkt_size=64
[ -z "$dmac" ] && dmac='24:8a:07:b5:7b:34'

[ -z $COUNT ] && COUNT="200000000"   # Zero means indefinitely
[ -z "$sif" ] && exit -1;

echo "[$sif,$ip $dmac, $pkt_size]"

export COUNT=$COUNT
echo $COUNT >2
./pktgen.sh -i $sif -d $ip -c 1024 -t $core -m $dmac -s $pkt_size


#time ./pktgen.sh -i mlx0 -d 1.1.1.1 -m 24:8a:07:b5:7b:34 -v -t 1
# Print results
#TOTAL=0;

#for ((thread = 0; thread < $THREADS; thread++)); do
#	dev=${DEV}@${thread}
#	pps=`sudo cat /proc/net/pktgen/$dev | grep pps |cut -dp -f1`
#	TOTAL=$(($TOTAL+$pps))
#	#echo "$dev: $pps, $TOTAL"
#done
#echo "$TOTAL Units";
