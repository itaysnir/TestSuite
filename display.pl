#!/usr/bin/perl -w

use warnings;
use strict;
use autodie;
use Getopt::Std;

my %opts = ();

getopts('d:n:', \%opts);

sub usage {
        die "$0 -d <list of Dirs to parse, separated by ','> -n <coinfig name>\n";
}

usage() unless (defined($opts{'d'}));

my %hash = ();
my @header = ();

sub parse_csv {
	my $file = shift;

	printf "reading $file\n";
	open my $fh, '<', $file;
	my $header = <$fh>;
	@header = split /,/,$header;
	printf "[$#header]$header\n";
	while (<$fh>) {
		my @line = split /,/,$_;
		for (my $i = 2; $i <= $#header; $i++) {
			$hash{$line[0]}{$line[1]}{$header[$i]} = $line[$i];
			if ($header[$i] =~ /Total_[rt]x_bytes/) {
				printf "$line[0]:$line[1]:$header[$i] => $line[$i]\n";
			}
		}
	}
	close $fh;
}

for (split (/,/, $opts{'d'})) {
        next unless ( -e $_);
        printf "Parsing: $_\n";
        parse_csv ($_);
}
