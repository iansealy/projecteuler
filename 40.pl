#!/usr/bin/env perl

# PODNAME: 40.pl
# ABSTRACT: Champernowne's constant

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-03

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

## no critic (ProhibitMagicNumbers)
printf "%d\n",
  get_digit(1) *
  get_digit(10) *
  get_digit(100) *
  get_digit(1000) *
  get_digit(10_000) *
  get_digit(100_000) *
  get_digit(1_000_000);
## use critic

sub get_digit {
    my ($n) = @_;

    my $num_digits  = 1;
    my $range_start = 1;
    my $range_end   = 9;    ## no critic (ProhibitMagicNumbers)
    while ( $range_end < $n ) {
        $num_digits++;
        $range_start = $range_end + 1;
        $range_end += $num_digits * ( q{9} . q{0} x ( $num_digits - 1 ) );
    }
    my $range_ordinal = int( ( $n - $range_start ) / $num_digits );
    my $first_in_range = q{1} . q{0} x ( $num_digits - 1 );
    my $number         = $first_in_range + $range_ordinal;
    my $digit_ordinal  = $range_ordinal % $num_digits;
    my $digit          = substr $number, $digit_ordinal, 1;

    return $digit;
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

40.pl

Champernowne's constant

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Champernowne's constant". The
problem is: If dn represents the nth digit of the fractional part, find the
value of the following expression.

d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

=head1 EXAMPLES

    perl 40.pl

=head1 USAGE

    40.pl
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
