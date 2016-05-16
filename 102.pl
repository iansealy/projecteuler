#!/usr/bin/env perl

# PODNAME: 102.pl
# ABSTRACT: Triangle containment

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-05-16

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use LWP::Simple;

# Constants
Readonly our $TRIANGLES_URL =>
  'https://projecteuler.net/project/resources/p102_triangles.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $contains_origin = 0;
my $triangles       = get($TRIANGLES_URL);
foreach my $line ( split /\s+/xms, $triangles ) {
    my ( $x1, $y1, $x2, $y2, $x3, $y3 ) = split /,/xms, $line;

    my $area = area( $x1, $y1, $x2, $y2, $x3, $y3 );

    my $area1 = area( 0,   0,   $x2, $y2, $x3, $y3 );
    my $area2 = area( $x1, $y1, 0,   0,   $x3, $y3 );
    my $area3 = area( $x1, $y1, $x2, $y2, 0,   0 );

    if ( $area1 + $area2 + $area3 == $area ) {
        $contains_origin++;
    }
}

printf "%d\n", $contains_origin;

sub area {    ## no critic (ProhibitManyArgs)
    my ( $x1, $y1, $x2, $y2, $x3, $y3 ) = @_;

    return
      abs( $x1 * ( $y2 - $y3 ) + $x2 * ( $y3 - $y1 ) + $x3 * ( $y1 - $y2 ) ) /
      2;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'debug' => \$debug,
        'help'  => \$help,
        'man'   => \$man,
    ) or pod2usage(2);

    # Documentation
    if ($help) {
        pod2usage(1);
    }
    elsif ($man) {
        pod2usage( -verbose => 2 );
    }

    return;
}

__END__
=pod

=encoding UTF-8

=head1 NAME

102.pl

Triangle containment

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Triangle containment". The problem
is: Using triangles.txt, a 27K text file containing the co-ordinates of one
thousand "random" triangles, find the number of triangles for which the interior
contains the origin.

=head1 EXAMPLES

    perl 102.pl

=head1 USAGE

    102.pl
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--debug>

Print debugging information.

=item B<--help>

Print a brief help message and exit.

=item B<--man>

Print this script's manual page and exit.

=back

=head1 DEPENDENCIES

None

=head1 AUTHOR

=over 4

=item *

Ian Sealy <ian.sealy@sanger.ac.uk>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
