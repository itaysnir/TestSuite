
count=`ps -ef |grep netperf|wc -l`

run=30
while [ "$count" -gt 1 ];
do
	if [ "$run" -gt $TIME ];
	then
		echo "Killing Netperf timesup $run"
		sudo pkill netperf
		sleep 5
		exit
	fi
	count=`ps -ef |grep netperf|wc -l`
	sleep 5
	let run+=5
done
