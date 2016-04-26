#!/usr/bin/env perl

# PODNAME: 98.pl
# ABSTRACT: Anagramic squares

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-04-26

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use LWP::Simple;
use Text::CSV;

# Constants
Readonly our $WORDS_URL =>
  'https://projecteuler.net/project/resources/p098_words.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $words = get($WORDS_URL);
my $csv = Text::CSV->new( { binary => 1 } );
$csv->parse($words);
my @words = sort $csv->fields();

# Get anagrams
my %anagram;
foreach my $word (@words) {
    my $sorted_word = join q{}, sort split //xms, $word;
    push @{ $anagram{$sorted_word} }, $word;
}
my @anagrams =
  reverse sort { length $a->[0] <=> length $b->[0] }
  map { $anagram{$_} } grep { scalar @{ $anagram{$_} } > 1 } keys %anagram;

# Get all squares
my @squares = (1);
my $n       = 1;
my $n2      = 1;
my $limit   = length $anagrams[0][0];
while ( length $n2 <= $limit ) {
    $n++;
    $n2 = $n * $n;
    push @squares, $n2;
}

my $max_square = 0;
foreach my $anagram_set (@anagrams) {

    # Get all pairs of anagrams
    foreach my $i ( 0 .. scalar @{$anagram_set} - 2 ) {
        foreach my $j ( $i + 1 .. scalar @{$anagram_set} - 1 ) {
            my $anagram1 = $anagram_set->[$i];
            my $anagram2 = $anagram_set->[$j];
            my %is_square =
              map { $_ => 1 } grep { length $_ == length $anagram1 } @squares;
            foreach my $square ( sort keys %is_square ) {
                my @anagram1 = split //xms, $anagram1;
                my @square   = split //xms, $square;
                my %translation = map { $anagram1[$_] => $square[$_] }
                  ( 0 .. scalar @square - 1 );
                my %digit = map { $_ => 1 } values %translation;
                next if scalar keys %translation != scalar keys %digit;
                my $tr_anagram2 = join q{},
                  map { $translation{$_} } split //xms, $anagram2;
                if ( $is_square{$tr_anagram2} && $square > $max_square ) {
                    $max_square = $square;
                }
                if ( $is_square{$tr_anagram2} && $tr_anagram2 > $max_square ) {
                    $max_square = $tr_anagram2;
                }
            }
        }
    }
}

printf "%d\n", $max_square;

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

98.pl

Anagramic squares

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Anagramic squares". The problem
is: What is the largest square number formed by any member of such a pair?

=head1 EXAMPLES

    perl 98.pl

=head1 USAGE

    98.pl
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
