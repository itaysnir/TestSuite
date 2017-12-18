TIME=60
[ -z "$TIME" ] && TIME=30

#node 0 vs tapuz31
# TX
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 1,0 -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 1,1 -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 3,3 -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 3,4 -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_STREAM -l $TIME -T 3,5 -P 0 -- -m1M &
#RX
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 5,6 -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 7,7 -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 9,8 -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 11,9 -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 13,10 -P 0 -- -m1M &
	netperf -H $dip1 -t TCP_MAERTS -l $TIME -T 13,11 -P 0 -- -m1M &
#node 1 vs tapuz30
# TX
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 17,0 -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 17,1 -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 19,3 -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 19,4 -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_STREAM -l $TIME -T 19,5 -P 0 -- -m1M &
#RX
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 15,6 -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 23,7 -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 25,8 -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 27,9 -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 21,10 -P 0 -- -m1M &
	netperf -H $dip2 -t TCP_MAERTS -l $TIME -T 23,11 -P 0 -- -m1M &
wait
