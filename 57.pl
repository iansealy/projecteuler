#!/usr/bin/env perl

# PODNAME: 57.pl
# ABSTRACT: Square root convergents

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-07-27

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $LIMIT => 1000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $num_fractions = 0;

## no critic (ProhibitMagicNumbers)
my @denom_prev1 = (5);
my @denom_prev2 = (2);
foreach ( 3 .. $LIMIT ) {
    ## use critic
    my @denom;
    my @numer;
    my $carry_denom = 0;
    my $carry_numer = 0;
    foreach my $digit (@denom_prev1) {
        my $prev2_digit = shift @denom_prev2 || 0;
        my $sum_denom = 2 * $digit + $prev2_digit + ( $carry_denom || 0 );
        my $sum_numer = 3 * $digit + $prev2_digit + ( $carry_numer || 0 );
        ## no critic (ProhibitMagicNumbers)
        my $last_digit_of_sum_denom = substr $sum_denom, -1, 1, q{};
        my $last_digit_of_sum_numer = substr $sum_numer, -1, 1, q{};
        ## use critic
        push @denom, $last_digit_of_sum_denom;
        push @numer, $last_digit_of_sum_numer;
        $carry_denom = $sum_denom;
        $carry_numer = $sum_numer;
    }
    my @carry_digits_denom = split //xms, $carry_denom;
    push @denom, reverse @carry_digits_denom;
    my @carry_digits_numer = split //xms, $carry_numer;
    push @numer, reverse @carry_digits_numer;
    if ( scalar @numer > scalar @denom ) {
        $num_fractions++;
    }
    @denom_prev2 = @denom_prev1;
    @denom_prev1 = @denom;
}

printf "%d\n", $num_fractions;

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

57.pl

Square root convergents

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Square root convergents". The
problem is: In the first one-thousand expansions, how many fractions contain a
numerator with more digits than denominator?

=head1 EXAMPLES

    perl 57.pl

=head1 USAGE

    57.pl
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
