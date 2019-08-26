#!/bin/bash

cd `dirname $0`

[ -z "$DATE" ] && DATE='HOTOS/TMP'

source ./Conf/config.sh

DO_CONF=1
DO_IRQ=1

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
	export RING='256'
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

function coal_off()
{

		echo "config no IRQ coallessing"
		sudo ethtool -C $if2 adaptive-rx off rx-usecs 0 rx-frames 0 adaptive-tx off tx-usecs 0 tx-frames 0
		ssh $loader1 sudo ethtool -C $dif2 adaptive-rx off rx-usecs 0 rx-frames 0 adaptive-tx off tx-usecs 0 tx-frames 0
}

function def_coal()
{
#set deault
#$sudo ethtool -c oct00
#Coalesce parameters for oct00:
#Adaptive RX: on  TX: off
#stats-block-usecs: 0
#sample-interval: 0
#pkt-rate-low: 0
#pkt-rate-high: 0
#
#rx-usecs: 8
#rx-frames: 128
#rx-usecs-irq: 0
#rx-frames-irq: 0
#
#tx-usecs: 16
#tx-frames: 32
#tx-usecs-irq: 0
#tx-frames-irq: 0
#
#rx-usecs-low: 0
#rx-frame-low: 0
#tx-usecs-low: 0
#tx-frame-low: 0
#
#rx-usecs-high: 0
#rx-frame-high: 0
#tx-usecs-high: 0
		echo "Default coallessing"
		sudo ethtool -C $if2 adaptive-rx on rx-usecs 8 rx-frames 128 adaptive-tx off tx-usecs 16 tx-frames 32
		sudo ethtool -C $if3 adaptive-rx on rx-usecs 8 rx-frames 128 adaptive-tx off tx-usecs 16 tx-frames 32
		ssh $loader1 sudo ethtool -C $dif2 adaptive-rx on rx-usecs 8 rx-frames 128 adaptive-tx off tx-usecs 16 tx-frames 32
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

TSO='on'
LRO='on'

while getopts "jnbhkucCost:" var; do
	case $var in
	j)	export MTU=9000;;
	n)	tiny_kernel;;
	b)	big_kernel;;
	h)	big_user;;
	k)	small_kernel;;
	u)	small_user;;
	c)
		unset DO_CONF;;
	o)
		LRO='off';;
	C)
		unset DO_IRQ;;

	s)
		TSO='off';;

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



[ -z "$DO_CONF" ] && TSO=$TSO LRO=$LRO ./Conf/setup.sh &> /dev/null

if [ -z "$DO_IRQ" ]; then
	coal_off
else
	def_coal
fi

NAME="`./Conf/get_name.sh`${SETUP_NAME}"
[ -z "$SETUP_NAME" ] && NAME="`./Conf/get_name.sh`"

[ -z "$repeat" ] && repeat=7
export OUT_FILE=Results/$DATE/"`basename $Test`${SETUP_NAME}"/`uname -r`/
export repeat=$repeat
[ -z "$TIME" ] && TIME=40

export TIME=$TIME

rm -rf $OUT_FILE
mkdir -p $OUT_FILE
echo "running $Test $OUT_FILE"

echo "<$Test>"
BG=$BG ./run_test.sh $Test

