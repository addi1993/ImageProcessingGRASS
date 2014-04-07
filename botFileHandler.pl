#!/usr/bin/perl -w
use strict;
use warnings;
open FILE, 'settings.txt';
my $file_line;
my $output = 0;
my $trainmap = 0;
my $traingroup = 0;
my $etalon = 0;
$file_line = <FILE>;
while (defined ($file_line = <FILE>)) {
        if($file_line=~/OUT:/){
		$output = <FILE>;
		chop($output);
	}
	if($file_line=~/TRAINMAP:/){
		$trainmap = <FILE>;
		chop($trainmap);
	}
	if($file_line=~/TRAINGROUP:/){
		$traingroup = <FILE>;
		chop($traingroup);
	}
	if($file_line=~/ETALONMAP:/){
		$etalon = <FILE>;
		chop($etalon);
	}
}
print $traingroup.','.$trainmap.','.$output.','.$etalon;
close FILE;
