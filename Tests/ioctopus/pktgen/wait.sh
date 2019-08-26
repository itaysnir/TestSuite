op='/bin/bash ./pktgen.sh'
count=`ps -ef |grep "$op"|wc -l`

ps -ef |grep "$op"
run=30

while [ "$count" -gt 1 ];
do
	if [ "$run" -gt $TIME ];
	then
		echo "Killing $op timesup $run"
		pid=`ps -ef|grep '/bin/bash ./pktgen.sh'|grep -v markuze|awk '{print $2}'`
		sudo kill -9 $pid
		sleep 5
		exit
	fi
	count=`ps -ef |grep "$op"|wc -l`
	sleep 5
	let run+=5
done
echo "Done waiting $run"
