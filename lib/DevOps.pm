package DevOps;
use strict;
use warnings;
use File::Path qw(mkpath);

=head1 NAME

DevOps - test package for wrangling data

=head1 DESCRIPTION

Given a list of codes, create a directory tree and stub file
where none already exists.

=head1 METHODS

=cut

=head2 new

my $parser = DevOps->new(
    containerDir => '/tmp',
    extension    => '.mov', # XXX - FIXME
);
$parser->generatePath( $code );

=cut

sub new {
    my ($class, %p) = @_;
    my $self = { %p };
    bless($self, $class);
    if ( exists($p{containerDir}) ) {
        $self->setContainerDir( $p{containerDir} );
    }
    return($self);
}

=head2 generatePath
    given a string, returns a 4-element list made up of its relative
    path and filename or undef if the code isn't correctly formatted
    (see L<validateCode>), eg.
      $parser->generatePath('ABC-DEF-GHI-JKLM-123-001'); # ('DEF', 'GHI', 'JKLM', 'ABC-DEF-GHI-JKLM-123-001')

=cut

sub generatePath {
    my ($self, $code) = @_;

    $self->validateCode($code) || return;
    $self->{_path} = [ (@{[split(/-/,$code,5)]}[1..3],"$code.mov") ];
    return( @{$self->{_path}} );
}

=head2 getPath
    returns the directory path for the current code or undef if none is
    set, eg.
        $parser->generatePath('ABC-DEF-GHI-JKLM-123-001');
        $parser->getPath(); # DEF/GHI/JKLM/

=cut

sub getPath {
    my ($self) = @_;

    ( ref($self->{_path}) eq 'ARRAY' ) || return;
    return( $self->getContainerDir . join('/', @{$self->{_path}}[0..2]) . '/' );
}

=head2 getFileName
    returns the target file name or undef if none is set, eg.
        $parser->generatePath('ABC-DEF-GHI-JKLM-123-001');
        $parser->getFile(); # ABC-DEF-GHI-JKLM-123-001.mov

=cut

sub getFileName {
    my ($self) = @_;

    $self->{_path} // return;
    return( $self->{_path}->[3] );
}

=head2 getFilePath
    gets a file path where a file path has been generated

=cut

sub getFilePath {
    my ($self) = @_;

    return( $self->getPath . $self->getFileName );
}

=head2 getContainerDir
    returns the current container directory.

=cut

sub getContainerDir {
    my ($self) = @_;

    return($self->{containerDir});
}

=head2 setContainerDir
    sets the container directory to the specified path and returns the
    current value, eg.
      $parser->setContainerDir('/tmp'); # sets container directory to /tmp
      $parser->getContainerDir();       # returns /tmp/

=cut

sub setContainerDir {
    my ($self, $containerDir) = @_;

    $containerDir // return;
    $containerDir =~ s{([^/])$}{$1/}; # append trailing foreslash if none is present
    $self->{containerDir} = $containerDir;
}

=head2 validateCode
    given a string, returns true if it matches the required format or
    false otherwise, eg:
      validateCode('ABC-DEF-GHI-JKLM-123-001'); # true
      validateCode('123-345-789-ABC-DEF-GHI'); # false

=cut

sub validateCode {
    my ($self, $code) = @_;

    return($code =~ /^([A-Z]{3}-){3}[A-Z]{4}(-\d{3}){2}$/);
}

=head2 createPath
    creates the path where a path has been generated

=cut

sub createPath {
    my ($self) = @_;

    my $path = $self->getPath() || return;
    mkpath($path); # XXX - FIXME: log something useful here
}

=head2 createFile
    creates a file where a file has been generated

=cut

sub createFile {
    my ($self) = @_;

    my $filePath = $self->getFilePath() || return;
    open(FILE, ">$filePath") || warn("opening $filePath: $!");
    close(FILE)              || warn("closing $filePath: $!");
}

=encoding utf8

=head1 AUTHOR

Robert Ryan

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
