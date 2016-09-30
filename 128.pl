#!/usr/bin/env perl

# PODNAME: 128.pl
# ABSTRACT: Hexagonal tile differences

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-09-30

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $ordinal = 2000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $tile;
my $ring  = 1;
my $count = 2;         # PD(1) = 3 & PD(2) = 3
while (1) {
    $ring++;

    my @neighbours;

    # Top tile
    $tile       = top($ring);
    @neighbours = (
        top( $ring + 1 ),
        top( $ring + 1 ) + 1,
        top($ring) + 1,
        top( $ring - 1 ),
        top( $ring + 1 ) - 1,
        top( $ring + 2 ) - 1,
    );
    $count += pd( $tile, @neighbours ) == 3; ## no critic (ProhibitMagicNumbers)
    last if $count == $ordinal;

    # Last tile
    $tile       = top( $ring + 1 ) - 1;
    @neighbours = (
        top( $ring + 2 ) - 1,
        top($ring),
        top( $ring - 1 ),
        top($ring) - 1,
        top( $ring + 1 ) - 2,
        top( $ring + 2 ) - 2,
    );
    $count += pd( $tile, @neighbours ) == 3; ## no critic (ProhibitMagicNumbers)
    last if $count == $ordinal;
}

printf "%d\n", $tile;

sub top {
    my ($ring) = @_;                         ## no critic (ProhibitReusedNames)

    ## no critic (ProhibitMagicNumbers)
    return 3 * $ring * $ring - 3 * $ring + 2;
    ## use critic
}

sub pd {
    my ( $centre, @neighbours ) = @_;

    my $count = 0;                           ## no critic (ProhibitReusedNames)
    foreach my $neighbour (@neighbours) {
        my $diff = abs $centre - $neighbour;
        if ( is_prime($diff) ) {
            $count++;
        }
    }

    return $count;
}

sub is_prime {
    my ($num) = @_;

    return 0 if $num == 1;    # 1 isn't prime
    ## no critic (ProhibitMagicNumbers)
    return 1 if $num < 4;         # 2 and 3 are prime
    return 0 if $num % 2 == 0;    # Even numbers aren't prime
    return 1 if $num < 9;         # 5 and 7 are prime
    return 0 if $num % 3 == 0;    # Numbers divisible by 3 aren't prime
    ## use critic

    my $num_sqrt = int sqrt $num;
    my $factor   = 5;               ## no critic (ProhibitMagicNumbers)
    while ( $factor <= $num_sqrt ) {
        return 0 if $num % $factor == 0;    # Primes greater than three are 6k-1
        return 0 if $num % ( $factor + 2 ) == 0;    # Or 6k+1
        $factor += 6;    ## no critic (ProhibitMagicNumbers)
    }
    return 1;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'ordinal=i' => \$ordinal,
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

128.pl

Hexagonal tile differences

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Hexagonal tile differences". The
problem is: Find the 2000th tile in this sequence.

=head1 EXAMPLES

    perl 128.pl --ordinal 10

=head1 USAGE

    128.pl
        [--ordinal INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--ordinal INT>

The required ordinal of the sequence.

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
