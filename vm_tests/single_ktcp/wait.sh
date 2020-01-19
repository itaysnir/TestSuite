#!/bin/bash

echo $1
kill -0 $1
while [ "$?" -eq 0 ]; do
	echo "sleeping 5..."
	sleep 5
	kill -0 $1 &> /dev/null
done
