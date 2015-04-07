#!/usr/bin/env perl

# PODNAME: 23.pl
# ABSTRACT: Non-abundant sums

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-07

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $HIGHEST_ABUNDANT_SUM => 28_123;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @abundant_numbers;
foreach my $num ( 1 .. $HIGHEST_ABUNDANT_SUM ) {
    if ( sum_proper_divisors($num) > $num ) {
        push @abundant_numbers, $num;
    }
}

my %is_abundant_sum;
foreach my $i (@abundant_numbers) {
    foreach my $j (@abundant_numbers) {
        $is_abundant_sum{ $i + $j } = 1;
    }
}

my $sum = 0;
foreach my $num ( 1 .. $HIGHEST_ABUNDANT_SUM ) {
    if ( !exists $is_abundant_sum{$num} ) {
        $sum += $num;
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

23.pl

Non-abundant sums

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Non-abundant sums". The problem
is: Find the sum of all the positive integers which cannot be written as the sum
of two abundant numbers.

=head1 EXAMPLES

    perl 23.pl

=head1 USAGE

    23.pl
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
