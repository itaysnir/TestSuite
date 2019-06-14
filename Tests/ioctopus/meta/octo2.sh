export DATE="OCTO/mtrx_nlro/"

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
	./run_single.sh -c -t ./Tests/ioctopus/multi_tcp_rx
	export SETUP_NAME="_r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t ./Tests/ioctopus/multi_tcp_rx
done

for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="l_$msg"
	export core=0
	export NODE=0
	echo $msg
	./run_single.sh -c -t ./Tests/ioctopus/multi_tcp_tx
	export SETUP_NAME="r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t ./Tests/ioctopus/multi_tcp_tx
done

#export TAIL_DELAY=5
#for msg in "${netperf_sizes[@]}";
#do
#	export MSG_SIZE=$msg
#	export SETUP_NAME="l_no_tso_$msg"
#	export core=0
#	export NODE=0
#	echo $msg
#	./run_single.sh -c -o -t ./Tests/ioctopus/single_tcp_tx
#	export SETUP_NAME="r_no_tso_$msg"
#	export core=1
#	export NODE=1
#	./run_single.sh -c -o -t ./Tests/ioctopus/single_tcp_tx
#done

#for msg in "${netperf_sizes[@]}";
#do
#	export MSG_SIZE=$msg
#	export SETUP_NAME="_l_on_$msg"
#	export core=0
#	export NODE=0
#	echo $msg
#	./run_single.sh -c -n -t ./Tests/ioctopus/single_tcp_rx
#	export SETUP_NAME="_r_on_$msg"
#	export core=1
#	export NODE=1
#	./run_single.sh -c -n -t ./Tests/ioctopus/single_tcp_rx
#done

#for msg in "${netperf_sizes[@]}";
#do
#	export MSG_SIZE=$msg
#	export SETUP_NAME="l_off_small_$msg"
#	export core=0
#	export NODE=0
#	echo $msg
#	./run_single.sh -c -o -n -t ./Tests/ioctopus/single_tcp_rx
#	export SETUP_NAME="r_off_small_$msg"
#	export core=1
#	export NODE=1
#	./run_single.sh -c -o -n -t ./Tests/ioctopus/single_tcp_rx
#done

#for msg in "${netperf_sizes[@]}";
#do
#	export MSG_SIZE=$msg
#	export SETUP_NAME="_l_off_big_$msg"
#	export core=0
#	export NODE=0
#	echo $msg
#	./run_single.sh -c -o -t ./Tests/ioctopus/single_tcp_rx
#	export SETUP_NAME="_r_off_big_$msg"
#	export core=1
#	export NODE=1
#	./run_single.sh -c -o -t ./Tests/ioctopus/single_tcp_rx
#done

#export TAIL_DELAY=5
#for msg in "${udp_sizes[@]}";
#do
#	export MSG_SIZE=$msg
#	export SETUP_NAME="l_$msg"
#	export core=0
#	export NODE=0
#	export rcore=1
#	export RNODE=1
#	echo $msg
#	./run_single.sh -c -t ./Tests/ioctopus/single_udp_tx
#	export SETUP_NAME="r_$msg"
#	export core=1
#	export NODE=1
#	export rcore=0
#	export RNODE=0
#	./run_single.sh -t ./Tests/ioctopus/single_udp_tx
#done

#export TAIL_DELAY=5
#for msg in "${udp_sizes[@]}";
#do
#	export MSG_SIZE=$msg
#	export SETUP_NAME="l_$msg"
#	export core=0
#	export NODE=0
#	export rcore=1
#	export RNODE=1
#	echo $msg
#	./run_single.sh -c -t ./Tests/ioctopus/single_udp_rx
#	export SETUP_NAME="r_$msg"
#	export core=1
#	export NODE=1
#	export rcore=0
#	export RNODE=0
#	./run_single.sh -t ./Tests/ioctopus/single_udp_rx
#done

