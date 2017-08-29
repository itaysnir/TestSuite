EDGES=20
GRAPH_TIME=60
graph=/homes/markuze/coloc/graph500-2.1.4-energy/mpi


taskset -c 0-7 mpiexec -n 8 $graph/graph500_mpi_simple $EDGES 128 $GRAPH_TIME &
taskset -c 8-15 mpiexec -n 8 $graph/graph500_mpi_simple $EDGES 128 $GRAPH_TIME &
taskset -c 16-23 mpiexec -n 8 $graph/graph500_mpi_simple $EDGES 128 $GRAPH_TIME &


