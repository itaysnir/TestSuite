
count=`ps -ef |grep memaslap|wc -l`

run=30
while [ "$count" -gt 1 ];
do
	if [ "$run" -gt $TIME ];
	then
		echo "Killing memaslap timesup $run"
		sleep 5
		exit
	fi
	count=`ps -ef |grep memaslap|wc -l`
	sleep 5
	let run+=5
done
