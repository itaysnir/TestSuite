#!/bin/bash

SETUP_NAME='tmp'

function post()
{
	./parse_test.pl
	cd Results/HOTOS/
	pwd
	git add *;
	git commit -a -m"$SETUP_NAME"
	git push
	cd -
	./sock.sh -d
}

function small_kernel()
{
	./sock.sh -d
	export RING=''
	export SOCK_SIZE=''
}

function big_kernel()
{
	export RING=8192
	export SOCK_SIZE=1
}

function no_cache_on()
{
	export TX_CACHE='on'
}

function no_cache_off()
{
	export TX_CACHE='off'
}

function small_user()
{
	export MSG_SIZE='16K'
}

function big_user()
{
	export MSG_SIZE='128M'
}

function show()
{
	echo "NAME: $SETUP_NAME"
	echo "MSG_SIZE=$MSG_SIZE"
	echo "TX_CACHE=$TX_CACHE"
	echo "BIG_SOCK=$SOCK_SIZE"
	echo "RING_SIZE=$RING"
}

cd ..


while getopts "ct:" var; do
	case $var in

	c)
		unset DO_CONF;;
	t)
		if [ -d $OPTARG ]; then
			Test=$OPTARG;
		else
			echo "Error no such test $OPTARG"
			usage;
		fi
		;;

	*)
		usage ;;
	esac
done


