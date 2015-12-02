#!/usr/bin/env perl

# PODNAME: 58.pl
# ABSTRACT: Spiral primes

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-07-30

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

my $prime_diagonals = 0;
my $total_diagonals = 0;

my $width     = 1;
my $increment = 0;
my $number    = 1;

## no critic (ProhibitMagicNumbers)
while ( !$total_diagonals || $prime_diagonals / $total_diagonals > 0.1 ) {
    ## use critic
    $width     += 2;
    $increment += 2;

    ## no critic (ProhibitMagicNumbers)
    $total_diagonals += 4;
    foreach ( 1 .. 4 ) {
        ## use critic
        $number += $increment;
        if ( is_prime($number) ) {
            $prime_diagonals++;
        }
    }
}

printf "%d\n", $width;

sub is_prime {
    my ($num) = @_;

    return 0 if $num == 1;    # 1 isn't prime
    ## no critic (ProhibitMagicNumbers)
    return 1 if $num < 4;         # 2 and 3 are prime
    return 0 if $num % 2 == 0;    # Even numbers aren't prime
    return 1 if $num < 9;         # 5 and 7 are prime
    return 0 if $num % 3 == 0;    # Numbers divisible by 3 aren't prime
    ## use critic

    my $num_sqrt = int sqrt $num;
    my $factor   = 5;               ## no critic (ProhibitMagicNumbers)
    while ( $factor <= $num_sqrt ) {
        return 0 if $num % $factor == 0;    # Primes greater than three are 6k-1
        return 0 if $num % ( $factor + 2 ) == 0;    # Or 6k+1
        $factor += 6;    ## no critic (ProhibitMagicNumbers)
    }
    return 1;
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

58.pl

Spiral primes

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Spiral primes". The problem is:
If one complete new layer is wrapped around the spiral above, a square spiral
with side length 9 will be formed. If this process is continued, what is the
side length of the square spiral for which the ratio of primes along both
diagonals first falls below 10%?

=head1 EXAMPLES

    perl 58.pl

=head1 USAGE

    58.pl
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
