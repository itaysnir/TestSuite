NODE=1 RNODE=0 ./config.sh
sudo ethtool -C $if2 adaptive-rx off rx-usecs 0 rx-frames 0 adaptive-tx off tx-usecs 0 tx-frames 0
ssh $loader1 sudo ethtool -C $dif2 adaptive-rx off rx-usecs 0 rx-frames 0 adaptive-tx off tx-usecs 0 tx-frames 0

core=1 ./test.sh
