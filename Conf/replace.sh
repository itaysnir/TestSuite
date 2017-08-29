#!/bin/bash

function replace {
	echo "replace bin"
	sudo modprobe -r mlx5_core
	sudo modprobe -r mlx_compat
	sudo insmod `dirname $0`/binaries/mlx5/`uname -r`/mlx_compat.ko
	sudo insmod `dirname $0`/binaries/mlx5/`uname -r`/mlx5_core.ko
}

[ -e "`dirname $0`/binaries/mlx5/`uname -r`/" ] && replace
