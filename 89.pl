#!/usr/bin/env perl

# PODNAME: 89.pl
# ABSTRACT: Roman numerals

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-03-02

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use LWP::Simple;

# Constants
Readonly our $ROMAN_URL =>
  'https://projecteuler.net/project/resources/p089_roman.txt';
Readonly our %TO_DECIMAL => (
    I => 1,
    V => 5,
    X => 10,
    L => 50,
    C => 100,
    D => 500,
    M => 1000,
);
Readonly our @PAIR_THOUSAND => ( 1000, q{M} );
Readonly our @PAIR_HUNDRED  => ( 100,  q{C} );
Readonly our @PAIR_TEN      => ( 10,   q{X} );
Readonly our @PAIR_ONE      => ( 1,    q{I} );
Readonly our @PAIRS_HUNDREDS =>
  ( [ 900, q{CM} ], [ 500, q{D} ], [ 400, q{CD} ] );
Readonly our @PAIRS_TENS  => ( [ 90, q{XC} ], [ 50, q{L} ], [ 40, q{XL} ] );
Readonly our @PAIRS_UNITS => ( [ 9,  q{IX} ], [ 5,  q{V} ], [ 4,  q{IV} ] );

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @non_minimal_numbers = split /\n/xms, get($ROMAN_URL);

my $minimal_length     = 0;
my $non_minimal_length = 0;
foreach my $number (@non_minimal_numbers) {
    $non_minimal_length += length $number;
    my $minimal_number = to_roman( to_decimal($number) );
    $minimal_length += length $minimal_number;
}

printf "%d\n", $non_minimal_length - $minimal_length;

sub to_decimal {
    my ($roman) = @_;

    my $decimal = 0;

    while ($roman) {
        if ( $roman =~ m/\A (IV|IX|XL|XC|CD|CM)/xms ) {
            my ( $num1, $num2 ) = split //xms, substr $roman, 0, 2, q{};
            $decimal += $TO_DECIMAL{$num2} - $TO_DECIMAL{$num1};
        }
        else {
            my ($num) = substr $roman, 0, 1, q{};
            $decimal += $TO_DECIMAL{$num};
        }
    }

    return $decimal;
}

sub to_roman {
    my ($decimal) = @_;

    my $roman = q{};
    ( $decimal, $roman ) = repeats( $decimal, $roman, @PAIR_THOUSAND );
    foreach my $pair (@PAIRS_HUNDREDS) {
        ( $decimal, $roman ) =
          singles( $decimal, $roman, $pair->[0], $pair->[1] );
    }
    ( $decimal, $roman ) = repeats( $decimal, $roman, @PAIR_HUNDRED );
    foreach my $pair (@PAIRS_TENS) {
        ( $decimal, $roman ) =
          singles( $decimal, $roman, $pair->[0], $pair->[1] );
    }
    ( $decimal, $roman ) = repeats( $decimal, $roman, @PAIR_TEN );
    foreach my $pair (@PAIRS_UNITS) {
        ( $decimal, $roman ) =
          singles( $decimal, $roman, $pair->[0], $pair->[1] );
    }
    ( $decimal, $roman ) = repeats( $decimal, $roman, @PAIR_ONE );

    return $roman;
}

sub repeats {
    my ( $decimal, $roman, $divisor, $roman_numeral ) = @_;

    my $quotient = int $decimal / $divisor;
    my $modulus  = $decimal % $divisor;

    return $modulus, $roman . ( $roman_numeral x $quotient );
}

sub singles {
    my ( $decimal, $roman, $combination_decimal, $combination_roman ) = @_;

    if ( $decimal >= $combination_decimal ) {
        $decimal -= $combination_decimal;
        $roman .= $combination_roman;
    }

    return $decimal, $roman;
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

89.pl

Roman numerals

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Roman numerals". The problem is:
Find the number of characters saved by writing each of these in their minimal
form.

=head1 EXAMPLES

    perl 89.pl

=head1 USAGE

    89.pl
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
