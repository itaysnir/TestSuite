export DATE="OCTO/test_1500_3/"

netperf_sizes=( '64K' '16K' 256 '1K' '4K' '64' )
udp_sizes=( 64 256 '1K' '4K' '16K' '63K' )
pktgen_sizes=( 1500 1024 64 128 256 512 1024 )

for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_l_$msg"
	export core=0
	export NODE=0
	echo $msg
	./run_single.sh -c -t ./Tests/ioctopus/single_tcp_tx
	export SETUP_NAME="_r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t ./Tests/ioctopus/single_tcp_tx
done


export TAIL_DELAY=5
for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_l_$msg"
	export core=0
	export NODE=0
	echo $msg
	./run_single.sh -c -t ./Tests/ioctopus/single_tcp_rx_x2
	export SETUP_NAME="_r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rx_x2
done

for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_nlro_l_$msg"
	export core=0
	export NODE=0
	echo $msg
	./run_single.sh -c -o -t ./Tests/ioctopus/single_tcp_rx_x2
	export SETUP_NAME="_nlro_r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rx_x2
done

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
	export SETUP_NAME="_nlro_irq_l_$msg"
	export core=2
	export NODE=0
	echo $msg
	./run_single.sh -c -o -t ./Tests/ioctopus/single_tcp_rx
	export SETUP_NAME="_nlro_irq_r_$msg"
	export core=1
	export NODE=3
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rx
done

export TAIL_DELAY=5
for msg in "${netperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_irq_l_$msg"
	export core=2
	export NODE=0
	echo $msg
	./run_single.sh -c -t ./Tests/ioctopus/single_tcp_rx
	export SETUP_NAME="_irq_r_$msg"
	export core=1
	export NODE=3
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

