#!/usr/bin/env perl

# PODNAME: 18.pl
# ABSTRACT: Maximum path sum I

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-03-20

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $TRIANGLE => <<'END';
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
END

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

# Prepare triangle
my @triangle;
my @lines = split /\n/xms, $TRIANGLE;
foreach my $line (@lines) {
    push @triangle, [ split /\s+/xms, $line ];
}

foreach my $i ( reverse 0 .. scalar @triangle - 2 ) {
    foreach my $j ( 0 .. scalar @{ $triangle[$i] } - 1 ) {
        my $parent1 = $triangle[ $i + 1 ]->[$j];
        my $parent2 = $triangle[ $i + 1 ]->[ $j + 1 ];
        $triangle[$i]->[$j] += $parent1 > $parent2 ? $parent1 : $parent2;
    }
}

printf "%d\n", $triangle[0]->[0];

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

18.pl

Maximum path sum I

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Maximum path sum I". The problem
is: Find the maximum total from top to bottom of the triangle below:

=head1 EXAMPLES

    perl 18.pl

=head1 USAGE

    18.pl
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
