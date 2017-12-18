#!/bin/bash

function replace {
	echo "replace bin"
	sudo modprobe -r mlx5_core
	sudo modprobe -r mlx_compat
	sudo insmod `dirname $0`/binaries/mlx5/`uname -r`/mlx_compat.ko
	sudo insmod `dirname $0`/binaries/mlx5/`uname -r`/mlx5_core.ko
	sleep 20
}

[ -e "`dirname $0`/binaries/mlx5/`uname -r`/" ] && replace
lsmod|grep mlx5
[ "$?" -eq 1 ] && sudo modprobe mlx5_core
