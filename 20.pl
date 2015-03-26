#!/usr/bin/env perl

# PODNAME: 20.pl
# ABSTRACT: Factorial digit sum

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-03-26

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $factorial = 100;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @digits = (1);

foreach my $number ( 1 .. $factorial ) {
    my @multiplied_digits = ();
    my $carry             = 0;
    foreach my $digit (@digits) {
        my $sum = $digit * $number + ( $carry || 0 );
        ## no critic (ProhibitMagicNumbers)
        my $last_digit_of_sum = substr $sum, -1, 1, q{};
        ## use critic
        push @multiplied_digits, $last_digit_of_sum;
        $carry = $sum;
    }
    my @carry_digits = split //xms, $carry;
    push @multiplied_digits, reverse @carry_digits;
    @digits = @multiplied_digits;
}

my $digits_sum = 0;
foreach my $digit (@digits) {
    $digits_sum += $digit;
}

printf "%d\n", $digits_sum;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'factorial=i' => \$factorial,
        'debug'       => \$debug,
        'help'        => \$help,
        'man'         => \$man,
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

20.pl

Factorial digit sum

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Factorial digit sum". The problem
is: Find the sum of the digits in the number 100!

=head1 EXAMPLES

    perl 20.pl --factorial 10

=head1 USAGE

    20.pl
        [--factorial INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--factorial INT>

The number to sum the factorial of.

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
