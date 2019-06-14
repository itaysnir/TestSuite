pid=`ps -ef|grep sockperf/sockperf|grep -v 00:00:0| awk  '{print $2}'`
echo $pid
ps -ef|grep sockperf/sockperf|grep -v 00:00:00 > /tmp/tmp

while [ ! -z "$pid" ];
do
	pid=`ps -ef|grep sockperf/sockperf|grep -v 00:00:0| awk  '{print $2}'`
	#echo "$pid"
	ps -ef|grep sockperf/sockperf|grep -v 00:00:0 >> /tmp/tmp
	sleep 5
done
