for dir in ./tcp_bi*; do
	echo $dir
	tx="${dir/bi/tx}";
	cp -r $dir $tx
	sed -i 's/TCP_MAERTS/TCP_STREAM/g' $tx/test.sh

	rx="${dir/bi/rx}";
	cp -r $dir $rx
	sed -i 's/TCP_STREAM/TCP_MAERTS/g' $rx/test.sh
done
