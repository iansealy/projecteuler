#!/usr/bin/env perl

# PODNAME: 37.pl
# ABSTRACT: Truncatable primes

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-05-25

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

Readonly our $TARGET_TRUNCATABLE => 11;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $max_prime = 1;
my @truncatable;
my $sum;

while ( scalar @truncatable < $TARGET_TRUNCATABLE ) {
    $max_prime *= 10;    ## no critic (ProhibitMagicNumbers)
    @truncatable = ();
    $sum         = 0;

    my @primes = get_primes_up_to($max_prime);
    my %is_prime = map { $_ => 1 } @primes;
    foreach my $prime (@primes) {
        if ( is_truncatable( $prime, \%is_prime ) ) {
            push @truncatable, $prime;
            $sum += $prime;
        }
    }
}

printf "%d\n", $sum;

sub is_truncatable {
    my ( $prime, $is_prime ) = @_;

    return 0 if $prime < 10;    ## no critic (ProhibitMagicNumbers)

    foreach my $i ( 1 .. ( length $prime ) - 1 ) {
        return 0 if !$is_prime->{ substr $prime, $i };
        return 0 if !$is_prime->{ substr $prime, 0, $i };
    }

    return 1;
}

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

37.pl

Truncatable primes

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Truncatable primes". The problem
is: Find the sum of the only eleven primes that are both truncatable from left
to right and right to left.

=head1 EXAMPLES

    perl 37.pl

=head1 USAGE

    37.pl
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
