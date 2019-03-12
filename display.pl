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

###################################################33 OUT ##################################
#TODO: Read from cfg file
my @keys = qw(ddr_1 ddr_0 sys_Memory sys_Read sys_Write);


my $idnt = 0;

printf "Headers: $#header\n";
foreach (@header) {
	push @keys, $_ and printf "$_\n" if (/PCIeRdCur/);#|RFO|ItoM/);
	#push @keys, $_ and printf "$_\n" if (/RFO|ItoM/);
	$idnt++;
	printf "$_ ";
	unless ($idnt & 0x3) {
		printf "\n";
	}
}

$idnt = 0;
printf "\noptions: \n";

foreach (sort keys %options) {
	printf "$_ ";
	$idnt++;
	unless ($idnt & 0x3) {
		printf "\n";
	}
}

my @tests = qw(
	tcp_bi_s1_nL_p2 tcp_bi_s1_n2_pR tcp_bi_s1_n2_pT
	tcp_bi_s1_n2_p2
);

printf "\n";

open my $fh, '>', "setup.csv";
printf $fh "test, setup, bandwidth, nic1_tx, nic1_rx, nic0_tx, nic0_rx ";
foreach my $key (@keys) {
	printf $fh ",$key";
}
printf $fh "\n";

#foreach my $test (@tests) {
foreach my $test (sort keys %options) {
	for my $setup (sort keys (%hash)) {
		printf " $test, $setup Undefined!!!\n" and next unless (defined($hash{$setup}{$test}));
		printf $fh "$test, $setup ";

		unless	(defined ($hash{$setup}{$test}{'Total_rx_bytes'})) {
			my @keys = keys $hash{$setup}{$test};
			printf "VALUES not defined";
			printf "@keys\n";
			next;
		}
		printf $fh ", %.2f", $hash{$setup}{$test}{'Total_rx_bytes'}
					+ $hash{$setup}{$test}{'Total_tx_bytes'};

		printf $fh ", %.2f", $hash{$setup}{$test}{'enp130s0f0_tx_bytes'}
					+ $hash{$setup}{$test}{'enp130s0f1_tx_bytes'};
		printf $fh ", %.2f", $hash{$setup}{$test}{'enp130s0f0_rx_bytes'}
					+ $hash{$setup}{$test}{'enp130s0f1_rx_bytes'};
		printf $fh ", %.2f", $hash{$setup}{$test}{'enp4s0f0_tx_bytes'}
					+ $hash{$setup}{$test}{'enp4s0f1_tx_bytes'};
		printf $fh ", %.2f", $hash{$setup}{$test}{'enp4s0f0_rx_bytes'}
					+ $hash{$setup}{$test}{'enp4s0f1_rx_bytes'};

		foreach my $key (@keys) {
			die "wtf?? $key" unless defined($hash{$setup}{$test}{$key});
			my $div = 1;
			$div = 1_000_000 if ($key =~ /RFO|ItoM|PCIeRdCur/);
			$div = 1_000 if ($key =~ /sys_Read|sys_Write|sys_Memory/);
			printf $fh ", %.2f", $hash{$setup}{$test}{$key}/$div;
		}
		printf $fh "\n";
	}
}
close $fh;
