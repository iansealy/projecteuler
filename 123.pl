#!/usr/bin/env perl

# PODNAME: 123.pl
# ABSTRACT: Prime square remainders

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-09-06

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Math::BigInt;

# Default options
my $limit = Math::BigInt->new( 10**10 );    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

## no critic (ProhibitMagicNumbers)
my @primes = get_primes_up_to( sqrt $limit * 10 );
## use critic
my $n = 0;
foreach my $prime (@primes) {
    $n++;
    next if $n % 2 == 0;
    my $r = $prime * $n * 2;
    last if $r > $limit;
}

printf "%d\n", $n;

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

123.pl

Prime square remainders

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Prime square remainders". The
problem is: Find the least value of n for which the remainder first exceeds
10^10.

=head1 EXAMPLES

    perl 123.pl --limit 1000000000

=head1 USAGE

    123.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The minimum remainder.

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
