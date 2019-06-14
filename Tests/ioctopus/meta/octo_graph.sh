DT=`date +"%y_%m_%d_%H.%M.%S"`
export DATE="OCTO/$DT/"

tests=Tests/ioctopus/coloc/memc_*

for Test in $tests;
do

#	export SETUP_NAME=""
#	unbuffer ./run_single.sh -c -t $Test
	export SETUP_NAME="_PR"
	BG=1 unbuffer ./run_single.sh  -t $Test
done

