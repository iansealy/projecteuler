#!/usr/bin/env perl

# PODNAME: 12.pl
# ABSTRACT: Highly divisible triangular number

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-02-27

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
## no critic (ProhibitMagicNumbers)
my $divisors     = 500;
my $primes_limit = 1000;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @primes = get_primes_up_to($primes_limit);

# Triangle numbers are of form n*(n+1)*2
# D() = number of divisors
# D(triangle number) = D(n/2)*D(n+1) if n is even
#                   or D(n)*D((n+1)/2) if n+1 is even

## no critic (ProhibitMagicNumbers)
my $n = 3;    # Start with a prime
## use critic
my $num_divisors_n = 2;    # Always 2 for a prime
my $num_factors    = 0;

while ( $num_factors <= $divisors ) {
    $n++;
    my $n1 = $n;
    if ( $n1 % 2 == 0 ) {
        $n1 /= 2;
    }
    my $num_divisors_n1 = 1;

    foreach my $prime (@primes) {
        if ( $prime * $prime > $n1 ) {

            # Got last prime factor with exponent of 1
            $num_divisors_n1 *= 2;
            last;
        }

        my $exponent = 1;
        while ( $n1 % $prime == 0 ) {
            $exponent++;
            $n1 /= $prime;
        }
        if ( $exponent > 1 ) {
            $num_divisors_n1 *= $exponent;
        }
        last if $n1 == 1;
    }

    $num_factors    = $num_divisors_n * $num_divisors_n1;
    $num_divisors_n = $num_divisors_n1;
}

printf "%d\n", $n * ( $n - 1 ) / 2;

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

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'divisors=i'     => \$divisors,
        'primes_limit=i' => \$primes_limit,
        'debug'          => \$debug,
        'help'           => \$help,
        'man'            => \$man,
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

12.pl

Highly divisible triangular number

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Highly divisible triangular
number". The problem is: What is the value of the first triangle number to have
over five hundred divisors?

=head1 EXAMPLES

    perl 12.pl --divisors 5

=head1 USAGE

    12.pl
        [--divisors INT]
        [--primes_limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--divisors INT>

The minimum number of divisors the triangle number should have.

=item B<--primes_limit INT>

The highest number to check when generating a list of primes.

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
