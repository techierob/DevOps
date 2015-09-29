use strict;
use warnings;
use Test::More tests => 12;

BEGIN {
    use_ok 'DevOps'
};

my %expected = (
    'YZU-XJS-BGG-NSYE-807-917' => 'XJS/BGG/NSYE/',
    'Y2U-XJS-BGG-NSYE-807-917' => undef, # number at second char
    'GUJ-LCT-UPL-CDGX-588-383' => 'LCT/UPL/CDGX/',
    'GUJ-LCT-UPL-CDGX-588-38'  => undef, # too short
    'HON-FWK-IUV-ZDOT-790-472' => 'FWK/IUV/ZDOT/',
    'HON-FWK-IÜV-ZDOT-790-472' => undef, # Umlaut
    'QCB-YCU-NJW-EJMK-799-144' => 'YCU/NJW/EJMK/',
    'QCB-YCU-EJMK-NJW-799-144' => undef, # switch sections 3 and 4
    'XHQ-MNW-HRY-XPFV-140-148' => 'MNW/HRY/XPFV/',
    'XHQ-MNW-HRY_XPFV-140-148' => undef, # '_' instead of '-'
    undef                      => undef, # undefined value
);

my $parser = DevOps->new();
for my $code ( keys(%expected) ) {
    $parser->generatePath( $code );
    ok( $parser->getPath, $expected{$code} );
}

done_testing();
