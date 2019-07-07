op="stream/stream"
count=`ps -ef |grep $op|wc -l`

run=30
while [ "$count" -gt 1 ];
do
	if [ "$run" -gt $TIME ];
	then
		echo "Killing $op timesup $run"
		sudo pkill stream
		sleep 5
		exit
	fi
	count=`ps -ef |grep $op|wc -l`
	sleep 5
	let run+=5
done
echo "Done waiting $run"
