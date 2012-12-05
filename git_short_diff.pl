#!/usr/bin/perl

use strict;
use Getopt::Long;
my $debug          = 0;
my $PathIn;

Getopt::Long::config('no_ignore_case');
GetOptions(
    'debug'      => \$debug,
    'PathIn=s'     => \$PathIn,
    );
$debug && warn "Path: $PathIn";

my $command = "cd $PathIn && git status -s";
my $result = `$command`;

my $cno = 0;
my $ano = 0;
my $dno = 0;
my $nno = 0;
while($result =~ /([^\n]+)\n?/g){
	my($type, undef) = split(" ", $1);
	if($type eq "A"){ $ano++;}
	if($type eq "M"){ $cno++;}
	if($type eq "D"){ $dno++;}
	if($type eq "??"){ $nno++;}
}

my $return ="";
if($cno > 0){
  $return = "~$cno";
}
if($ano > 0){
  $return = "$return+$ano ";	
}
if($dno > 0){
  $return = "$return-$dno ";	
}
if($nno > 0){
  $return = "$return^$nno ";
}
sub trim($)
{
	my $string = shift;
	$string =~ s/^\s+//;
	$string =~ s/\s+$//;
	return $string;
}
print trim($return);


