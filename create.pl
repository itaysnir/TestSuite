#!/usr/bin/perl -w

use warnings;
use strict;
use autodie;
use Getopt::Std;
use Regexp::Common;

#printf "$0 $ARGV[0]\n";
my $mult = 16;

if (defined($ARGV[0])) {
	die "ERROR: $ARGV[0] is not a number\n" unless $ARGV[0] =~ / ^$RE{num}{int}$/x;
	$mult = $ARGV[0];
}

my $val_size=1024 * $mult;
my $val_name="${mult}K";
my $key_size=128;
my %opts = ();

sub create_file {
	my ($set, $get) = @_;
	#my $name = "${set}${get}_$val_name";
	my $name = "${set}${get}";
	$set /= 10;
	$get /= 10;
	open my $fh, '>', $name;
	print $fh "key\n";
	print $fh "$key_size $key_size 1\n";
	print $fh "\n";
	print $fh "value\n";
	print $fh "$val_size $val_size 1\n";
	print $fh "\n";
	print $fh "cmd\n";
	print $fh "0 $set\n";
	print $fh "1 $get\n";
	close $fh;
}

for (my $i = 0; $i <= 10; $i++) {
	create_file $i, (10-$i);
}
