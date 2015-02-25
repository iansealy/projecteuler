#!/usr/bin/env perl

# PODNAME: 11.pl
# ABSTRACT: Largest product in a grid

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-02-24

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $NUMBERS_IN_ROW => 4;
Readonly our $GRID           => <<'END';
08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48
END

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

# Prepare grid
my @grid;
my @lines = split /\n/xms, $GRID;
foreach my $line (@lines) {
    push @grid, [ split /\s+/xms, $line ];
}

my $max_product = 0;

# Horizontal lines
foreach my $horizontal (@grid) {
    my $product = get_max_product( @{$horizontal} );
    if ( $product > $max_product ) {
        $max_product = $product;
    }
}

# Vertical lines
foreach my $col ( 0 .. scalar @{ $grid[0] } - 1 ) {
    my @vertical = ();
    foreach my $row ( 0 .. scalar @grid - 1 ) {
        push @vertical, $grid[$row][$col];
    }
    my $product = get_max_product(@vertical);
    if ( $product > $max_product ) {
        $max_product = $product;
    }
}

# Diagonal lines
my @diagonals;
foreach ( 1, 2 ) {
    push @diagonals, [ get_diagonal( 0, 0, \@grid ) ];
    foreach my $col ( 1 .. scalar @grid - $NUMBERS_IN_ROW ) {
        push @diagonals, [ get_diagonal( 0, $col, \@grid ) ];
    }
    foreach my $row ( 1 .. scalar @{ $grid[0] } - $NUMBERS_IN_ROW ) {
        push @diagonals, [ get_diagonal( $row, 0, \@grid ) ];
    }

    # Flip grid, so do other diagonals on second iteration
    @grid = reverse @grid;
}

foreach my $diagonal (@diagonals) {
    my $product = get_max_product( @{$diagonal} );
    if ( $product > $max_product ) {
        $max_product = $product;
    }
}

printf "%d\n", $max_product;

sub get_diagonal {
    my ( $row, $col, $grid ) = @_;

    my @diagonal = ();
    while ( $row < scalar @{$grid} && $col < scalar @{ $grid->[0] } ) {
        push @diagonal, $grid->[$row][$col];
        $row++;
        $col++;
    }

    return @diagonal;
}

sub get_max_product {
    my @numbers = @_;

    my $max = 0;

    foreach my $i ( 0 .. scalar @numbers - $NUMBERS_IN_ROW ) {
        my @subset  = @numbers[ $i .. $i + $NUMBERS_IN_ROW - 1 ];
        my $product = 1;
        foreach my $number (@subset) {
            $product *= $number;
        }
        if ( $product > $max ) {
            $max = $product;
        }
    }

    return $max;
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

11.pl

Largest product in a grid

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Largest product in a grid". The
problem is: What is the greatest product of four adjacent numbers in the same
direction (up, down, left, right, or diagonally) in the 20×20 grid?

=head1 EXAMPLES

    perl 11.pl

=head1 USAGE

    11.pl
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
