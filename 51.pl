#!/usr/bin/env perl

# PODNAME: 51.pl
# ABSTRACT: Prime digit replacements

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-07-06

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $prime_value = 8;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $digits = 1;
my $smallest_prime;
DIGITS: while (1) {
    $digits++;
    my $limit  = 10**$digits - 1;            ## no critic (ProhibitMagicNumbers)
    my @primes = get_primes_up_to($limit);
    @primes = grep { length $_ == $digits } @primes;
    my %is_prime = map { $_ => 1 } @primes;
    foreach my $n ( 1 .. $digits - 1 ) {
        foreach my $combination ( combinations( [ 0 .. ( $digits - 1 ) ], $n ) )
        {
            my %prime_count;
            foreach my $prime (@primes) {
                my $prime_base = $prime;
                my %removed;
                foreach my $position ( @{$combination} ) {
                    $removed{ substr $prime_base, $position, 1, q{x} } = 1;
                }
                if ( scalar keys %removed == 1 ) {
                    $prime_count{$prime_base}++;
                }
            }
            foreach my $prime_base ( keys %prime_count ) {
                next if $prime_count{$prime_base} != $prime_value;
                ## no critic (ProhibitMagicNumbers)
                foreach my $replace ( 0 .. 9 ) {
                    ## use critic
                    my $prime = $prime_base;
                    $prime =~ s/x/$replace/xmsg;
                    ## no critic (ProhibitDeepNests)
                    if ( $is_prime{$prime} ) {
                        ## use critic
                        $smallest_prime = $prime;
                        last DIGITS;
                    }
                }
            }
        }
    }
}

printf "%d\n", $smallest_prime;

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
        'prime_value=i' => \$prime_value,
        'debug'         => \$debug,
        'help'          => \$help,
        'man'           => \$man,
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

51.pl

Prime digit replacements

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Prime digit replacements". The
problem is: Find the smallest prime which, by replacing part of the number (not
necessarily adjacent digits) with the same digit, is part of an eight prime
value family.

=head1 EXAMPLES

    perl 51.pl

=head1 USAGE

    51.pl
        [--prime_value INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--prime_value INT>

The value of the prime family.

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
