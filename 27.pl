#!/usr/bin/env perl

# PODNAME: 27.pl
# ABSTRACT: Quadratic primes

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-19

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $MAX_A        => 999;
Readonly our $MAX_B        => 999;
Readonly our $PRIMES_LIMIT => 1_000_000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my %is_prime = map { $_ => 1 } get_primes_up_to($PRIMES_LIMIT);

my $max_n = 0;
my $max_product;

foreach my $a ( -$MAX_A .. $MAX_A ) {
    foreach my $b ( -$MAX_B .. $MAX_B ) {
        my $n = 0;
        while (1) {
            my $quadratic = $n * $n + $a * $n + $b;
            if ( !exists $is_prime{$quadratic} ) {
                last;
            }
            $n++;
        }
        if ( $n > $max_n ) {
            $max_n       = $n;
            $max_product = $a * $b;
        }
    }
}

printf "%d\n", $max_product;

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

27.pl

Quadratic primes

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Quadratic primes". The problem is:
Find the product of the coefficients, a and b, for the quadratic expression that
produces the maximum number of primes for consecutive values of n, starting with
n = 0.

=head1 EXAMPLES

    perl 27.pl

=head1 USAGE

    27.pl
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
