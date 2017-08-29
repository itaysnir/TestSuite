#!/bin/bash

perf=/homes/markuze/copy/tools/perf/perf

function report_functions {
	echo " in report_functions"
	#sudo /homes/markuze/copy/tools/perf/perf report --stdio --max-stack 0 --percent-limit 0.01  >> $OUT_FILE/perf.txt
	sudo cp perf.data $OUT_FILE/
	echo " out report_functions"
}

[ "$collect_functions" == "yes" ] && report_functions
