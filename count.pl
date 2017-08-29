#!/usr/bin/perl -w

use strict;
use autodie;

my $count = 0;

while (<>) {
	chomp;
	printf "$_\n";
	$count += $1 if (/^\s+([\d\.]+)%/);
}

printf "Count $count\n";
