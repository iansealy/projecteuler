#!/usr/bin/env perl

# PODNAME: 96.pl
# ABSTRACT: Su Doku

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-04-04

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use LWP::Simple;
use List::Util qw(sum);

# Constants
Readonly our $SUDOKU_URL =>
  'https://projecteuler.net/project/resources/p096_sudoku.txt';
Readonly our $NINE       => 9;
Readonly our @NUMS       => ( 1 .. 9 );
Readonly our $TARGET     => sum( 1 .. 9 ) * 9;
Readonly our $LAST       => 9 * 9 - 1;
Readonly our @BOX_STARTS => ( 0, 3, 6, 27, 30, 33, 54, 57, 60 );

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $total = 0;

my $sudokus = get($SUDOKU_URL);
$sudokus =~ s/\n//xmsg;
$sudokus =~ s/Grid\s\d\d/\n/xmsg;
$sudokus =~ s/\A \n//xms;
foreach my $sudoku ( split /\n/xms, $sudokus ) {
    my @sudoku = split //xms, $sudoku;
    @sudoku = solve(@sudoku);
    my $num = join q{}, @sudoku[ 0, 1, 2 ];
    $total += $num;
}

printf "%d\n", $total;

sub solve {
    my @sudoku = @_;

    my $prev_sum = sum(@sudoku);
    while (1) {
        @sudoku = check_candidates(@sudoku);
        @sudoku = find_places(@sudoku);
        my $new_sum = sum(@sudoku);
        last if $prev_sum == $new_sum;
        $prev_sum = $new_sum;
    }

    @sudoku = brute_force(@sudoku);

    return @sudoku;
}

sub check_candidates {
    my @sudoku = @_;

    foreach my $cell ( 0 .. $LAST ) {
        next if $sudoku[$cell];
        my @possible = possible( $cell, @sudoku );
        if ( scalar @possible == 1 ) {
            $sudoku[$cell] = $possible[0];
        }
    }

    return @sudoku;
}

sub find_places {
    my @sudoku = @_;

    my @cells;

    # Columns
    foreach my $col_start ( row(0) ) {
        push @cells, [ col($col_start) ];
    }

    # Rows
    foreach my $row_start ( col(0) ) {
        push @cells, [ row($row_start) ];
    }

    # Boxes
    foreach my $box_start (@BOX_STARTS) {
        push @cells, [ box($box_start) ];
    }

    foreach my $cells (@cells) {
        my %place;
        foreach my $cell ( @{$cells} ) {
            next if $sudoku[$cell];
            foreach my $possible ( possible( $cell, @sudoku ) ) {
                $place{$possible}{$cell} = 1;
            }
        }
        foreach my $possible ( sort keys %place ) {
            if ( scalar keys %{ $place{$possible} } == 1 ) {
                my $cell = ( keys %{ $place{$possible} } )[0];
                $sudoku[$cell] = $possible;
            }
        }
    }

    return @sudoku;
}

sub brute_force {
    my (@sudoku) = @_;

    foreach my $cell ( 0 .. $LAST ) {
        next if $sudoku[$cell];
        my @possible = possible( $cell, @sudoku );
        foreach my $possible (@possible) {
            my @candidate_sudoku = @sudoku;
            $candidate_sudoku[$cell] = $possible;
            @candidate_sudoku = brute_force(@candidate_sudoku);
            return @candidate_sudoku if @candidate_sudoku;
        }
        return;
    }

    return @sudoku;
}

sub possible {
    my ( $cell, @sudoku ) = @_;

    my %possible = map { $_ => 1 } @NUMS;

    foreach my $adj_cell ( row($cell), col($cell), box($cell) ) {
        if ( $sudoku[$adj_cell] ) {
            delete $possible{ $sudoku[$adj_cell] };
        }
    }

    my @possible = sort { $a <=> $b } keys %possible;

    return @possible;
}

sub row {
    my ($cell) = @_;

    my $row_start = int( $cell / $NINE ) * $NINE;

    return ( $row_start .. $row_start + $NINE - 1 );
}

sub col {
    my ($cell) = @_;

    my $col_start = $cell % $NINE;

    my @col;

    my $i = 0;
    while ( scalar @col < $NINE ) {
        push @col, $col_start + ( $i * $NINE );
        $i++;
    }

    return @col;
}

sub box {
    my ($cell) = @_;

    ## no critic (ProhibitMagicNumbers)
    my $box_start =
      $NINE * 3 * int( $cell / $NINE / 3 ) + 3 * int( ( $cell % $NINE ) / 3 );
    ## use critic

    my @box = (
        $box_start .. $box_start + 2,
        $box_start + $NINE .. $box_start + $NINE + 2,
        $box_start + $NINE * 2 .. $box_start + $NINE * 2 + 2,
    );

    return @box;
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

96.pl

Su Doku

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Su Doku". The problem is: By
solving all fifty puzzles find the sum of the 3-digit numbers found in the top
left corner of each solution grid; for example, 483 is the 3-digit number found
in the top left corner of the solution grid above.

=head1 EXAMPLES

    perl 96.pl

=head1 USAGE

    96.pl
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
