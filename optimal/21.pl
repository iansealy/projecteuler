#!/usr/bin/env perl

# PODNAME: 21.pl
# ABSTRACT: Amicable numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-01

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 10_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $sum = 0;

foreach my $a ( 2 .. $limit - 1 ) {
    my $b = sum_proper_divisors($a);
    if ( $b > $a ) {
        if ( sum_proper_divisors($b) == $a ) {
            $sum += $a + $b;
        }
    }
}

printf "%d\n", $sum;

sub sum_proper_divisors {
    my ($number) = @_;

    return sum_divisors($number) - $number;
}

sub sum_divisors {
    my ($number) = @_;

    my $divisor_sum = 1;
    my $prime       = 2;

    while ( $prime * $prime <= $number && $number > 1 ) {
        if ( $number % $prime == 0 ) {
            my $j = $prime * $prime;
            $number /= $prime;
            while ( $number % $prime == 0 ) {
                $j *= $prime;
                $number /= $prime;
            }
            $divisor_sum *= ( $j - 1 );
            $divisor_sum /= ( $prime - 1 );
        }
        if ( $prime == 2 ) {
            $prime = 3;    ## no critic (ProhibitMagicNumbers)
        }
        else {
            $prime += 2;
        }
    }
    if ( $number > 1 ) {
        $divisor_sum *= ( $number + 1 );
    }

    return $divisor_sum;
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

21.pl

Amicable numbers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Amicable numbers". The problem is:
Evaluate the sum of all the amicable numbers under 10000.

=head1 EXAMPLES

    perl 21.pl

=head1 USAGE

    21.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum amicable number.

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
