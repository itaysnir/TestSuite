#./run_single.sh -t ./Tests/hotos/multi_sendfile_tx/
#./run_single.sh -t ./Tests/hotos/multi_sendfile_tx/
#./run_single.sh -t ./Tests/hotos/multi_sendfile_os/
#./run_single.sh -t ./Tests/hotos/multi_sendfile/
#./run_single.sh -t ./Tests/hotos/multi_tcp_bi_single_nic
#./run_single.sh -t ./Tests/hotos/multi_tcp_bi_single_nic_sock0
#./run_single.sh -t ./Tests/hotos/multi_tcp_bi_single_nic_sock0x2
#./run_single.sh -t ./Tests/hotos/multi_tcp_bi_single_nicx2
#./run_single.sh -c -t ./Tests/hotos/multi_rx/
#./run_single.sh -t ./Tests/hotos/multi_rx_remote/

SETUP_NAME='tmp'

function post()
{
	./parse_test.pl
	cd Results/HOTOS/
	pwd
	git add *;
	git commit -a -m"$SETUP_NAME"
	git push
	cd -
	./sock.sh -d
}

function small_kernel()
{
	./sock.sh -d
	export RING=''
	export SOCK_SIZE=''
}

function big_kernel()
{
	export RING=8192
	export SOCK_SIZE=1
}

function no_cache_on()
{
	export TX_CACHE='on'
}

function no_cache_off()
{
	export TX_CACHE='off'
}

function small_user()
{
	export MSG_SIZE='16K'
}

function big_user()
{
	export MSG_SIZE='128M'
}

function show()
{
	echo "NAME: $SETUP_NAME"
	echo "MSG_SIZE=$MSG_SIZE"
	echo "TX_CACHE=$TX_CACHE"
	echo "BIG_SOCK=$SOCK_SIZE"
	echo "RING_SIZE=$RING"
}

cd ..

####################### BIG/BIG ######################################
big_kernel
big_user
#no_cache_on
#export SETUP_NAME=_RBU_RBK_NTC
#show
#./run_single.sh -c -t ./Tests/hotos/multi_sendfile_txos/
#post

no_cache_off
export SETUP_NAME=_RBU_RBK_TC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_txos/
post

no_cache_on
export SETUP_NAME=_LBU_LBK_NTC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_tx/
post

no_cache_off
export SETUP_NAME=_LBU_LBK_TC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_tx/
post

#################### SMALL/BIG ######################################
big_kernel
small_user
no_cache_on
export SETUP_NAME=_RSU_RBK_NTC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_txos/
post

no_cache_off
export SETUP_NAME=_RSU_RBK_TC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_txos/
post

no_cache_on
export SETUP_NAME=_LSU_LBK_NTC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_tx/
post

no_cache_off
export SETUP_NAME=_LSU_LBK_TC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_tx/
post

########################### BIG/SMALL ####################################
small_kernel
big_user
no_cache_on
export SETUP_NAME=_RBU_RSK_NTC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_txos/
post

no_cache_off
export SETUP_NAME=_RBU_RSK_TC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_txos/
post

no_cache_on
export SETUP_NAME=_LBU_LSK_NTC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_tx/
post

no_cache_off
export SETUP_NAME=_LBU_LSK_TC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_tx/
post

########################### SMALL/SMALL ####################################
small_kernel
small_user
no_cache_on
export SETUP_NAME=_RSU_RSK_NTC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_txos/
post

no_cache_off
export SETUP_NAME=_RSU_RSK_TC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_txos/
post

no_cache_on
export SETUP_NAME=_LSU_LSK_NTC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_tx/
post

no_cache_off
export SETUP_NAME=_LSU_LSK_TC
show
./run_single.sh -c -t ./Tests/hotos/multi_sendfile_tx/
post

######################################################################
####################### BIG/BIG ######################################

big_kernel
big_user
no_cache_off
export SETUP_NAME=_RBU_RBK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_rr/
post

export SETUP_NAME=_RBU_LBK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_rlirq/
post

export SETUP_NAME=_LBU_LBK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_ll/
post

export SETUP_NAME=_LBU_RBK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_lrirq/
post

####################### SMALL/BIG ######################################

big_kernel
small_user
no_cache_off
export SETUP_NAME=_RSU_RBK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_rr/
post

export SETUP_NAME=_RSU_LBK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_rlirq/
post

export SETUP_NAME=_LSU_LBK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_ll/
post

export SETUP_NAME=_LSU_RBK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_lrirq/
post

####################### BIG/SMALL ######################################

small_kernel
big_user
no_cache_off
export SETUP_NAME=_RBU_RSK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_rr/
post

export SETUP_NAME=_RBU_LSK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_rlirq/
post

export SETUP_NAME=_LBU_LSK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_ll/
post

export SETUP_NAME=_LBU_RSK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_lrirq/
post

####################### SMALL/SMALL ######################################

small_kernel
small_user
no_cache_off
export SETUP_NAME=_RSU_RSK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_rr/
post

export SETUP_NAME=_RSU_LSK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_rlirq/
post

export SETUP_NAME=_LSU_LSK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_ll/
post

export SETUP_NAME=_LSU_RSK
show
./run_single.sh -c -t ./Tests/hotos/multi_rx_lrirq/
post


