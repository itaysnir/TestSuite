#!/usr/bin/perl -w

use strict;

my $sum = 0;
while (<>) {
	if (/TPS: (\d+)/) {
#		printf "$1\n";
		$sum += $1;
	}
}

printf "%.2f Units/s\n", $sum;
