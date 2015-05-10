#!/usr/bin/env perl

# PODNAME: 33.pl
# ABSTRACT: Digit cancelling fractions

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-05-10

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @numerators;
my @denominators;

## no critic (ProhibitMagicNumbers)
foreach my $numerator ( 10 .. 98 ) {
    my ( $numerator1, $numerator2 ) = split //xms, $numerator;
    foreach my $denominator ( $numerator + 1 .. 99 ) {
        ## use critic
        my ( $denominator1, $denominator2 ) = split //xms, $denominator;
        if (
            (
                   $numerator1 == $denominator2
                && $denominator1 > 0
                && $numerator2 / $denominator1 == $numerator / $denominator
            )
            || (   $numerator2 == $denominator1
                && $denominator2 > 0
                && $numerator1 / $denominator2 == $numerator / $denominator )
          )
        {
            push @numerators,   $numerator;
            push @denominators, $denominator;
        }
    }
}

my $numerator_product   = 1;
my $denominator_product = 1;
foreach ( 1 .. scalar @denominators ) {
    $numerator_product   *= shift @numerators;
    $denominator_product *= shift @denominators;
}

my @primes = get_primes_up_to($numerator_product);
foreach my $prime (@primes) {
    while ($numerator_product % $prime == 0
        && $denominator_product % $prime == 0 )
    {
        $numerator_product   /= $prime;
        $denominator_product /= $prime;
    }
}

printf "%d\n", $denominator_product;

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

33.pl

Digit cancelling fractions

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Digit cancelling fractions". The
problem is: If the product of these four fractions is given in its lowest common
terms, find the value of the denominator.

=head1 EXAMPLES

    perl 33.pl

=head1 USAGE

    33.pl
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
