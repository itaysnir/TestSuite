[ -z "$OUT_FILE" ] && OUT_FILE=/tmp

sudo fio `dirname $0`/read.fio > $OUT_FILE/`basename $0`.txt
