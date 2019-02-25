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
sub hash2csv {
	my $tmp = shift;
	my @csv = ();
	my @title = ();
	foreach (sort keys %{$tmp}) {
		my $avg = sum(@{${$tmp}{$_}})/@{${$tmp}{$_}};
		#printf "$_: %.2f\n", $avg;
		push @title, $_;
		push @csv, $avg;
	}
	return \@csv, \@title;
}

sub str2num {
	my @num = split /\s/, shift;
	#printf "$#num: @num\n";
	return $num[0] if ($#num == 0);
	switch ($num[1]) {
		case 'M' {return $num[0] * 1_000_000}
		case 'K' {return $num[0] * 1_000}
		else {die "$_ impossible switch...\n"}
	}
}

sub pcie_parser {
	my $file = shift;
	my %tmp;
	printf "$file\n";
	open (my $fh, '<', $file);

	my @ops = ();

	foreach (<$fh>) {
		chomp;
		if (/^Skt/) {
			@ops = split /\s+\|\s+/, $_;
			#printf "[$#ops] @ops\n";
			next;
		}
		next unless /^\s/;
		my @vals = split /\s{2,}/;
		#printf "[$#vals] @vals\n";
		my $skt = $vals[0];
		$skt = 'sys' unless ($vals[0] =~ /\d+/);
		for (my $i = 1; $i <= $#vals; $i++) {
			my $key = "${skt}_$ops[$i]";
			push 	@{$tmp{$key}}, str2num $vals[$i];
		}
	}
	close ($fh);
	return hash2csv \%tmp;
}

sub memory_parser {
	my $file = shift;
	my %tmp;
	printf "$file\n";
	open (my $fh, '<', $file);
	foreach (<$fh>) {
		chomp;
		if (/NODE\s+\d/) {
			#printf "Per node: $_\n ";
			while (/NODE\s+(\d)\s+([\w\s\.]+)\(\D+([\d\.]+)/g) {
				#printf "Node $1 : OP $2 Val $3\n";
				my $key = "node_$1_$2";
				my $val = $3;
				$key =~ s/\s/_/g;
				push @{$tmp{$key}}, $val;
			}
			next;
		}
		if (/System/) {
			#printf "Per sys: $_\n ";
			/System\s+(\w+)\D+([\d\.]+)/g;
			#printf "Sys $1 : $2\n";
			my $key = "sys_$1";
			push @{$tmp{$key}}, $2;
			next;
		}
	}
	close ($fh);
	return hash2csv \%tmp;
}

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

	return hash2csv \%tmp;
}

my %parser = (
	'latency.txt' => \&latency_parser,
	'memory.txt' => \&memory_parser,
	'pcie.txt' => \&pcie_parser,
);

sub parse_result_files {
	my $dir = shift;
	my @csv = ();
	my @title = ();

	for (sort glob($dir."/*")) {
		my $file = basename($_);

		if (defined($parser{$file})) {
			my ($csv, $title) = $parser{$file}->($_);
			push @csv, @{$csv};
			push @title, @{$title};
		} else {
			printf "Parser not configured $file\n";
		}
	}
	printf "> title: @title\n";
	printf "> val :@csv\n";
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
