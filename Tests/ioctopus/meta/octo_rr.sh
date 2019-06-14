export DATE="OCTO/test_1500_3/"

sockperf_sizes=( '64' '256' 1024 '4096' '16384' '65472' )
netperf_sizes=( '64K' '16K' 256 '1K' '4K' '64' )
udp_sizes=( 64 256 '1K' '4K' '16K' '63K' )
pktgen_sizes=( 1500 1024 64 128 256 512 1024 )

export repeat=1
export TIME=240

for msg in "${sockperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_l_$msg"
	export core=0
	export NODE=0
	export RNODE=1
	echo $msg
	./run_single.sh -c -t ./Tests/ioctopus/single_tcp_rr
	export SETUP_NAME="_r_$msg"
	export core=1
	export NODE=1
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rr
done

for msg in "${sockperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_nlro_l_$msg"
	export core=0
	export NODE=0
	export RNODE=1
	echo $msg
	./run_single.sh -c -o -t ./Tests/ioctopus/single_tcp_rr
	export SETUP_NAME="_nlro_r_$msg"
	export core=1
	export NODE=1
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rr
done

for msg in "${sockperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_nC_l_$msg"
	export core=0
	export NODE=0
	export RNODE=1
	echo $msg
	./run_single.sh -c -o -C -t ./Tests/ioctopus/single_tcp_rr
	export SETUP_NAME="_nC_r_$msg"
	export core=1
	export NODE=1
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rr
done

export TAIL_DELAY=5
for msg in "${sockperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_nlro_nC_l_$msg"
	export core=0
	export NODE=0
	export RNODE=1
	echo $msg
	./run_single.sh -c -C -o -t ./Tests/ioctopus/single_tcp_rr
	export SETUP_NAME="_nlro_nC_r_$msg"
	export core=1
	export NODE=1
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rr
done

for msg in "${sockperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_irq_nC_l_$msg"
	export core=2
	export NODE=0
	export RNODE=1
	echo $msg
	./run_single.sh -c -C -t ./Tests/ioctopus/single_tcp_rr
	export SETUP_NAME="_irq_nC_r_$msg"
	export core=1
	export NODE=3
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rr
done

