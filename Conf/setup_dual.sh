name=`hostname`

if [ "$name" = "dante734" ]; then
	echo "Seting up routes for intrefaces in same subnet"
	ip route add 2.2.2.0/24 dev oct00 src 2.2.2.2 table oct00
	ip route add 2.2.2.0/24 dev oct01 src 2.2.2.3 table oct01

	ip route add table oct00 default via 2.2.2.254 dev oct00
	ip route add table oct01 default via 2.2.2.254 dev oct01

	ip rule add table oct00 from 2.2.2.2
	ip rule add table oct01 from 2.2.2.3

	sysctl net.ipv4.conf.all.arp_filter=1
	sysctl net.ipv4.conf.default.arp_filter=1
	sysctl net.ipv4.conf.all.arp_announce=1
	sysctl net.ipv4.conf.default.arp_announce=1
fi
