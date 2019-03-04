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
my %options = ();

sub parse_csv {
	my $file = shift;

	printf "reading $file\n";
	open my $fh, '<', $file;
	my $header = <$fh>;
	@header = split /,/,$header;
#	printf "[$#header]$header\n";
	while (<$fh>) {
		my @line = split /,/,$_;
		$options{$line[1]} = undef;
		for (my $i = 2; $i <= $#header; $i++) {
			$hash{$line[0]}{$line[1]}{$header[$i]} = $line[$i];
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

$idnt = 0;
foreach (sort keys %options) {
	printf "$_ ";
	$idnt++;
	unless ($idnt & 0x3) {
		printf "\n";
	}
}
my @keys = qw(
	sys_Memory cpu_total sys_Read sys_Write Total_rx_bytes Total_tx_bytes 
);

my @tests = qw(
	tcp_bi_s1_nL_p2 tcp_bi_s1_n2_pR tcp_bi_s1_n2_pT 
	tcp_bi_s1_n2_p2
);

printf "\n";
	
open my $fh, '>', "setup.csv";
printf $fh "test, setup, bandwidth ";	
foreach my $key (@keys) {
printf $fh ",$key";
}
printf $fh "\n";

foreach my $test (@tests) {
	for my $setup (sort keys (%hash)) {
		printf $fh "$test, $setup ";
		printf " Undefined!!!" unless (defined($hash{$setup}{$test}));
		printf $fh ", %.2f", $hash{$setup}{$test}{'Total_rx_bytes'} 
					+ $hash{$setup}{$test}{'Total_tx_bytes'};
		foreach my $key (@keys) {
		#	next unless defined  ($hash{$setup}{$test}{$key});
			printf $fh ", %.2f", $hash{$setup}{$test}{$key};
		}
		printf $fh "\n";
	}
}
close $fh;
