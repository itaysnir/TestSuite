export DATE="OCTO/memc_256/"


export TAIL_DELAY=10
confs=Tests/ioctopus/memc_tests/conf/*
test_dir=Tests/ioctopus/memc_tests/memc_single

for msg in $confs;
do
	cp $msg $test_dir/conf.memc
	msg=`basename $msg`
	export core=0
	export NODE=0
	echo "$msg"
	export SETUP_NAME="l_$msg"
	./run_single.sh -c -t $test_dir
	export SETUP_NAME="r_$msg"
	export core=1
	export NODE=1
	./run_single.sh -t $test_dir
done

