#!/usr/bin/env perl

# PODNAME: 110.pl
# ABSTRACT: Diophantine reciprocals II

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-07-01

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Algorithm::Combinatorics qw(combinations_with_repetition);
use List::Util qw(product);
use Math::BigInt;

# Default options
my $limit = 4_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @primes = get_primes_up_to($limit);

## no critic (ProhibitMagicNumbers)
my $max_primes = int( ( log 2 * $limit ) / log 3 ) + 1;
## use critic
@primes = @primes[ 0 .. $max_primes - 1 ];

my @exponent_set = (1);
my $min_n2;
my $prev_min_n2;
while ( !defined $prev_min_n2 || $min_n2 != $prev_min_n2 ) {
    $prev_min_n2 = $min_n2;
    push @exponent_set, $exponent_set[-1] + 2;
    my $combs = combinations_with_repetition( \@exponent_set, $max_primes );
    while ( my $comb = $combs->next ) {
        my $product = product( @{$comb} );
        if ( $product > $limit * 2 ) {
            my @exponents = reverse @{$comb};
            my $n2        = Math::BigInt->new(1);
            foreach my $i ( 0 .. scalar @primes - 1 ) {
                $n2 *= $primes[$i]**( $exponents[$i] - 1 );
            }
            next if defined $min_n2 && $n2 >= $min_n2;
            $min_n2 = $n2;
        }
    }
}

printf "%d\n", sqrt $min_n2;

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

110.pl

Diophantine reciprocals II

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Diophantine reciprocals II". The
problem is: What is the least value of n for which the number of distinct
solutions exceeds four million?

=head1 EXAMPLES

    perl 110.pl

=head1 USAGE

    110.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The minimum number of distinct solutions.

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
