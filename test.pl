#!/usr/local/bin/perl -w
use strict;
use blib;

use PDL;
use PDL::Char;
use PDL::NAIF;

use Test::More 'no_plan';

my $s = PDL::Char->new('all_kernels');
PDL::NAIF::furnsh($s);
#my $axis = pdl [0,0,1];
#my $r = zeroes(3,3);
#my $hpi = pdl halfpi();
#axisar($axis,halfpi(),$r);
my $date = PDL::Char->new('2005 Feb 15 06:30:00');
my $et;
PDL::NAIF::utc2et($date,($et = null));
ok($et > 161721064 && $et < 161721065,"et = $et");
my $prec = pdl 0;
my $format = PDL::Char->new('C');
my $ndate = PDL::Char->new('                                ');
#my $ndate = zeroes byte, 32;
PDL::NAIF::et2utc($et,$format,$prec,$ndate);
my $ds = $date->string;
my $ns = $ndate->string;
#
#  Now for all the cleanup required since it's a PDL::Char.
#
$ds =~ s/'//g;
$ds =~ s/\s*$//;
$ds = uc $ds; #et2utc returns upcased dates
$ns =~ s/'//g;
$ns =~ s/\s*$//;
$ns =~ s/\c@//; #get rid of the null that et2utc_c put at the end of the string
ok($ds eq $ns,'et2utc');
my $utc = PDL::Char->new('utc');
my $etmutc;
PDL::NAIF::deltet($et,$utc,($etmutc = null));
ok($etmutc > 64.1 && $etmutc < 64.2,"etmutc = $etmutc");
my $spacecraft = PDL::Char->new("CASSINI");
my ($sc,$found);
PDL::NAIF::bodn2c($spacecraft,($sc = null),($found = null));
ok($found,'Found NAIF ID for Cassini');
ok($sc == -82,"$sc is the correct ID for Cassini");
$found = null;
$spacecraft = PDL::Char->new("XXXXXXXXXXXXXXXXXXX");
PDL::NAIF::bodc2n($sc,$spacecraft,$found);
ok($found,'Found NAIF ID for Cassini');
my $y = $spacecraft->string;
$y =~ m/\'(\w+).*\'/;
$y = $1;
ok($y eq 'CASSINI','Found name from NAIF body id');
$spacecraft = PDL::Char->new("ODD");
PDL::NAIF::bodn2c($spacecraft,($sc = null),($found = null));
ok(!$found,'ODD is not a spacecraft');
$sc = -1492;
PDL::NAIF::boddef($spacecraft,$sc);
$sc = null;
PDL::NAIF::bodn2c($spacecraft,$sc,$found);
ok($found,'Now ODD is a spacecraft');
ok($sc == -1492,'boddef has set the code');
my $end1 = pdl 1.;
my $end2 = pdl 10.;
my $number = pdl -1.;
my $a = PDL::NAIF::brcktd($number,$end1,$end2);
ok($a->sclr == 1.,'brcktd 1');
$number = pdl 29.;
$a = PDL::NAIF::brcktd($number,$end1,$end2);
ok($a->sclr == 10.,'brcktd 2');
$number = pdl 3.;
$end1 = pdl -10.;
$a = PDL::NAIF::brcktd($number,$end1,$end2);
ok($a->sclr == 3.,'brcktd 3');
$end2 = pdl -1.;
$a = PDL::NAIF::brcktd($number,$end1,$end2);
ok($a->sclr == -1.,'brcktd 4');
$number = long -1;
$end1 = long 1;
$end2 = long 10;
$a = PDL::NAIF::brckti($number,$end1,$end2);
ok($a->sclr == 1,'brckti 1');
$number = long 29;
$a = PDL::NAIF::brckti($number,$end1,$end2);
ok($a->sclr == 10,'brckti 2');
$end1 = long -10;
$number = long 3;
$a = PDL::NAIF::brckti($number,$end1,$end2);
ok($a->sclr == 3,'brckti 3');
$end2 = long -1;
$a = PDL::NAIF::brckti($number,$end1,$end2);
ok($a->sclr == -1,'brckti 4');
my $frame = PDL::Char->new("CASSINI_XBAND");
my $reference_frame = PDL::Char->new("J2000");
my $xform = zeroes(6,6);
my $view = pdl [0., 0., 1.];
PDL::NAIF::sxform($frame,$reference_frame,$et + $etmutc,$xform);
ok($xform->at(0,0) == $xform->at(3,3)
   && $xform->at(0,1) == $xform->at(3,4)
   && $xform->at(0,2) == $xform->at(3,5),
   "xform is a state matrix");
ok(!(any $xform > 1),'No element of xform > 1');
my $x = $xform->slice('0:2,0:2')->copy;
my $tx = transpose($x);
my $outx = zeroes(3,3);
PDL::NAIF::mxmg($x,$tx,$outx);
ok($outx->at(0,0) > 0.999999 && $outx->at(0,0) < 1.000001
   && $outx->at(1,1) > 0.999999 && $outx->at(1,1) < 1.000001
   && $outx->at(2,2) > 0.999999 && $outx->at(2,2) < 1.000001
   ,"Matrix and transpose are inverses");
my $vr = ($x x transpose($view));
my $vr2 = zeroes(3);
PDL::NAIF::mxv($x,$view,$vr2);
ok($vr->at(0,0) == $vr2->at(0)
   && $vr->at(0,1) == $vr2->at(1)
   && $vr->at(0,2) == $vr2->at(2),
   'mxv works');
PDL::NAIF::mxvg($x,$view,$vr2);
ok($vr->at(0,0) == $vr2->at(0)
   && $vr->at(0,1) == $vr2->at(1)
   && $vr->at(0,2) == $vr2->at(2),
   'mxvg works');
my $body = 399;
my ($ra, $dec, $w, $lambda);
PDL::NAIF::bodeul($body, $et, ($ra=null), ($dec=null), ($w=null), ($lambda=null));
#print "$ra, $dec, $w, $lambda","\n";
$ra *= PDL::NAIF::dpr();
ok($ra > 359. && $lambda == 0,'bodeul');
my $b = PDL::NAIF::b1900();
ok($b == 2415020.31352,'b1900');
$b = PDL::NAIF::b1950();
ok($b == 2433282.423,'b1950');

