#!/bin/bash

cd `dirname $0`

#parse
$BASE_EVAL_DIR/common_script/parse_raw.pl $RES_DIR > raw.dat #2>/dev/null

#plot
make
rm -rf *.eps
mv *.pdf $PLOT_OUT_DIR
