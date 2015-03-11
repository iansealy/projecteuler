#!/usr/bin/env perl

# PODNAME: 15.pl
# ABSTRACT: Lattice paths

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-03-11

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $grid_size = 20;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

printf "%d\n", factorial( $grid_size + $grid_size ) / factorial($grid_size)**2;

sub factorial {
    my ($number) = @_;

    my $factorial = 1;

    while ( $number > 1 ) {
        $factorial *= $number;
        $number--;
    }

    return $factorial;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'grid_size=i' => \$grid_size,
        'debug'       => \$debug,
        'help'        => \$help,
        'man'         => \$man,
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

15.pl

Lattice paths

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Lattice paths". The problem is:
How many such routes are there through a 20×20 grid?

=head1 EXAMPLES

    perl 15.pl --grid_size 2

=head1 USAGE

    15.pl
        [--grid_size INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--grid_size INT>

The size of the grid (INT x INT).

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
