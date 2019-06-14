#!/bin/bash

[ -z "$DATE" ] && DATE=`date +"%y_%m_%d_%H.%M.%S"`

export DATE="OCTO/$DATE/"

sockperf_sizes=( '64' '256' 1024 '4096' '16384' '65472' )
#sockperf_sizes=( '64' '256' )

export repeat=1
export TIME=320

for msg in "${sockperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_l_$msg"
	export core=0
	export NODE=0
	export RNODE=1
	echo $msg
	./run_single.sh -c -C -t ./Tests/ioctopus/single_tcp_rr
	export SETUP_NAME="_r_$msg"
	export core=1
	export NODE=1
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rr
done

for msg in "${sockperf_sizes[@]}";
do
	PRFX="_nlro"
	export MSG_SIZE=$msg
	export SETUP_NAME="${PRFX}_l_$msg"
	export core=0
	export NODE=0
	export RNODE=1
	echo $msg
	./run_single.sh -c -C -o -t ./Tests/ioctopus/single_tcp_rr
	export SETUP_NAME="${PRFX}_r_$msg"
	export core=1
	export NODE=1
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_tcp_rr
done

for msg in "${sockperf_sizes[@]}";
do
	export MSG_SIZE=$msg
	export SETUP_NAME="_l_$msg"
	export core=0
	export NODE=0
	export RNODE=1
	echo $msg
	./run_single.sh -c -C -t ./Tests/ioctopus/single_udp_rr
	export SETUP_NAME="_r_$msg"
	export core=1
	export NODE=1
	export RNODE=0
	./run_single.sh -t ./Tests/ioctopus/single_udp_rr
done


