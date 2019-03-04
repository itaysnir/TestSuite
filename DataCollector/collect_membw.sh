#!/bin/bash

perf=/homes/markuze/copy/tools/perf/perf
pcm=/homes/markuze/pcm/
time=5

echo "<$OUT_FILE>"
function collect_cpu {
	`dirname $0`/collect_net_cpu.pl &
}

function collect_mem_bw {
	echo " in collect mem bw" >&2
	$pcm/pcm-memory.x 1 -- sleep $time | tee -a $OUT_FILE/memory.txt
	echo " out collect mem bw" >&2
}

function collect_pcm {
	echo " in collect pcm" >&2
	$pcm/pcm-pcie.x 1 -csv=/tmp/pcie_csv.txt -- sleep $time #| tee -a $OUT_FILE/pcie.txt
	mv /tmp/pcie_csv.txt $OUT_FILE
	$pcm/pcm-latency.x -- sleep $time| tee -a $OUT_FILE/latency.txt
	$pcm/pcm-power.x -- sleep $time| tee -a $OUT_FILE/power.txt
	$pcm/pcm.x 1 -- sleep $time| tee -a $OUT_FILE/pcm.txt
	echo " out collect pcm" >&2
}

[ "$collect_cpu" != "no" ] && collect_cpu
[ "$collect_mem_bw" != "no" ] && collect_mem_bw
[ "$collect_pcm" != "no" ] && collect_pcm

echo "Data collected"
