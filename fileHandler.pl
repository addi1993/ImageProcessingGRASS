#!/usr/bin/perl -w
use strict;
use warnings;
open FILE, 'settings.txt';
my $inrast = 1;
my $file_line;
$file_line = <FILE>;
while (defined ($file_line = <FILE>)&&$inrast) {
        if($file_line=~/OUT:/){
		$inrast=0;
	}
	else{
		chop($file_line);
		$file_line=$file_line.', ';
		print $file_line;
	}	
}
close FILE;
