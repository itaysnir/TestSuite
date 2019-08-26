#!/usr/bin/perl -w

use strict;

use lib '/homes/markuze/TestSuite/DataCollector/lib/';
use StatCollect;

my $ifs = get_ifs;
my %if_stats = ();

foreach (@{$ifs}) {
	start_ethtool $_;
}
start_proc_cpu;
start_proc_interrupts;
sleep 1;

foreach (@{$ifs}) {
	$if_stats{$_} = stop_ethtool $_;
}
my $cpu = stop_proc_cpu;
my $irq = stop_proc_interrupts;

my $tx_total = 0;
printf "TX:\n";


#	my $stats = $if_stats{$$ifs[0]};
#	foreach (keys(%{$stats})) {
#		printf ">$_<\n";
#	}

foreach (@{$ifs}) {
	my $stats = $if_stats{$_};
	my $tx = $$stats{"tx_bytes"} * 8/(1000 * 1000);
	my $tx_phy = $$stats{"tx_packets"}/(1000 * 1000);
	printf "%-10s: %8.2f Mb/s (%8.2f)Mpps\n", $_, $tx, $tx_phy;
	$tx_total += $tx;
}
printf "TX Total : %8.2f\n", $tx_total;

my $rx_total = 0;
printf "\nRX:\n";

foreach (@{$ifs}) {
	my $stats = $if_stats{$_};
	my $rx = $$stats{"rx_bytes"} * 8/(1000 * 1000);
	my $rx_phy = $$stats{"rx_packets"}/(1000 * 1000);
	printf "%-10s: %8.2f Mb/s (%8.2f)Mpps\n", $_, $rx, $rx_phy;
	$rx_total += $rx;
}
printf "RX Total : %8.2f\n", $rx_total;
printf "\nCombined Total : %8.2f\n\n", $rx_total + $tx_total;

printf "IRQ: %.2f\n", $irq;
#my $util = 0;
#foreach (@{$cpu}) {
#	$util += $_;
#}
printf "CPU util: %3.2f ($#{$cpu})\n", ${$cpu}[0];

draw_mem;
draw_cpu_util $cpu;

