#!/usr/bin/perl
use strict;
no warnings qw ( uninitialized );
binmode STDOUT, ":utf8";

# for changing line to column format
# written by Ye Kyaw Thu, NICT, Japan
# last updated: 26 Oct 2016
# how to use: perl ./ch2col2.pl <input-filename>

open (inputFILE,"<:encoding(utf8)", $ARGV[0]) or die "Couldn't open input file $ARGV[0]!, $!\n";

my $line;

while ($line = <inputFILE>)
{
   chomp($line);

   # just for ver1
   # $line =~ s/\s+([a-zA-z])/\/$1/;

   # for ver1 and ver2
   $line =~ s/\s+([\x{0250}-\x{02AF}\x{03B8}\x{00F0}\x{014B}a-zA-z])/\/$1/;

   print "$line\n";
}

close (inputFILE);

