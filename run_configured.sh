#!/bin/bash

cd `dirname $0`

[ -z "$DATE" ] && DATE=`date +"%y_%m_%d_%H.%M.%S"`
[ -z "$DATE" ] && DATE=TMP

source ./Conf/config.sh
./Conf/setup.sh

NAME="`./Conf/get_name.sh`_${SETUP_NAME}"
[ -z "$SETUP_NAME" ] && NAME="`./Conf/get_name.sh`"

Tests=Tests/ioctopus/*/

sudo sh -c "/sbin/sysctl -w kernel.panic=3"
sleep 5

for Test in $Tests;
do
	export OUT_FILE=Results/$DATE/`basename $Test`/$NAME
	export repeat=5
	mkdir -p $OUT_FILE
	echo "running $Test"
	./run_test.sh $Test
done
