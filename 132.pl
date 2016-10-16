#!/usr/bin/env perl

# PODNAME: 132.pl
# ABSTRACT: Large repunit factors

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-10-16

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use List::Util qw(sum);

# Default options
## no critic (ProhibitMagicNumbers)
my $k       = 10**9;
my $factors = 40;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $limit = 1000;    ## no critic (ProhibitMagicNumbers)
my @factors;
while ( scalar @factors < $factors ) {
    @factors = ();
    $limit *= 10;    ## no critic (ProhibitMagicNumbers)
    my @primes = get_primes_up_to($limit);
    foreach my $prime (@primes) {
        ## no critic (ProhibitMagicNumbers)
        if ( modular_exponentiation( 10, $k, 9 * $prime ) == 1 ) {
            ## use critic
            push @factors, $prime;
            last if scalar @factors == $factors;
        }
    }
}

printf "%d\n", sum(@factors);

sub modular_exponentiation {
    my ( $base, $exp, $mod ) = @_;

    my $result = 1;
    $base %= $mod;
    while ( $exp > 0 ) {
        if ( $exp % 2 == 1 ) {
            $result = ( $result * $base ) % $mod;
        }
        $exp >>= 1;
        $base = ( $base * $base ) % $mod;
    }

    return $result;
}

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
        'k=i'       => \$k,
        'factors=i' => \$factors,
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

132.pl

Large repunit factors

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Large repunit factors". The
problem is: Find the sum of the first forty prime factors of R(10^9).

=head1 EXAMPLES

    perl 132.pl --k 10 --factors 4

=head1 USAGE

    132.pl
        [--k INT]
        [--factors INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--exponent INT>

The number of digits in the repunit.

=item B<--factors INT>

The number of prime factors to sum.

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
