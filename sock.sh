#!/bin/bash

#SOCK_SIZE=1073741824
SOCK_SIZE=$((16 * 1024 * 1024));
OPTMEM=$((64 * 1024));

optmem=20480
mem_max=212992

function usage ()
{
	echo "Usage: `basename $0` [-s <Size>, -d -m]"
}

function set_ipfrag_lim ()
{
	IPFRAG_LIM=$((1024 * 1024 * 1024));
	sudo sh -c "echo $IPFRAG_LIM > /proc/sys/net/ipv4/ipfrag_high_thresh"
	cat /proc/sys/net/ipv4/ipfrag_high_thresh
}

function set_sock_size ()
{
	sudo sh -c "echo $optmem > /proc/sys/net/core/optmem_max"
	sudo sh -c "echo $mem_max > /proc/sys/net/core/rmem_max"
	sudo sh -c "echo $mem_max > /proc/sys/net/core/wmem_max"
	sudo sh -c "echo $mem_max > /proc/sys/net/core/rmem_default"
	sudo sh -c "echo $mem_max > /proc/sys/net/core/wmem_default"
}

function get_sock_size ()
{
	val=`cat /proc/sys/net/core/optmem_max`
	echo "/proc/sys/net/core/optmem_max = $val"
	val=`cat /proc/sys/net/core/rmem_max`
	echo "/proc/sys/net/core/rmem_max = $val"
	val=`cat /proc/sys/net/core/wmem_max`
	echo "/proc/sys/net/core/wmem_max = $val"
	val=`cat /proc/sys/net/core/rmem_default`
	echo "/proc/sys/net/core/rmem_default = $val"
	val=`cat /proc/sys/net/core/wmem_default`
	echo "/proc/sys/net/core/wmem_default = $val"
}

if (( $# == 0 )); then
	i=$((1024 * 1024 * 1024));
	echo $i
	get_sock_size;
	exit 0;
fi

while getopts "s:mdf" opt; do
	case $opt in
	s)
		echo "$0 called with size $OPTARG";
		optmem=$OPTARG;
		mem_max=$OPTARG;
		;;
	d)
		echo "restoring defaults";
		;;
	m)
		echo "seting mem opts to $SOCK_SIZE";
		optmem=$OPTMEM;
		mem_max=$SOCK_SIZE;
		;;
	f)	echo "setting ipfrag limit"
		set_ipfrag_lim;
		exit
		;;
	\?)
		usage;
		;;
	esac
done
set_sock_size;
