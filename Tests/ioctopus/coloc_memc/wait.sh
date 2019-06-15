echo "waiting $TIME"
sleep $TIME

cp /tmp/pr.log $OUT_FILE/

echo "killing processes"
ssh $loader1 sudo pkill memaslap
sudo pkill netperf
sudo pkill pr
