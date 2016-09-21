#!/usr/bin/env perl

# PODNAME: 126.pl
# ABSTRACT: Cuboid layers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-09-19

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $cuboids = 1000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $first;
my $limit = $cuboids * 10;    ## no critic (ProhibitMagicNumbers)
while (1) {
    $limit *= 2;
    my @count;
    foreach my $x ( 1 .. $limit ) {
        last if count_cuboids( $x, 1, 1, 1 ) > $limit;
        foreach my $y ( 1 .. $x ) {
            last if count_cuboids( $x, $y, 1, 1 ) > $limit;
            foreach my $z ( 1 .. $y ) {
                last if count_cuboids( $x, $y, $z, 1 ) > $limit;
                foreach my $n ( 1 .. $limit ) {
                    my $total = count_cuboids( $x, $y, $z, $n );
                    last if $total > $limit;
                    $count[$total]++;
                }
            }
        }
    }
    foreach my $n ( 1 .. $limit ) {
        if ( defined $count[$n] && $count[$n] == $cuboids ) {
            $first = $n;
            last;
        }
    }
    last if defined $first;
}

printf "%d\n", $first;

sub count_cuboids {
    my ( $x, $y, $z, $n ) = @_;

    my $faces = 2 * ( $x * $y + $y * $z + $z * $x );
    ## no critic (ProhibitMagicNumbers)
    my $lines = ( $n - 1 ) * 4 * ( $x + $y + $z );
    my $corners = ( $n - 2 ) * ( $n - 1 ) / 2 * 8;
    ## use critic

    return $faces + $lines + $corners;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'cuboids=i' => \$cuboids,
        'debug'     => \$debug,
        'help'      => \$help,
        'man'       => \$man,
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

126.pl

Cuboid layers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Cuboid layers". The problem is:
Find the least value of n for which C(n) = 1000.

=head1 EXAMPLES

    perl 126.pl --cuboids 10

=head1 USAGE

    126.pl
        [--cuboids INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--cuboids INT>

The number of cuboids.

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
