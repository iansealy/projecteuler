#!/usr/bin/env perl

# PODNAME: 54.pl
# ABSTRACT: Poker hands

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-07-18

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
Readonly our $HANDS_URL =>
  'https://projecteuler.net/project/resources/p054_poker.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $player1_wins = 0;

my $hands = get($HANDS_URL);
foreach my $cards ( split /[\r\n]+/xms, $hands ) {
    my @cards = split /\s/xms, $cards;
    ## no critic (ProhibitMagicNumbers)
    my @hand1 = @cards[ 0 .. 4 ];
    my @hand2 = @cards[ 5 .. 9 ];
    ## use critic
    if ( score(@hand1) gt score(@hand2) ) {
        $player1_wins++;
    }
}

printf "%d\n", $player1_wins;

sub score {
    my (@hand) = @_;

    my @ranks;
    my @suits;
    my %rank_count;
    my %suit_count;
    foreach my $card (@hand) {
        $card =~ tr/TJQKA/ABCDE/;
        my ( $rank, $suit ) = split //xms, $card;
        push @ranks, $rank;
        push @suits, $suit;
        $rank_count{$rank}++;
        $suit_count{$suit}++;
    }
    @ranks = sort @ranks;

    my $flush = scalar keys %suit_count == 1 ? 1 : 0;

    ## no critic (ProhibitMagicNumbers)
    my $straight = scalar keys %rank_count == 5
      && hex( $ranks[-1] ) - hex( $ranks[0] ) == 4 ? 1 : 0;

    my $score = $flush && $straight             ? 9    # Straight flush
      : ( grep { $_ == 4 } values %rank_count ) ? 8    # Four of a kind
      : scalar keys %rank_count == 2            ? 7    # Full house
      : $flush                                  ? 6    # Flush
      : $straight                               ? 5    # Straight
      : ( grep { $_ == 3 } values %rank_count ) ? 4    # Three of a kind
      : scalar keys %rank_count == 3            ? 3    # Two pair
      : scalar keys %rank_count == 4            ? 2    # One pair
      :                                           1    # High card
      ;
    ## use critic

    foreach my $rank (
        reverse sort { $rank_count{$a} <=> $rank_count{$b} || $a cmp $b }
        keys %rank_count
      )
    {
        $score .= $rank x $rank_count{$rank};
    }

    return $score;
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

54.pl

Poker hands

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Poker hands". The problem is: How
many hands does Player 1 win?

=head1 EXAMPLES

    perl 54.pl

=head1 USAGE

    54.pl
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
