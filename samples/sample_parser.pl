#!/usr/bin/env perl
use strict;
use warnings;
use lib '../lib';
use DevOps;
use File::Path qw(mkpath);

my $parser = DevOps->new(
    containerDir => '/tmp/devops',
);

print "generating directories in " . ($parser->getContainerDir // './') . " ...\n";
for my $record (<>) {
    chomp($record);
    $parser->generatePath($record);
    $parser->createPath();
    $parser->createFile();
}

