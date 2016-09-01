#!/usr/bin/env perl

# PODNAME: 105.pl
# ABSTRACT: Special subset sums: testing

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-06-08

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use LWP::Simple;
use List::Util qw(sum notall);
use Algorithm::Combinatorics qw(variations_with_repetition combinations);

# Constants
Readonly our $SETS_URL =>
  'https://projecteuler.net/project/resources/p105_sets.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $total = 0;
foreach my $candidate_set ( split /\s+/xms, get($SETS_URL) ) {
    my @candidate_set = split /,/xms, $candidate_set;
    if ( is_special_sum_set(@candidate_set) ) {
        $total += sum(@candidate_set);
    }
}

printf "%d\n", $total;

sub is_special_sum_set {
    my (@candidate_set) = @_;

    my $n = scalar @candidate_set;

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

    # Get all subsets
    my %subsets_by_sum;
    my @subsets;
    my @sums;
    my @lengths;
    foreach my $subset_idx (@subset_idxs) {
        my @subset =
          @candidate_set[ grep { $subset_idx->[$_] == 1 } ( 0 .. $n - 1 ) ];
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
            return 0 if disjoint( $pair->[0], $pair->[1] );
        }
    }

    # Check for disjoint subsets of different lengths and sums
    my $pair_iterator = combinations( [ 0 .. scalar @subsets - 1 ], 2 );
    while ( my $pair = $pair_iterator->next ) {
        my ( $i, $j ) = @{$pair};
        next if $lengths[$i] == $lengths[$j];
        next if $sums[$i] == $sums[$j];
        if (
            (
                   ( $lengths[$i] > $lengths[$j] && $sums[$i] < $sums[$j] )
                || ( $lengths[$j] > $lengths[$i] && $sums[$j] < $sums[$i] )
            )
            && disjoint( $subsets[$i], $subsets[$j] )
          )
        {
            return 0;
        }
    }

    return 1;
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

105.pl

Special subset sums: testing

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Special subset sums: testing". The
problem is: Using sets.txt, a 4K text file with one-hundred sets containing
seven to twelve elements, identify all the special sum sets, A1, A2, ..., Ak,
and find the value of S(A1) + S(A2) + ... + S(Ak).

=head1 EXAMPLES

    perl 105.pl

=head1 USAGE

    105.pl
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
