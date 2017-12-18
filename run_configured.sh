#!/bin/bash

cd `dirname $0`

[ -z "$DATE" ] && DATE=TMP

source ./Conf/config.sh
./Conf/setup.sh

NAME="`./Conf/get_name.sh`_${MAG_SIZE}"
[ -z "$MAG_SIZE" ] && NAME="`./Conf/get_name.sh`"

Tests=TestDir/*

sudo sh -c "/sbin/sysctl -w kernel.panic=3"
sleep 5

for Test in $Tests;
do
	export OUT_FILE=Results/$DATE/`basename $Test`/$NAME
	export repeat=2
	mkdir -p $OUT_FILE
	echo "running $Test"
	./run_test.sh $Test
done
