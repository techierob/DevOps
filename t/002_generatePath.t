use strict;
use warnings;
use Test::More tests => 12;

BEGIN {
    use_ok 'DevOps'
};

my %expected = (
    'NTN-TYE-QAS-EPPH-730-340' => [ qw(TYE QAS EPPH NTN-TYE-QAS-EPPH-730-340.mov) ],
    'N9N-TYE-QAS-EPPH-730-340' => [], # number at second char
    'SAC-LDB-ZSU-ZEWH-290-666' => [ qw(LDB ZSU ZEWH SAC-LDB-ZSU-ZEWH-290-666.mov) ],
    'SAC-LDB-ZSU-ZEWH-290-66'  => [], # too short
    'TLE-HBE-YST-KOFU-628-766' => [ qw(HBE YST KOFU TLE-HBE-YST-KOFU-628-766.mov) ],
    'TLE-HBE-YST-KOFÜ-628-766' => [], # Umlaut
    'JJX-OSL-EII-HTXM-193-517' => [ qw(OSL EII HTXM JJX-OSL-EII-HTXM-193-517.mov) ],
    'JJX-OSL-HTXM-EII-193-517' => [], # switch sections 3 and 4
    'IBA-CUG-IWR-ASIA-951-567' => [ qw(CUG IWR ASIA IBA-CUG-IWR-ASIA-951-567.mov) ],
    'IBA-CUG-IWR_ASIA-951-567' => [], # '_' instead of '-'
    undef                      => [], # undefined value
);

my $parser = DevOps->new();
for my $code ( keys(%expected) ) {
    my @got = $parser->generatePath( $code );
    ok( eq_array(\@got, $expected{$code}) );
}

done_testing();
