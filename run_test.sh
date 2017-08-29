#Config collected info as well

[ -z "$OUT_FILE" ] && OUT_FILE=/tmp/
#rm -rf $OUT_FILE/*

Test=$1
[ -z "$Test" ] && echo "$0 ERROR: not test defined" && exit -1;

source $Test/config.sh
[ -z "$repeat" ] && repeat=1
[ -z "$DELAY" ] && DELAY=15

export TIME=90
echo "source $Test/config.sh"

#rm -rf $OUT_FILE/result.txt

echo "$date starting ($Test $repeat [$DELAY])"
for i in `seq 1 $repeat`; do
	date=`date +"%H:%M.%s:"`
	export OUT_FILE=$OUT_FILE
	$Test/test.sh >> $OUT_FILE/test_raw.txt &
	testid=$!
	echo "$date $Test/test.sh & $OUT_FILE"
	sleep $DELAY
	DataCollector/collect.sh &>> $OUT_FILE/result.txt
	DataCollector/collect_pcm.sh &>> $OUT_FILE/result_pcm.txt
	echo "$date waiting for test and collector ($Test)"
	wait ${!}
	echo "$date running post ($Test)"
	DataCollector/post_process.sh &>> $OUT_FILE/post.txt
done
date=`date +"%H:%M.%s:"`
echo "$date Done ($Test)"
