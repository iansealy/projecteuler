#!/usr/bin/env perl

# PODNAME: 104.pl
# ABSTRACT: Pandigital Fibonacci ends

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-06-03

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

use Readonly;
use List::Util qw(any);

# Constants
Readonly our $BASE      => 10;
Readonly our $DIGITS    => 9;
Readonly our $LOG_PHI   => log10( ( 1 + sqrt 5 ) / 2 );
Readonly our $LOG_ROOT5 => log10(5) / 2;

my $k               = 2;
my @fib1            = (1);
my @fib2            = (1);
my $ends_pandigital = 0;
while ( !$ends_pandigital ) {
    $k++;
    my $carry = 0;
    my @sum;
    foreach my $digit ( 0 .. ( scalar @fib2 ) - 1 ) {
        my $sum = $fib2[$digit] + ( $fib1[$digit] || 0 ) + ( $carry || 0 );
        ## no critic (ProhibitMagicNumbers)
        my $last_digit_of_sum = substr $sum, -1, 1, q{};
        ## use critic
        push @sum, $last_digit_of_sum;
        $carry = $sum;
    }
    my @carry_digits = split //xms, $carry;
    push @sum, reverse @carry_digits;
    @fib1 = splice @fib2, 0, $DIGITS;
    @fib2 = splice @sum,  0, $DIGITS;
    next if !is_pandigital(@fib2);
    my $log_fibk = $k * $LOG_PHI - $LOG_ROOT5;
    my $fibk     = $BASE**( $log_fibk - int $log_fibk );
    last
      if is_pandigital( split //xms, substr $fibk * $BASE**$DIGITS, 0,
        $DIGITS );
}

printf "%d\n", $k;

sub is_pandigital {
    my (@digits) = @_;

    return 0 if any { $_ == 0 } @digits;

    my %digit = map { $_ => 1 } @digits;

    return scalar keys %digit == $DIGITS;
}

sub log10 {
    my ($n) = @_;

    return ( log $n ) / log $BASE;
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

104.pl

Pandigital Fibonacci ends

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Pandigital Fibonacci ends". The
problem is: Given that Fk is the first Fibonacci number for which the first nine
digits AND the last nine digits are 1-9 pandigital, find k.

=head1 EXAMPLES

    perl 104.pl

=head1 USAGE

    104.pl
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

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
