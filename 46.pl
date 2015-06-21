#!/usr/bin/env perl

# PODNAME: 46.pl
# ABSTRACT: Goldbach's other conjecture

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-21

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

my $limit = 100;    ## no critic (ProhibitMagicNumbers)
my $smallest;
while ( !defined $smallest ) {
    $limit *= 10;    ## no critic (ProhibitMagicNumbers)
    my @primes          = get_primes_up_to($limit);
    my %is_prime        = map { $_ => 1 } @primes;
    my @twice_squares   = get_twice_squares_up_to($limit);
    my %is_twice_square = map { $_ => 1 } @twice_squares;
    my $n               = 1;
  COMPOSITE: while ( $n < $limit ) {
        $n += 2;
        next if $is_prime{$n};
        foreach my $prime (@primes) {
            last if $prime >= $n;
            next COMPOSITE if $is_twice_square{ $n - $prime };
        }
        $smallest = $n;
        last;
    }
}

printf "%d\n", $smallest;

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

sub get_twice_squares_up_to {
    my ($limit) = @_;    ## no critic (ProhibitReusedNames)

    my @twice_squares = (2);
    my $i             = 1;
    while ( $twice_squares[-1] < $limit ) {
        $i++;
        push @twice_squares, 2 * $i * $i;
    }

    return @twice_squares;
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

46.pl

Goldbach's other conjecture

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Goldbach's other conjecture". The
problem is: What is the smallest odd composite that cannot be written as the sum
of a prime and twice a square?

=head1 EXAMPLES

    perl 46.pl

=head1 USAGE

    46.pl
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
