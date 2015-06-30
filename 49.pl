#!/usr/bin/env perl

# PODNAME: 49.pl
# ABSTRACT: Prime permutations

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-30

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $KNOWN => '148748178147';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

## no critic (ProhibitMagicNumbers)
my @primes = get_primes_up_to(9999);
@primes = grep { length $_ == 4 } @primes;
## use critic

# Group permutations
my %perm_group;
foreach my $prime (@primes) {
    my $ordered_digits = join q{}, sort split //xms, $prime;
    push @{ $perm_group{$ordered_digits} }, $prime;
}

# Keep groups with enough primes
my @groups;
foreach my $group ( keys %perm_group ) {
    ## no critic (ProhibitMagicNumbers)
    if ( scalar @{ $perm_group{$group} } >= 3 ) {
        ## use critic
        push @groups, $perm_group{$group};
    }
}

my $output;

foreach my $group (@groups) {
    ## no critic (ProhibitMagicNumbers)
    foreach my $group3 ( combinations( $group, 3 ) ) {
        ## use critic
        if ( $group3->[1] - $group3->[0] == $group3->[2] - $group3->[1] ) {
            my $concat = join q{}, @{$group3};
            if ( $concat != $KNOWN ) {
                $output = $concat;
            }
        }
    }
}

printf "%d\n", $output;

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

sub combinations {
    my ( $group, $n ) = @_;

    return map { [$_] } @{$group} if $n == 1;

    my @combinations;

    my $i = 0;
    while ( $i + $n <= scalar @{$group} ) {
        my $next = $group->[$i];
        my @rest = @{$group}[ $i + 1 .. ( scalar @{$group} ) - 1 ];
        foreach my $rest_combination ( combinations( \@rest, $n - 1 ) ) {
            push @combinations, [ sort $next, @{$rest_combination} ];
        }
        $i++;
    }

    return @combinations;
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

49.pl

Prime permutations

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Prime permutations". The problem
is: What 12-digit number do you form by concatenating the three terms in this
sequence?

=head1 EXAMPLES

    perl 49.pl

=head1 USAGE

    49.pl
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
