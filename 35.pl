#!/usr/bin/env perl

# PODNAME: 35.pl
# ABSTRACT: Circular primes

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-05-16

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
## no critic (ProhibitMagicNumbers)
my $max = 1_000_000;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @primes = get_primes_up_to( $max - 1 );
my %is_prime = map { $_ => 1 } @primes;

my @circular;
PRIME: foreach my $prime (@primes) {
    foreach ( 1 .. length $prime ) {

        # Rotate
        $prime .= substr $prime, 0, 1, q{};
        next PRIME if !$is_prime{$prime};
    }
    push @circular, $prime;
}

printf "%d\n", scalar @circular;

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
        'max=i' => \$max,
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

35.pl

Circular primes

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Circular primes". The problem is:
How many circular primes are there below one million?

=head1 EXAMPLES

    perl 35.pl --max 100

=head1 USAGE

    35.pl
        [--max INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--max INT>

The maximum to check for circular primes.

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
