#!/usr/bin/env perl

# PODNAME: 56.pl
# ABSTRACT: Powerful digit sum

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-07-24

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $LIMIT => 99;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $max_digit_sum = 0;

foreach my $a ( 2 .. $LIMIT ) {
    my @digits = reverse split //xms, $a;
    foreach ( 2 .. $LIMIT ) {
        my @new_digits;
        my $carry = 0;
        foreach my $digit (@digits) {
            my $product = $digit * $a + ( $carry || 0 );
            ## no critic (ProhibitMagicNumbers)
            my $last_digit_of_product = substr $product, -1, 1, q{};
            ## use critic
            push @new_digits, $last_digit_of_product;
            $carry = $product;
        }
        my @carry_digits = split //xms, $carry;
        push @new_digits, reverse @carry_digits;
        @digits = @new_digits;
        my $digit_sum = 0;
        foreach my $digit (@digits) {
            $digit_sum += $digit;
        }
        if ( $digit_sum > $max_digit_sum ) {
            $max_digit_sum = $digit_sum;
        }
    }
}

printf "%d\n", $max_digit_sum;

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

56.pl

Powerful digit sum

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Powerful digit sum". The problem
is: Considering natural numbers of the form, a^b, where a, b < 100, what is the
maximum digital sum?

=head1 EXAMPLES

    perl 56.pl

=head1 USAGE

    56.pl
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
