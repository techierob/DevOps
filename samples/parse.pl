#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(mkpath);

for my $record (<>) {
    chomp($record);
    if ($record !~ /^([A-Z]{3}-){3}[A-Z]{4}(-\d{3}){2}$/) {
        warn("'$record' - invalid format");
        next;
    }
    my @code = (@{[split(/-/,$record,5)]}[1..3],"$record.mov");
    my $path = join('/', @code[0..2]);
    my $file = join('/', @code);
    if (!-d$path) {
        mkpath($path);
    }
    if (!-e$file) {
        open(FILE, ">$file") || warn("open $file: $!");
        close(FILE)          || warn("close $file: $!");
    }
}

