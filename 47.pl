#!/usr/bin/env perl

# PODNAME: 47.pl
# ABSTRACT: Distinct primes factors

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-24

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
## no critic (ProhibitMagicNumbers)
my $target = 4;
my $limit  = 1_000_000;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @primes = get_primes_up_to($limit);

my $n           = 1;
my $consecutive = 0;
my $first;
while ( !defined $first && $n < $limit ) {
    $n++;
    if ( count_prime_factors( $n, \@primes ) == $target ) {
        $consecutive++;
        if ( $consecutive == $target ) {
            $first = $n - $target + 1;
        }
    }
    else {
        $consecutive = 0;
    }
}

printf "%d\n", $first;

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

sub count_prime_factors {
    my ( $number, $primes ) = @_;

    my %factor;

    foreach my $prime ( @{$primes} ) {
        last if $prime > $number;
        while ( $number % $prime == 0 ) {
            $factor{$prime} = 1;
            $number /= $prime;
        }
    }

    return scalar keys %factor;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'target=i' => \$target,
        'limit=i'  => \$limit,
        'debug'    => \$debug,
        'help'     => \$help,
        'man'      => \$man,
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

47.pl

Distinct primes factors

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Distinct primes factors". The
problem is: Find the first four consecutive integers to have four distinct prime
factors. What is the first of these numbers?

=head1 EXAMPLES

    perl 47.pl

=head1 USAGE

    47.pl
        [--target INT]
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--target INT>

The target number of consecutive integers and distinct prime factors.

=item B<--limit INT>

The maximum prime number.

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
