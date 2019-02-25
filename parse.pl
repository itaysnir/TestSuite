#!/usr/bin/perl -w

use warnings;
use strict;
use Getopt::Std;
use List::Util qw(sum);
use File::Basename;

use File::stat;
use File::Grep qw (fgrep);
use Cwd 'abs_path';
use Switch;

###################### MOVE TO .pm ########################
#<Name>,Test Name, kernel,
my @csv = ("Test", "Kernel");

sub latency_parser {
	my $file = shift;
	my $access;

	my %tmp;
	printf "$file\n";
	open (my $fh, '<', $file);

	foreach (<$fh>) {
		#while (/(Core\d+:\s+\d+\.\d+)/g) {
		#	printf "$1\n";
		#}

		$access = 'l1' and next if (/^L1/);
		$access = 'ddr' and next if (/^DDR/);

			chomp;
		if (/^Socket(\d): (\d+\.\d+)/) {
			#printf " $access>$_ [$1:$2]\n";
			push @{$tmp{"${access}_$1"}}, $2;
		}
	}
	close ($fh);

	my @csv = ();
	my @title = ();
	foreach (sort keys %tmp) {
		my $avg = sum(@{$tmp{$_}})/@{$tmp{$_}};
		printf "$_: %.2f\n", $avg;
		push @title, $_;
		push @csv, $avg;
	}
	return \@csv, \@title;
}

my %parser = (
	'latency.txt' => \&latency_parser,
);

sub parse_result_files {
	my $dir = shift;
	my @csv = ();
	my @title = ();

	for (sort glob($dir."/*")) {
		my $file = basename($_);

		if (defined($parser{$file})) {
			my ($title, $csv) = $parser{$file}->($_);
			push @csv, @{$csv};
			push @title, @{$title};
		}
	}
	printf "@title\n";
	printf "@csv\n";
}

sub parse_test {
	my $dir = shift;
	my $test = basename($dir);

	for (glob($dir."/*")) {
		my $kern = basename($_);
		#printf "($test)$kern\n" if (-d $_);
		parse_result_files $_;
	}
}

sub parse_dir {
	my $dir = shift;
	for (glob($dir."/*")) {
		#printf "$_\n";
		parse_test $_ if (-d $_);
	}
}

#################### MAIN ##################################

my %opts = ();

getopts('d:n:', \%opts);

sub usage {
	die "$0 -d <list of Dirs to parse, separated by ','> -n <coinfig name>\n";
}

usage() unless (defined($opts{'d'}));
my $OUT_DIR="/homes/markuze/plots/membw";
$OUT_DIR = $opts{'-o'} if (defined($opts{'-o'}));

printf "Name $opts{'n'}\n" if (defined($opts{'n'}));
unshift @csv, $opts{'n'} if (defined($opts{'n'}));

for (split (/,/, $opts{'d'})) {
	next unless ( -d $_);
	printf "Parsing: $_\n";
	parse_dir ($_);
}

for (keys (%parser)) { printf "$_\n"};
for (@csv) { printf "$_\n"};
