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
my $mood=$ARGV[1];

while ($line = <inputFILE>)
{
   chomp($line);
   #my $gra =""; my $pho = "";
   #($gra, $pho) = split("\s", $line);
   my @word_tag = split('/', $line);

   if ($mood eq "w")
   {
      print "$word_tag[0]\n";}
   elsif ($mood eq "t")
   {
      print "$word_tag[1]\n";}
   elsif ($mood eq "p")
   {
      my @char = split(' ', $word_tag[0]);
      print "$word_tag[0]\/";
      for my $i (0 .. scalar @char) {
         print "? ";
      }
      print "\n";
   }
}

close (inputFILE);