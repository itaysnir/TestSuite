#!/usr/bin/perl -w

use warnings;
use strict;
use autodie;
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

sub bytes2gbs {
	my $byte = shift;
	return ($byte * 8)/(1000 * 1000 * 1000);
}

my @nop  = ();

sub nop {
	my $file = shift;
	printf "$file\n";

	return \@nop, \@nop;
}

sub result_parser {
	my $file = shift;
	my %tmp;
	printf "$file\n";

	open (my $fh, '<', $file);
	foreach (<$fh>) {
		chomp;
		next unless /^(\w+)\s*:\s*([\d\.]+)$/;

		# Noise dure to combinded output
		next if /^Socket\d/;
		next if /^delay_ms/;
		my $key = $1;
		my $val = $2;
		$val = bytes2gbs($val) if ($key =~ /bytes/);
		push @{$tmp{$key}}, $val;
	}
	close ($fh);
	return hash2csv \%tmp;
}

sub pcm_parser {
	my $file = shift;
	my %tmp;
	printf "$file\n";

	my @header = ();
	my $parse = 0;

	open (my $fh, '<', $file);
	foreach (<$fh>) {
		chomp;
		next unless /Core|SKT|TOTAL/;

		if (/Core/) {
			$parse = 1;
			@header = split /\s\|\s/;
			#printf "$#header: @header\n";
			next;
		}
		next unless ($parse);
		if (/TOTAL/) {
			$parse = 0 ;
			next;
		}
		my @line = split /\s{2,}/;
		#printf "$#line: @line\n";
		for (my $i = 2; $i <= $#line; $i++) {
			my $key = "s$line[1]";
			$key = "${key}_$header[$i -1]";
			$key =~ s/\s//g;
			push @{$tmp{$key}}, str2num($line[$i]);
		}
	}
	close ($fh);
	return hash2csv \%tmp;
}

sub power_parser {
	my $file = shift;
	my %tmp;
	printf "$file\n";
	open (my $fh, '<', $file);
	foreach (<$fh>) {
		chomp;
		next unless (/Consumed/);
		my $key = 'total';
		$key = 'dram' if (/DRAM/);
		my @line = split /;/, $_;
		#printf "$#line: @line\n";
		$key = "$line[0]_$key";
		for (my $i = 1; $i <= $#line; $i++) {
			#printf "$line[$i]\n";
			$line[$i] =~ /(\w+)\s*:\s*([\d\.]+)/g;
			#printf "${key}_$1 => $2\n";
			push @{$tmp{"${key}_$1"}}, $2;
		}
	}
	close ($fh);
	return hash2csv \%tmp;
}

sub pcie_csv_parser {
	my $file = shift;
	my %tmp;
	printf "$file\n";
	open (my $fh, '<', $file);

	my @ops = ();

	foreach (<$fh>) {
		chomp;
		if (/^type/) {
			@ops = split /,/, $_;
			#printf "[$#ops] @ops\n";
			next;
		}
		my @vals = split /,/;
		my $type = $vals[0];
		my $skt = $vals[1];
		for (my $i = 2; $i <= $#vals; $i++) {
			my $key = "${skt}_${type}_$ops[$i]";
			#printf "$key => $vals[$i]\n";
			push 	@{$tmp{$key}}, str2num $vals[$i];
		}
	}
	close ($fh);
	return hash2csv \%tmp;
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
	'pcm.txt' => \&pcm_parser,
	'pcie.txt' => \&pcie_parser,
	'pcie_csv.txt' => \&pcie_csv_parser,
	'power.txt' => \&power_parser,
	'result.txt' => \&result_parser,
	'result_pcm.txt' => \&nop,
	'test_raw.txt' => \&nop, #TODO: collect RPS on memcached
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
	#printf "> title: @title\n";
	#printf "> val :@csv\n";
	return \@title, \@csv;
}

my $otitle;
sub parse_test {
	my $fh = shift;
	my $dir = shift;
	my $name = shift;
	my $test = basename($dir);
	my $csv;
	my $title;

	printf "$dir: %s\n", (-d $_) ? "DIR": "FILE";
	for (glob($dir."/*")) {
		my $kern = basename($_);
		#printf "($test)$kern\n" if (-d $_);
		($title, $csv) = parse_result_files $_;
		#my $t = validate_title ($otitle, $title);
		unless (defined ($otitle)) {
			print $fh "name,test,";
			foreach (@{$title}) {
				printf $fh "$_,";
			}
			printf $fh "\n";
			$otitle = \$title;
		}
		print $fh "$name,$test,";
		foreach (@{$csv}) {
			printf $fh "$_,";
		}
		printf $fh "\n";
	}
}

sub parse_dir {
	my $dir = shift;
	my $name = basename ($dir);
	printf "setup: $name\n";

	open my $fh, '>', "$name.csv";
	for (glob($dir."/*")) {
		next unless (-d $_);
		parse_test $fh, $_, $name;
	}
	close $fh;
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
