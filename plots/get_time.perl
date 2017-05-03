#!/bin/perl

use strict;

# use Math::Int64 qw(int64);
use bigint;

my $floatmatch = qr/[+-]?\d*(\.\d+)?([eE][+-]?\d+)?/;

my @monthdays = ( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );

my $line = 0;
# my $start = int64(0);
my $start = 0;
my $interval = 1;
while ( <> ) {
	s/^\s+//;
	s/\s+$//;

	if (m/^I(\d{2})(\d{2}) (\d+):(\d+):(\d+)\.(\d+) +(\d+) (.*)$/) {
		my $month = $1;
		my $monthday = $2;
		my $hour = $3;
		my $minute = $4;
		my $second = $5;
		my $us = $6;
		my $pid = $7;
		my $rest = $8;

        # my $ts = int64($second + $minute * 60 + $hour * 3600 + ($monthdays[$month - 1] + $monthday - 1) * 3600 * 24);
		my $ts = ($second + $minute * 60 + $hour * 3600 + ($monthdays[$month - 1] + $monthday - 1) * 3600 * 24);
		$ts = $ts * 1000000 + $us;
		if ($line eq 0) {
			$start = $ts;
		} else {
			$ts -= $start;
		}

		# print "ts $ts rest $rest\n";

		if ($rest =~ m/.* ppx\[(\d+)\] = ($floatmatch)$/) {
			my $istep = $1;
			# $istep *= $interval;
			my $perpl = $2;

			printf("%g %d %s\n", ($ts / 1000000.0), $istep, $perpl);
		} elsif ($rest =~ m/.* -i (\d+) .*$/) {
			$interval = $1;
		}
	} else {
		# print "NO: $_\n";
	}

	++$line;
}
