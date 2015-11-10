#!/usr/bin/env perl

# PODNAME: 87.pl
# ABSTRACT: Prime power triples

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-11-10

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 50_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @primes = get_primes_up_to( int sqrt $limit );

my @squares;
my @cubes;
my @fourths;
foreach my $prime (@primes) {
    my $square = $prime * $prime;
    if ( $square < $limit ) {
        push @squares, $square;
    }
    my $cube = $square * $prime;
    if ( $cube < $limit ) {
        push @cubes, $cube;
    }
    my $fourth = $cube * $prime;
    if ( $fourth < $limit ) {
        push @fourths, $fourth;
    }
}

my %is_expressible;
foreach my $fourth (@fourths) {
    foreach my $cube (@cubes) {
        foreach my $square (@squares) {
            my $sum = $square + $cube + $fourth;
            last if $sum >= $limit;
            $is_expressible{$sum} = 1;
        }
    }
}

printf "%d\n", scalar keys %is_expressible;

sub get_primes_up_to {
    my ($limit) = @_;    ## no critic (ProhibitReusedNames)

    my $sieve_bound = int( ( $limit - 1 ) / 2 );    # Last index of sieve
    my @sieve;
    my $cross_limit = int( ( int( sqrt $limit ) - 1 ) / 2 );
    foreach my $i ( 1 .. $cross_limit ) {
        if ( !$sieve[ $i - 1 ] ) {

            # 2 * $i + 1 is prime, so mark multiples
            my $j = 2 * $i * ( $i + 1 );
            while ( $j <= $sieve_bound ) {
                $sieve[ $j - 1 ] = 1;
                $j += 2 * $i + 1;
            }
        }
    }

    my @primes_up_to = (2);
    foreach my $i ( 1 .. $sieve_bound ) {
        if ( !$sieve[ $i - 1 ] ) {
            push @primes_up_to, 2 * $i + 1;
        }
    }

    return @primes_up_to;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'limit=i' => \$limit,
        'debug'   => \$debug,
        'help'    => \$help,
        'man'     => \$man,
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

87.pl

Prime power triples

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Prime power triples". The problem
is: How many numbers below fifty million can be expressed as the sum of a prime
square, prime cube, and prime fourth power?

=head1 EXAMPLES

    perl 87.pl

=head1 USAGE

    87.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum sum.

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
