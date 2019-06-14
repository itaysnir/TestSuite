export DATE="OCTO/test_1500/"

netperf_sizes=( '64K' '16K' 256 '1K' '4K' '64' )
udp_sizes=( 64 256 '1K' '4K' '16K' '63K' )
pktgen_sizes=( 1500 1024 64 128 256 512 1024 )

export TAIL_DELAY=5
for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_l_$msg"
	export core=0
	export NODE=0
	echo $msg
	./run_single.sh -c -t ./Tests/ioctopus/single_tcp_rx
	export SETUP_NAME="_r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rx
done

for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_nlro_l_$msg"
	export core=0
	export NODE=0
	echo $msg
	./run_single.sh -c -o -t ./Tests/ioctopus/single_tcp_rx
	export SETUP_NAME="_nlro_r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rx
done

export TAIL_DELAY=5
for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_ntso_l_$msg"
	export core=0
	export NODE=0
	echo $msg
	./run_single.sh -c -s -t ./Tests/ioctopus/single_tcp_tx
	#./run_single.sh -t ./Tests/ioctopus/single_tcp_tx_mn
	export SETUP_NAME="_ntso_r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t ./Tests/ioctopus/single_tcp_tx
	#./run_single.sh -t ./Tests/ioctopus/single_tcp_tx_mn
done

export TAIL_DELAY=5
for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_l_$msg"
	export core=0
	export NODE=0
	echo $msg
	./run_single.sh -c -t ./Tests/ioctopus/single_tcp_tx
	#./run_single.sh -t ./Tests/ioctopus/single_tcp_tx_mn
	export SETUP_NAME="_r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t ./Tests/ioctopus/single_tcp_tx
	#./run_single.sh -t ./Tests/ioctopus/single_tcp_tx_mn
done
exit

for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="l_$msg"
	export core=2
	export NODE=2
	export rcore=1
	export RNODE=1
	echo $msg
	./run_single.sh -c -t ./Tests/ioctopus/single_tcp_rr
	export SETUP_NAME="r_$msg"
	export core=1
	export NODE=1
	export rcore=0
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rr
done

export TAIL_DELAY=5
for msg in "${udp_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="l_$msg"
	export core=2
	export NODE=2
	export rcore=1
	export RNODE=1
	echo $msg
	./run_single.sh -c -t ./Tests/ioctopus/single_udp_rr
	export SETUP_NAME="r_$msg"
	export core=1
	export NODE=1
	export rcore=0
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_udp_rr
done

for msg in "${pktgen_sizes[@]}";
do
	export pkt_size=$msg
	export SETUP_NAME="ll_$msg"
	export core=2
	export TAIL_DELAY=5
	./run_single.sh -t ./Tests/ioctopus/pktgen
	export SETUP_NAME="lr_$msg"
	export core=1
	export TAIL_DELAY=5
	./run_single.sh -t ./Tests/ioctopus/pktgen
done

###########################3
export TAIL_DELAY=5
export DELAY=15
export SETUP_NAME="loc"
export core=0
export NODE=0
./run_single.sh -c -t ./Tests/ioctopus/memc
export SETUP_NAME="remote"
export core=1
export NODE=1
./run_single.sh -t ./Tests/ioctopus/memc
