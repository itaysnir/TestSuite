#!/usr/bin/perl -w

use strict;
use autodie;

my $count = 0;
my $i = 0;
my @array = ();

while (<>) {
	chomp;
#	printf "$_\n";
	next unless (/^\s+([\d\.]+)/);
	push @array, $1;
	$count += $1;
	$i++;

}

printf "avg %.2f\n", $count/$i;
my $l1 = 0;
$count = $count/$i;

my $diff;
foreach (@array) {
	 $diff += abs($count -$_);
}
printf "avg l1 %.2f\n", $diff/$i;

