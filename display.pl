#!/usr/bin/perl -w

use warnings;
use strict;
use autodie;
use Getopt::Std;

my %opts = ();

getopts('d:n:', \%opts);

sub usage {
        die "$0 -d <list of csvs to parse, separated by ','> -n <coinfig name>\n";
}

usage() unless (defined($opts{'d'}));

my %hash = ();
my @header = ();
my %tests = ();
my %options = ();

my $__setup = 0;
my $__kernel = 1;
my $__test = 2;
sub parse_csv {
	my $file = shift;

	printf "reading $file\n";
	open my $fh, '<', $file;
	my $header = <$fh>;
	@header = split /,/,$header;
#	printf "[$#header]$header\n";
	while (<$fh>) {
		my @line = split /,/,$_;
		$options{$line[$__test]} = undef;
		for (my $i = 3; $i <= $#header; $i++) {
			my $kernel = $line[$__kernel];
			$kernel =~ s/unsafe//g;
			$kernel =~ s/5.1.12//g;
			$kernel = "vanila" if ($kernel eq "-");
			$kernel =~ s/-/ /g;
			$hash{$kernel}{$line[$__test]}{$header[$i]} = $line[$i];
			#if ($header[$i] =~ /Total_[rt]x_bytes/) {
			#	printf "$line[0]:$line[1]:$header[$i] => $line[$i]\n";
			#}
		}
	}
	close $fh;
}

for (split (/,/, $opts{'d'})) {
        next unless ( -e $_);
        printf "Parsing: $_\n";
        parse_csv ($_);
}
my $idnt = 0;

printf "Headers: $#header\n";
foreach (@header) {
	printf "$_ ";
	$idnt++;
	unless ($idnt & 0x3) {
		printf "\n";
	}
}

my @keys = qw(
	  sys_Memory sys_Read sys_Write Total_rx_bytes Total_tx_bytes Total_rx_packets Total_tx_packets
);


$idnt = 0;
printf "\noptions: \n";

foreach (sort keys %options) {
	printf "$_ ";
	$idnt++;
	unless ($idnt & 0x3) {
		printf "\n";
	}
}

printf "\n";

open my $fh, '>', "setup.csv";
printf $fh "test,setup,bandwidth,cpu";
foreach my $key (@keys) {
	printf $fh ",$key";
}
printf $fh "\n";

foreach my $test (sort keys %options) {
	for my $setup (sort keys (%hash)) {
		printf $fh "$test, $setup ";
		printf " Undefined!!!" unless (defined($hash{$setup}{$test}));
		printf $fh ", %.2f", $hash{$setup}{$test}{'Total_rx_bytes'}
					+ $hash{$setup}{$test}{'Total_tx_bytes'};
		printf $fh ", %.2f", $hash{$setup}{$test}{'cpu_total'};
		foreach my $key (@keys) {
		#	next unless defined  ($hash{$setup}{$test}{$key});
			printf $fh ", %.2f", $hash{$setup}{$test}{$key};
		}
		printf $fh "\n";
	}
}
close $fh;
