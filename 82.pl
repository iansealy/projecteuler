#!/usr/bin/env perl

# PODNAME: 82.pl
# ABSTRACT: Path sum: three ways

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-10-25

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use LWP::Simple;
use Text::CSV;

# Default options
my $url = 'https://projecteuler.net/project/resources/p082_matrix.txt';
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @matrix;
my $matrix = get($url);
my $csv = Text::CSV->new( { binary => 1 } );
foreach my $row ( split /[\r\n]+/xms, $matrix ) {
    $csv->parse($row);
    push @matrix, [ $csv->fields() ];
}

my $rows = scalar @matrix;
my $cols = scalar @{ $matrix[0] };
my @sum;
foreach my $i ( 0 .. $rows - 1 ) {
    $sum[$i][0] = $matrix[$i][0];
}

foreach my $j ( 1 .. $cols - 1 ) {
    $sum[0][$j] = $sum[0][ $j - 1 ] + $matrix[0][$j];
    foreach my $i ( 1 .. $rows - 1 ) {
        if ( $sum[$i][ $j - 1 ] < $sum[ $i - 1 ][$j] ) {
            $sum[$i][$j] = $sum[$i][ $j - 1 ] + $matrix[$i][$j];
        }
        else {
            $sum[$i][$j] = $sum[ $i - 1 ][$j] + $matrix[$i][$j];
        }
    }
    foreach my $i ( reverse 0 .. $rows - 2 ) {
        if ( $sum[$i][$j] > $sum[ $i + 1 ][$j] + $matrix[$i][$j] ) {
            $sum[$i][$j] = $sum[ $i + 1 ][$j] + $matrix[$i][$j];
        }
    }
}

my $min = $sum[0][-1];
foreach my $i ( 1 .. $rows - 1 ) {
    if ( $sum[$i][-1] < $min ) {
        $min = $sum[$i][-1];
    }
}

printf "%d\n", $min;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'url=s' => \$url,
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

82.pl

Path sum: three ways

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Path sum: three ways". The problem
is: Find the minimal path sum, in matrix.txt, a 31K text file containing a 80 by
80 matrix, from the left column to the right column.

=head1 EXAMPLES

    perl 82.pl

=head1 USAGE

    82.pl
        [--url URL]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--url URL>

Matrix URL.

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
