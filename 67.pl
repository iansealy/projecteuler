#!/usr/bin/env perl

# PODNAME: 67.pl
# ABSTRACT: Maximum path sum II

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-08-28

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
Readonly our $TRIANGLE_URL =>
  'https://projecteuler.net/project/resources/p067_triangle.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $triangle = get($TRIANGLE_URL);

# Prepare triangle
my @triangle;
my @lines = split /\n/xms, $triangle;
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

67.pl

Maximum path sum II

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Maximum path sum II". The problem
is: Find the maximum total from top to bottom in triangle.txt, a 15K text file
containing a triangle with one-hundred rows.

=head1 EXAMPLES

    perl 67.pl

=head1 USAGE

    67.pl
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
