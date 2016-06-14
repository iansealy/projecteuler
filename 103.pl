#!/usr/bin/env perl

# PODNAME: 103.pl
# ABSTRACT: Special subset sums: optimum

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-05-24

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use List::Util qw(sum notall any);
use Algorithm::Combinatorics qw(variations_with_repetition combinations);

# Constants
Readonly our $OFFSET => 2;

# Default options
my $set_size = 7;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @set = (1);       ## no critic (ProhibitAmbiguousNames)
foreach my $n ( 2 .. $set_size ) {
    @set = algorithm_set(@set);
    @set = optimum_set(@set);
}

printf "%s\n", join q{}, @set;

# Get set from previous set using algorithm
sub algorithm_set {
    my (@previous_set) = @_;

    my $middle = @previous_set[ int( scalar @previous_set ) / 2 ];
    ## no critic (ProhibitAmbiguousNames, ProhibitReusedNames)
    my @set = ($middle);
    ## use critic
    foreach my $int (@previous_set) {
        push @set, $middle + $int;
    }

    return @set;
}

# Get optimum set from algorithm set using nearby search
sub optimum_set {
    my (@algo_set) = @_;

    my $n = scalar @algo_set;

    # Make indices for subsets
    my @subset_idxs = variations_with_repetition( [ 0, 1 ], $n );
    @subset_idxs = grep {
        notall { $_ == 1 }
        @{$_}
    } @subset_idxs;
    @subset_idxs = grep {
        notall { $_ == 0 }
        @{$_}
    } @subset_idxs;

    # Check nearby sets
    my $optimum_sum = sum(@algo_set);
    my @optimum_set = @algo_set;
    my $offset_iterator =
      variations_with_repetition( [ -$OFFSET .. $OFFSET ], $n );
  SET: while ( my $offset = $offset_iterator->next ) {
        ## no critic (ProhibitAmbiguousNames, ProhibitReusedNames)
        my @set = map { $algo_set[$_] + $offset->[$_] } ( 0 .. $n - 1 );
        ## use critic
        next SET if any { $_ <= 0 } @set;    # Ensure positive integers

        # Ensure unique integers
        my %seen;
        foreach my $int (@set) {
            next SET if exists $seen{$int};
            $seen{$int} = 1;
        }

        # Skip definitely non-optimal sets
        my $set_sum = sum(@set);    ## no critic (ProhibitAmbiguousNames)
        next SET if $set_sum > $optimum_sum;

        # Get all subsets
        my %subsets_by_sum;
        my @subsets;
        my @sums;
        my @lengths;
        foreach my $subset_idx (@subset_idxs) {
            ## no critic (ProhibitAmbiguousNames)
            my @subset =
              @set[ grep { $subset_idx->[$_] == 1 } ( 0 .. $n - 1 ) ];
            ## use critic
            my $subset_sum = sum(@subset);
            push @{ $subsets_by_sum{$subset_sum} }, \@subset;
            push @subsets, \@subset;
            push @sums,    $subset_sum;
            push @lengths, scalar @subset;
        }

        # Check for disjoint subsets with equal sums
        foreach my $sum ( keys %subsets_by_sum ) {
            next if scalar @{ $subsets_by_sum{$sum} } == 1;
            foreach my $pair ( combinations( $subsets_by_sum{$sum}, 2 ) ) {
                next SET if disjoint( $pair->[0], $pair->[1] );
            }
        }

        # Check for disjoint subsets of different lengths and sums
        my $pair_iterator = combinations( [ 0 .. scalar @subsets - 1 ], 2 );
        while ( my $pair = $pair_iterator->next ) {
            my ( $i, $j ) = @{$pair};
            next if $lengths[$i] == $lengths[$j];
            next if $sums[$i] == $sums[$j];
            next SET
              if ( ( $lengths[$i] > $lengths[$j] && $sums[$i] < $sums[$j] )
                || ( $lengths[$j] > $lengths[$i] && $sums[$j] < $sums[$i] ) )
              && disjoint( $subsets[$i], $subsets[$j] );
        }

        $optimum_sum = $set_sum;
        @optimum_set = sort { $a <=> $b } @set;
    }

    return @optimum_set;
}

sub disjoint {
    my ( $set1, $set2 ) = @_;

    my %seen;
    map { $seen{$_}++ } @{$set1};
    map { $seen{$_}++ } @{$set2};

    if ( notall { $_ == 1 } values %seen ) {
        return 0;
    }
    return 1;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'set_size=i' => \$set_size,
        'debug'      => \$debug,
        'help'       => \$help,
        'man'        => \$man,
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

103.pl

Special subset sums: optimum

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Special subset sums: optimum". The
problem is: Given that A is an optimum special sum set for n = 7, find its set
string.

=head1 EXAMPLES

    perl 103.pl --set_size 5

=head1 USAGE

    103.pl
        [--set_size INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--set_size INT>

The set size.

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
