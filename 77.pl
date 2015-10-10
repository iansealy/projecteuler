#!/usr/bin/env perl

# PODNAME: 77.pl
# ABSTRACT: Prime summations

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-10-10

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Memoize qw( memoize );

# Default options
my $minimum = 5001;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

memoize('ways');

my $n    = 0;
my $ways = 0;
my @primes;
while ( $ways < $minimum ) {
    $n++;
    if ( $n =~ m/\A10*\z/xms ) {
        ## no critic (ProhibitMagicNumbers)
        @primes = get_primes_up_to( $n * 10 );
        ## use critic
    }
    $ways = ways( $n, grep { $_ < $n } @primes );
}

printf "%d\n", $n;

sub ways {
    my ( $total, @numbers ) = @_;

    return 0 if $total < 0;
    return 1 if $total == 0;

    my $count = 0;
    while ( my $number = shift @numbers ) {
        $count += ways( $total - $number, $number, @numbers );
    }

    return $count;
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
        'minimum=i' => \$minimum,
        'debug'     => \$debug,
        'help'      => \$help,
        'man'       => \$man,
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

77.pl

Prime summations

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Prime summations". The problem is:
What is the first value which can be written as the sum of primes in over five
thousand different ways?

=head1 EXAMPLES

    perl 77.pl

=head1 USAGE

    77.pl
        [--minimum INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--minimum INT>

The minimum number of prime sums.

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
