#!/usr/bin/perl -w

use strict;

use lib '/home/markuze/Workshop/DAMN_binic/';
use StatCollect;

start_ethtool "enp130s0f0";
start_ethtool "enp130s0f1";
start_ethtool "enp4s0f0";
start_ethtool "enp4s0f1";
start_proc_cpu;
sleep 1;


my $p1p2 = stop_ethtool "enp130s0f0";
my $p1p1 = stop_ethtool "enp130s0f1";
my $p2p2 = stop_ethtool "enp4s0f0";
my $p2p1 = stop_ethtool "enp4s0f1";

my $tx_total = 0;
printf "TX\n";
printf "p1p1 : %8.2f Mb/s\n", ($$p1p1{"tx_bytes"} * 8)/(1000 * 1000);
printf "p1p2 : %8.2f Mb/s\n", ($$p1p2{"tx_bytes"} * 8)/(1000 * 1000);
printf "p2p1 : %8.2f Mb/s\n", ($$p2p1{"tx_bytes"} * 8)/(1000 * 1000);
printf "p2p2 : %8.2f Mb/s\n", ($$p2p2{"tx_bytes"} * 8)/(1000 * 1000);
$tx_total  = ($$p1p1{"tx_bytes"} + $$p1p2{"tx_bytes"} + $$p2p1{"tx_bytes"} + $$p2p2{"tx_bytes"});
$tx_total = ($tx_total * 8)/(1000 * 1000);
printf "TX Total: %8.2f\n",$tx_total;

my $rx_total = 0;
printf "RX\n";
printf "p1p1 : %8.2f Mb/s\n", ($$p1p1{"rx_bytes"} * 8)/(1000 * 1000);
printf "p1p2 : %8.2f Mb/s\n", ($$p1p2{"rx_bytes"} * 8)/(1000 * 1000);
printf "p2p1 : %8.2f Mb/s\n", ($$p2p1{"rx_bytes"} * 8)/(1000 * 1000);
printf "p2p2 : %8.2f Mb/s\n", ($$p2p2{"rx_bytes"} * 8)/(1000 * 1000);
$rx_total  = ($$p1p1{"rx_bytes"} + $$p1p2{"rx_bytes"} + $$p2p1{"rx_bytes"} + $$p2p2{"rx_bytes"});
$rx_total = ($rx_total * 8)/(1000 * 1000);
printf "RX Total: %8.2f\n", $rx_total;
printf "Combined Total: %8.2f\n", $rx_total + $tx_total;

my $util_ref = stop_proc_cpu;
draw_cpu_util $util_ref;
#printf "cpu : @{$util_ref}\n";
my $cpu = 0;
for (@{$util_ref}) {
	$cpu += $_;
}

printf "CPU util: %2.2f\n", $cpu/28;
