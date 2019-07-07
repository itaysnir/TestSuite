echo "waiting $TIME"
sleep $TIME

cp /tmp/pr.log $OUT_FILE/

echo "killing processes"
sudo pkill netperf
sudo pkill pr
