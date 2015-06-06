#!/usr/bin/env perl

# PODNAME: 41.pl
# ABSTRACT: Pandigital prime

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-06

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

my $max;

# 8 and 9 digit pandigital numbers are divisible by 3 so not prime
# 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 = 45
# 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8     = 36
# 1 + 2 + 3 + 4 + 5 + 6 + 7         = 28
my @primes = get_primes_up_to(10_000_000);   ## no critic (ProhibitMagicNumbers)
foreach my $prime ( reverse @primes ) {
    next if $prime =~ m/0/xms;
    my $num_digits = length $prime;
    my %digit = map { $_ => 1 } split //xms, $prime;
    next if scalar keys %digit != $num_digits;
    next if ( reverse sort { $a <=> $b } keys %digit )[0] > $num_digits;
    $max = $prime;
    last;
}

printf "%d\n", $max;

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

41.pl

Pandigital prime

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Pandigital prime". The problem is:
What is the largest n-digit pandigital prime that exists?

=head1 EXAMPLES

    perl 41.pl

=head1 USAGE

    41.pl
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
