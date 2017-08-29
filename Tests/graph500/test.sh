EDGES=20
GRAPH_TIME=450
NET_TIME=1200
graph=/homes/markuze/coloc/graph500-2.1.4-energy/mpi

sudo set_irq_affinity_cpulist.sh 24-27 $if1
sudo set_irq_affinity_cpulist.sh 24-27 $if2

taskset -c 0-7 mpiexec -n 8 $graph/graph500_mpi_simple $EDGES 128 $GRAPH_TIME &
taskset -c 8-15 mpiexec -n 8 $graph/graph500_mpi_simple $EDGES 128 $GRAPH_TIME &
taskset -c 16-23 mpiexec -n 8 $graph/graph500_mpi_simple $EDGES 128 $GRAPH_TIME &

#netperf -H $dip1 -t TCP_STREAM -l $NET_TIME -P 0 -T 24,0 -- -m1M &
netperf -H $dip1 -t TCP_STREAM -l $NET_TIME -P 0 -T 24,1 -- -m1M &
netperf -H $dip1 -t TCP_MAERTS -l $NET_TIME -P 0 -T 24,2 -- -m1M &
netperf -H $dip2 -t TCP_MAERTS -l $NET_TIME -P 0 -T 24,0 -- -m1M &

#netperf -H $dip1 -t TCP_STREAM -l $NET_TIME -P 0 -T 25,3 -- -m1M &
netperf -H $dip1 -t TCP_STREAM -l $NET_TIME -P 0 -T 25,4 -- -m1M &
netperf -H $dip1 -t TCP_MAERTS -l $NET_TIME -P 0 -T 25,5 -- -m1M &
netperf -H $dip2 -t TCP_STREAM -l $NET_TIME -P 0 -T 25,1 -- -m1M &

#netperf -H $dip1 -t TCP_STREAM -l $NET_TIME -P 0 -T 26,6 -- -m1M &
netperf -H $dip1 -t TCP_STREAM -l $NET_TIME -P 0 -T 26,7 -- -m1M &
netperf -H $dip1 -t TCP_MAERTS -l $NET_TIME -P 0 -T 26,8 -- -m1M &
netperf -H $dip2 -t TCP_MAERTS -l $NET_TIME -P 0 -T 26,2 -- -m1M &

#netperf -H $dip1 -t TCP_STREAM -l $NET_TIME -P 0 -T 27,9 -- -m1M &
netperf -H $dip1 -t TCP_STREAM -l $NET_TIME -P 0 -T 27,10 -- -m1M &
netperf -H $dip1 -t TCP_MAERTS -l $NET_TIME -P 0 -T 27,11 -- -m1M &
netperf -H $dip2 -t TCP_STREAM -l $NET_TIME -P 0 -T 27,3 -- -m1M &

sleep $NET_TIME
sudo pkill mpiexec
