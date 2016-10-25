#!/usr/bin/env perl

# PODNAME: 134.pl
# ABSTRACT: Prime pair connection

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-10-24

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 1_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

## no critic (ProhibitMagicNumbers)
my @primes = get_primes_up_to( $limit * 1.1 );
@primes = grep { $_ >= 5 } @primes;
## use critic
my $num_below_limit = scalar grep { $_ <= $limit } @primes;
@primes = @primes[ 0 .. $num_below_limit ];

my $sum = 0;

foreach my $i ( 0 .. scalar @primes - 2 ) {
    my $prime1     = $primes[$i];
    my $prime2     = $primes[ $i + 1 ];
    my $n          = $prime2;
    my $multiplier = 2;
    while ( $n !~ m/$prime1 \z/xms ) {
        my $potential_multiplier = 10;    ## no critic (ProhibitMagicNumbers)
        while ( $n % $potential_multiplier == $prime1 % $potential_multiplier )
        {
            $multiplier = $potential_multiplier;
            $potential_multiplier *= 10;    ## no critic (ProhibitMagicNumbers)
        }
        $n += $prime2 * $multiplier;
    }
    $sum += $n;
}

printf "%d\n", $sum;

sub get_primes_up_to {
    my ($limit) = @_;                       ## no critic (ProhibitReusedNames)

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

134.pl

Prime pair connection

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Prime pair connection". The
problem is: Find · S for every pair of consecutive primes with 5 ² p1 ² 1000000.

=head1 EXAMPLES

    perl 134.pl

=head1 USAGE

    134.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum prime.

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
