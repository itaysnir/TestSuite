time=60

netperf -H 10.0.100.31 -t TCP_STREAM -l $time -T 0,0  -- -m1M &
netperf -H 10.0.100.31 -t TCP_STREAM -l $time -T 0,1  -- -m1M &
netperf -H 10.0.100.31 -t TCP_STREAM -l $time -T 2,3  -- -m1M &

netperf -H 10.1.100.31 -t TCP_STREAM -l $time -T 8,15 -- -m1M &
netperf -H 10.1.100.31 -t TCP_STREAM -l $time -T 8,14 -- -m1M &
netperf -H 10.1.100.31 -t TCP_STREAM -l $time -T 6,10 -- -m1M &

#wait

netperf -H 10.0.100.31 -t TCP_MAERTS -l $time -T 2,2   &
netperf -H 10.0.100.31 -t TCP_MAERTS -l $time -T 4,3   &
netperf -H 10.1.100.31 -t TCP_MAERTS -l $time -T 6,4  &

netperf -H 10.0.100.31 -t TCP_MAERTS -l $time -T 10,13   &
netperf -H 10.0.100.31 -t TCP_MAERTS -l $time -T 12,12   &
netperf -H 10.1.100.31 -t TCP_MAERTS -l $time -T 14,11  &
wait
