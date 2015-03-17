#!/usr/bin/env perl

# PODNAME: 17.pl
# ABSTRACT: Number letter counts

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-03-17

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 1000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $sum = 0;
foreach my $number ( 1 .. $limit ) {
    $sum += length get_in_words($number);
}

printf "%d\n", $sum;

sub get_in_words {
    my ($num) = @_;

    ## no critic (ProhibitMagicNumbers)
    my %unit_for = (
        1 => 'one',
        2 => 'two',
        3 => 'three',
        4 => 'four',
        5 => 'five',
        6 => 'six',
        7 => 'seven',
        8 => 'eight',
        9 => 'nine',
    );

    my %teen_for = (
        11 => 'eleven',
        12 => 'twelve',
        13 => 'thirteen',
        14 => 'fourteen',
        15 => 'fifteen',
        16 => 'sixteen',
        17 => 'seventeen',
        18 => 'eighteen',
        19 => 'nineteen',
    );

    my %tens_for = (
        1 => 'ten',
        2 => 'twenty',
        3 => 'thirty',
        4 => 'forty',
        5 => 'fifty',
        6 => 'sixty',
        7 => 'seventy',
        8 => 'eighty',
        9 => 'ninety',
    );
    ## use critic

    # 1000 is only possible 4 digit number
    return 'onethousand' if $num == 1000;    ## no critic (ProhibitMagicNumbers)

    # Deal with 100s (don't require "and")
    if ( $num =~ m/\A ([1-9]) 00 \z/xms ) {
        return $unit_for{$1} . 'hundred';
    }

    my $words = q{};

    # Deal with 100s part of 3 digit number and leave 1 or 2 digit number
    if ( $num =~ m/\A ([1-9]) (\d{2}) \z/xms ) {
        $words .= $unit_for{$1} . 'hundredand';
        $num = $2;
    }

    # Numbers ending 01 to 09 (or just 1 to 9)
    ## no critic (ProhibitMagicNumbers)
    return $words . $unit_for{ $num * 1 } if $num < 10;
    ## use critic

    # Numbers ending 10, 20 .. 80, 90
    if ( $num =~ m/\A ([1-9]) 0 \z/xms ) {
        return $words . $tens_for{$1};
    }

    # Numbers ending 11 to 19
    ## no critic (ProhibitMagicNumbers)
    return $words . $teen_for{$num} if $num < 20;
    ## use critic

    # Remaining two digit numbers
    if ( $num =~ m/\A ([1-9]) ([1-9]) \z/xms ) {
        return $words . $tens_for{$1} . $unit_for{$2};
    }
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'limit=i' => \$limit,
        'debug'   => \$debug,
        'help'    => \$help,
        'man'     => \$man,
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

17.pl

Number letter counts

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Number letter counts". The
problem is: If all the numbers from 1 to 1000 (one thousand) inclusive were
written out in words, how many letters would be used?

=head1 EXAMPLES

    perl 17.pl --limit 5

=head1 USAGE

    17.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The highest number to convert.

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
