for dir in ./tcp_*; do
	echo $dir
	cd $dir
	./config.sh > /dev/null
	TIME=15 ./test.sh
	cd -
done
