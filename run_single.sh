#!/bin/bash

cd `dirname $0`

[ -z "$DATE" ] && DATE='HOTOS/TMP'

source ./Conf/config.sh

DO_CONF=1

function post()
{
	./parse_test.pl
	cd Results/HOTOS/
	pwd
	git add *;
	git commit -a -m"$SETUP_NAME"
	git push
	cd -
	#./sock.sh -d
}

function tiny_kernel()
{
	./sock.sh -d
	export RING='64'
	export SOCK_SIZE=''
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
	export SOCK_SIZE=67108864
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
	export MSG_SIZE='64K'
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

function usage() {
	echo "$0 [-c] [-t <Testname>]"
	exit -1
}

while getopts "nbhkuct:" var; do
	case $var in
	n)	tiny_kernel;;
	b)	big_kernel;;
	h)	big_user;;
	k)	small_kernel;;
	u)	small_user;;
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



[ -z "$DO_CONF" ] && ./Conf/setup.sh

NAME="`./Conf/get_name.sh`_${SETUP_NAME}"
[ -z "$SETUP_NAME" ] && NAME="`./Conf/get_name.sh`"

export OUT_FILE=Results/$DATE/`basename $Test`/$NAME
export repeat=3
rm -rf $OUT_FILE
mkdir -p $OUT_FILE
echo "running $Test $OUT_FILE"

show

./run_test.sh $Test
post

