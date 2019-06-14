
count=`ps -ef |grep netperf|wc -l`

while [ "$count" -gt 1 ];
do
	count=`ps -ef |grep netperf|wc -l`
	sleep 5
done
