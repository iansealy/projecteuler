#!/usr/bin/env perl

# PODNAME: 60.pl
# ABSTRACT: Prime pair sets

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-08-07

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $set_size = 5;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $limit       = 10;                ## no critic (ProhibitMagicNumbers)
my $min_set_sum = $limit * $limit;

while ( $min_set_sum == $limit * $limit ) {
    $limit *= 10;                    ## no critic (ProhibitMagicNumbers)
    $min_set_sum = $limit * $limit;

    my @primes = get_primes_up_to($limit);

    my %pair;
    foreach my $prime1 (@primes) {
        foreach my $prime2 (@primes) {
            next if $prime2 <= $prime1;
            if (   is_prime( $prime1 . $prime2 )
                && is_prime( $prime2 . $prime1 ) )
            {
                $pair{$prime1}{$prime2} = 1;
            }
        }
    }

    foreach my $prime ( sort { $a <=> $b } keys %pair ) {
        last if $prime > $min_set_sum;
        $min_set_sum = get_set( \%pair, [ keys %{ $pair{$prime} } ],
            [$prime], $set_size, $min_set_sum );
    }
}

printf "%d\n", $min_set_sum;

sub get_set {
    ## no critic (ProhibitReusedNames ProhibitAmbiguousNames)
    my ( $pair, $candidates, $set, $set_size, $min_set_sum ) = @_;
    ## use critic

    my $set_sum = 0;
    foreach my $prime ( @{$set} ) {
        $set_sum += $prime;
    }

    if ( scalar @{$set} == $set_size ) {
        return $set_sum < $min_set_sum ? $set_sum : $min_set_sum;
    }

    foreach my $prime ( sort { $a <=> $b } @{$candidates} ) {
        return $min_set_sum if $set_sum + $prime > $min_set_sum;
        my %intersection = map { $_ => 1 } @{$candidates};
        foreach my $i ( keys %{ $pair->{$prime} } ) {
            $intersection{$i}++;
        }
        my @new_candidates = grep { $intersection{$_} == 2 } keys %intersection;
        $min_set_sum = get_set( $pair, \@new_candidates, [ @{$set}, $prime ],
            $set_size, $min_set_sum );
    }

    return $min_set_sum;
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

sub is_prime {
    my ($num) = @_;

    return 0 if $num == 1;    # 1 isn't prime
    ## no critic (ProhibitMagicNumbers)
    return 1 if $num < 4;         # 2 and 3 are prime
    return 0 if $num % 2 == 0;    # Odd numbers aren't prime
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
        'set_size=i' => \$set_size,
        'debug'      => \$debug,
        'help'       => \$help,
        'man'        => \$man,
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

60.pl

Prime pair sets

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Prime pair sets". The problem is:
Find the lowest sum for a set of five primes for which any two primes
concatenate to produce another prime.

=head1 EXAMPLES

    perl 60.pl

=head1 USAGE

    60.pl
        [--set_size INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--set_size INT>

The target number of primes in the set.

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
