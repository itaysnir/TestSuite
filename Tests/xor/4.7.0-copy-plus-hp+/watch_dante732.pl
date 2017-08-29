#!/usr/bin/perl -w

use strict;

use lib '/home/markuze/Workshop/DAMN_binic/';
use StatCollect;

#start_ethtool "enp130s0f0";
#start_ethtool "enp130s0f1";
#start_ethtool "enp4s0f0";
#start_ethtool "enp4s0f1";
start_proc_cpu;
qx(sudo insmod *.ko);
qx(./netperf);

my $util_ref = stop_proc_cpu;
draw_cpu_util $util_ref;
#printf "cpu : @{$util_ref}\n";
my $cpu = 0;
for (@{$util_ref}) {
	$cpu += $_;
}

printf "CPU util: %2.2f\n", $cpu/28;
