export DATE="OCTO/base_cx5/"

export MSG_SIZE='64K'

export SETUP_NAME="ll"
export core=0
export NODE=0
export rcore=0
export RNODE=0
date
echo "$SETUP_NAME"
./run_single.sh -t ./Tests/ioctopus/single_tcp_tx

export SETUP_NAME="lr"
export core=0
export NODE=0
export rcore=1
export RNODE=1
date
echo "$SETUP_NAME"
./run_single.sh -t ./Tests/ioctopus/single_tcp_tx

exit

export SETUP_NAME="rr"
export core=1
export NODE=1
export rcore=1
export RNODE=1
echo "$SETUP_NAME"
./run_single.sh -t ./Tests/ioctopus/single_tcp_tx

export SETUP_NAME="rl"
export core=1
export NODE=1
export rcore=0
export RNODE=0
echo "$SETUP_NAME"
./run_single.sh -t ./Tests/ioctopus/single_tcp_tx




export SETUP_NAME="ll"
export core=0
export NODE=0
export rcore=0
export RNODE=0
echo "$SETUP_NAME"
./run_single.sh -t ./Tests/ioctopus/single_tcp_rx

export SETUP_NAME="lr"
export core=0
export NODE=0
export rcore=1
export RNODE=1
echo "$SETUP_NAME"
./run_single.sh -t ./Tests/ioctopus/single_tcp_rx

export SETUP_NAME="rr"
export core=1
export NODE=1
export rcore=1
export RNODE=1
echo "$SETUP_NAME"
./run_single.sh -t ./Tests/ioctopus/single_tcp_rx

export SETUP_NAME="rl"
export core=1
export NODE=1
export rcore=0
export RNODE=0
echo "$SETUP_NAME"
./run_single.sh -t ./Tests/ioctopus/single_tcp_rx


