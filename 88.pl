#!/usr/bin/env perl

# PODNAME: 88.pl
# ABSTRACT: Product-sum numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-11-13

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Algorithm::Combinatorics qw(partitions);
use Storable qw(freeze);

# Default options
my $max = 12_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @primes = get_primes_up_to( $max * 2 );

my %min_prod_sum_for;

foreach my $n ( 2 .. $max * 2 ) {
    my @prime_factors = get_prime_factors( $n, \@primes );
    next if scalar @prime_factors == 1;
    my %seen;
    my $partitions_iterator = partitions( \@prime_factors );
    while ( my $partitions = $partitions_iterator->next ) {
        next if scalar @{$partitions} == 1;
        @{$partitions} = sort { scalar @{$a} <=> scalar @{$b} } @{$partitions};
        my $serialised = freeze($partitions);
        next if exists $seen{$serialised};
        $seen{$serialised} = 1;
        my @factors;
        my $sum = 0;
        foreach my $partition ( @{$partitions} ) {
            my $factor = 1;
            foreach my $number ( @{$partition} ) {
                $factor *= $number;
            }
            push @factors, $factor;
            $sum += $factor;
        }
        next if $sum > $n;
        my $k = $n - $sum + scalar @factors;
        next if $k > $max;
        if ( !exists $min_prod_sum_for{$k} || $min_prod_sum_for{$k} > $n ) {
            $min_prod_sum_for{$k} = $n;
        }
    }
}

my %prod_sum = map { $_ => 1 } values %min_prod_sum_for;
my $sum_of_sums = 0;
foreach my $prod_sum ( keys %prod_sum ) {
    $sum_of_sums += $prod_sum;
}

printf "%d\n", $sum_of_sums;

sub get_primes_up_to {
    my ($limit) = @_;

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

sub get_prime_factors {
    my ( $number, $primes ) = @_;

    my @factors;

    foreach my $prime ( @{$primes} ) {
        while ( $number % $prime == 0 ) {
            push @factors, $prime;
            $number /= $prime;
        }
    }

    return @factors;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'max=i' => \$max,
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

88.pl

Distinct powers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Product-sum numbers". The problem
is: What is the sum of all the minimal product-sum numbers for 2≤k≤12000?

=head1 EXAMPLES

    perl 88.pl --max 12

=head1 USAGE

    88.pl
        [--max INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--max INT>

The maximum set size.

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
