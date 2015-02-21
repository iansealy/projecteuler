#!/usr/bin/env perl

# PODNAME: 10.pl
# ABSTRACT: Summation of primes

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-02-18

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 2_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $sieve_bound = int( ( $limit - 1 ) / 2 );    # Last index of sieve
my @sieve;
my $cross_limit = int( ( int( sqrt($limit) ) - 1 ) / 2 );
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

my $sum = 2;    # 2 is a prime
foreach my $i ( 1 .. $sieve_bound ) {
    if ( !$sieve[ $i - 1 ] ) {
        $sum += 2 * $i + 1;
    }
}

printf "%d\n", $sum;

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

10.pl

Summation of primes

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Summation of primes". The problem
is: Find the sum of all the primes below two million.

=head1 EXAMPLES

    perl 10.pl --limit 10

=head1 USAGE

    10.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The number below which to sum up all primes.

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
