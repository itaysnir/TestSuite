EDGES=27
GRAPH_TIME=60
graph=/homes/markuze/coloc/graph500-2.1.4-energy/mpi
graph=/homes/markuze/coloc/graph500-graph500-3.0.0/src/graph500_reference_bfs_sssp

export I_MPI_PIN=1
export I_MPI_PIN_PROCESSOR_LIST=8,9,10,11,12,13,14,15
export REUSEFILE=1
export TMPFILE=./graph500.el

mpiexec -n 16 $graph $EDGES 16 &
#sudo taskset -c 8-15 mpirun -np 8  --allow-run-as-root $graph $EDGES 128 &
#mpiexec -n 8 --cpu-set 16-23 $graph $EDGES 128 &

echo "hello..."
wait


