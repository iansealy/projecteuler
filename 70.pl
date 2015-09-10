#!/usr/bin/env perl

# PODNAME: 70.pl
# ABSTRACT: Totient permutation

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-09-10

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $LIMIT => 1e7;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

# Assume n is semiprime

my $min_ratio;
my $n_for_min_ratio;

my @primes = get_primes_up_to( 2 * sqrt $LIMIT );

foreach my $i (@primes) {
    foreach my $j (@primes) {
        next if $j < $i;
        my $n = $i * $j;
        next if $n >= $LIMIT;
        my $phi = $n * ( 1 - 1 / $i );
        if ( $i != $j ) {
            $phi *= ( 1 - 1 / $j );
        }
        next if !is_perm( $n, $phi );
        my $ratio = $n / $phi;
        if ( !defined $min_ratio || $ratio < $min_ratio ) {
            $min_ratio       = $ratio;
            $n_for_min_ratio = $n;
        }
    }
}

printf "%d\n", $n_for_min_ratio;

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

sub is_perm {
    my ( $num1, $num2 ) = @_;

    my $digits1 = join q{}, sort split //xms, $num1;
    my $digits2 = join q{}, sort split //xms, $num2;

    return $digits1 eq $digits2;
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

70.pl

Totient permutation

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Totient permutation". The problem
is: Find the value of n, 1 < n < 107, for which φ(n) is a permutation of n and
the ratio n/φ(n) produces a minimum.

=head1 EXAMPLES

    perl 70.pl

=head1 USAGE

    70.pl
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
