use Config;
use PDL::Core::Dev;            # Pick up development utilities
use ExtUtils::MakeMaker;

$package = ["NAIF.pp",NAIF,PDL::NAIF];
%hash = pdlpp_stdargs($package);
my $NAIF_include = '/usr/local/naif/C/cspice/include';
$NAIF_include = $ENV{NAIF_INCLUDE} if exists $ENV{NAIF_INCLUDE};
$hash{'INC'} .= qq[ -I$NAIF_include];
#$hash{'VERSION_FROM'} = 'NAIF.pp';
$hash{'VERSION'} = "0.1";
$hash{'PREREQ_PM'} = {PDL => 0,};
my $NAIF_lib = "/usr/local/lib";
$NAIF_lib = $ENV{NAIF_LIB} if exists $ENV{NAIF_LIB};
$hash{'LIBS'} = qq[-L$NAIF_lib -lcspice -lcsupport];

WriteMakefile(%hash);

sub MY::postamble { pdlpp_postamble($package); }
