cd `dirname $0`
[ -e "./config.sh" ] && source ./config.sh

[ -z "$NTUPLE" ] && NTUPLE='on'
sudo wrmsr -p 0 0x620 0x1d1d

function die
{
	echo "$@"
	exit -1;
}

function ex
{
	echo "$@"
	$@
}

sudo sh -c "echo 32768 > /proc/sys/net/core/rps_sock_flow_entries"

for i in `seq 1 6`;
do
	name="if$i"
	eval if=\$$name;
	name="ip$i"
	eval ip=\$$name;

	if [ ! -z "$if" ]; then
		[ -z "$ip" ] && die "ERROR: echo ip$i ($ip) not configured for $if"

		echo "sudo ethtool -K $if ntuple $NTUPLE"
		sudo ethtool -K $if ntuple $NTUPLE

		for f in /sys/class/net/$if/queues/rx-*/rps_flow_cnt; do sudo sh -c "echo 32768 > $f"; done
	fi
done

function setup_peers {

	if [ ! -z "$loader1" ]; then
		ex ssh $loader1 sudo ethtool -K $dif1 ntuple $NTUPLE
		ex ssh $loader1 sudo ethtool -K $dif2 ntuple $NTUPLE
		ex ssh $loader1 "echo 32768 | sudo tee /proc/sys/net/core/rps_sock_flow_entries"
		ex ssh $loader1 "for f in /sys/class/net/$dif1/queues/rx-*/rps_flow_cnt; do echo 32768 | sudo tee \$f; done"
		ex ssh $loader1 "for f in /sys/class/net/$dif2/queues/rx-*/rps_flow_cnt; do echo 32768 | sudo tee \$f; done"
	fi

	if [ ! -z "$loader2" ]; then
		ssh $loader2 sudo ethtool -K $dif2 ntuple $NTUPLE

		ssh $loader2 "echo 32768 | sudo tee /proc/sys/net/core/rps_sock_flow_entries"
		ssh $loader2 "for f in /sys/class/net/$dif2/queues/rx-*/rps_flow_cnt; do echo 32768 | sudo tee $f; done"
	fi
}

setup_peers
