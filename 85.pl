#!/usr/bin/env perl

# PODNAME: 85.pl
# ABSTRACT: Counting rectangles

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-11-04

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $TARGET => 2_000_000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

# Get triangular numbers
my @triangle = (0);
my $n        = 0;
while ( $triangle[-1] < $TARGET ) {
    $n++;
    push @triangle, $n * ( $n + 1 ) / 2;
}

my $closest_area;
my $closest_diff = $TARGET;
foreach my $i ( 1 .. scalar @triangle - 1 ) {
    foreach my $j ( $i .. scalar @triangle - 1 ) {
        my $rectangles = $triangle[$i] * $triangle[$j];
        if ( abs( $rectangles - $TARGET ) < $closest_diff ) {
            $closest_diff = abs $rectangles - $TARGET;
            $closest_area = $i * $j;
        }
    }
}

printf "%d\n", $closest_area;

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

85.pl

Counting rectangles

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Counting rectangles". The problem
is: Although there exists no rectangular grid that contains exactly two million
rectangles, find the area of the grid with the nearest solution.

=head1 EXAMPLES

    perl 50.pl

=head1 USAGE

    85.pl
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

This software is Copyright (c) 2015 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
