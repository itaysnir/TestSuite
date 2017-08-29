time=60

netperf -H 10.0.100.31 -t TCP_STREAM -l $time -T 0,0  -- -m1M &
netperf -H 10.0.100.31 -t TCP_STREAM -l $time -T 0,1  -- -m1M &
netperf -H 10.0.100.31 -t TCP_STREAM -l $time -T 2,6  -- -m1M &

netperf -H 10.1.100.31 -t TCP_STREAM -l $time -T 1,15 -- -m1M &
netperf -H 10.1.100.31 -t TCP_STREAM -l $time -T 1,14 -- -m1M &
netperf -H 10.1.100.31 -t TCP_STREAM -l $time -T 3,10 -- -m1M &

#wait

netperf -H 10.0.100.31 -t TCP_MAERTS -l $time -T 2,2   &
netperf -H 10.0.100.31 -t TCP_MAERTS -l $time -T 4,3   &
netperf -H 10.0.100.31 -t TCP_MAERTS -l $time -T 6,4  &

netperf -H 10.1.100.31 -t TCP_MAERTS -l $time -T 3,13   &
netperf -H 10.1.100.31 -t TCP_MAERTS -l $time -T 5,12   &
netperf -H 10.1.100.31 -t TCP_MAERTS -l $time -T 7,11  &
wait
