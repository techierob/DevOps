use strict;
use warnings;
use Test::More tests => 12;

BEGIN {
    use_ok 'DevOps'
};

my %expected = (
    'LJD-ASQ-LSU-PFTX-067-974' => 1,
    'L3D-ASQ-LSU-PFTX-067-974' => 0, # number at second char
    'NMX-XIE-QKM-PHJL-465-233' => 1,
    'NMX-XIE-QKM-PHJL-465-23'  => 0, # too short
    'YZX-HRA-TUU-WYSV-649-008' => 1,
    'YZX-HRA-TUÜ-WYSV-649-008' => 0, # Umlaut
    'ZAZ-GOK-YYA-JNKS-845-300' => 1,
    'ZAZ-GOK-JNKS-YYA-845-300' => 0, # switch sections 3 and 4
    'WWH-QXP-KXI-KAUL-362-160' => 1,
    'WWH-QXP-KXI_KAUL-362-160' => 0, # '_' instead of '-'
    undef                      => 0, # undefined value
);

for my $code ( keys(%expected) ) {
    if ( $expected{$code} ) {
        ok( DevOps->validateCode($code) );
    }
    else {
        ok( !DevOps->validateCode($code) );
    }
}

done_testing();
