#!/usr/bin/env perl

# PODNAME: 81.pl
# ABSTRACT: Path sum: two ways

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-10-22

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
my $url = 'https://projecteuler.net/project/resources/p081_matrix.txt';
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
$sum[1][0] = 0;
$sum[0][1] = 0;

foreach my $i ( 1 .. $rows ) {
    foreach my $j ( 1 .. $cols ) {
        $sum[$i][$j] = $matrix[ $i - 1 ][ $j - 1 ];
        if ( !defined $sum[ $i - 1 ][$j] ) {
            $sum[$i][$j] += $sum[$i][ $j - 1 ];
        }
        elsif ( !defined $sum[$i][ $j - 1 ] ) {
            $sum[$i][$j] += $sum[ $i - 1 ][$j];
        }
        elsif ( $sum[ $i - 1 ][$j] < $sum[$i][ $j - 1 ] ) {
            $sum[$i][$j] += $sum[ $i - 1 ][$j];
        }
        else {
            $sum[$i][$j] += $sum[$i][ $j - 1 ];
        }
    }
}

printf "%d\n", $sum[$rows][$cols];

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

81.pl

Path sum: two ways

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Path sum: two ways". The problem
is: Find the minimal path sum, in matrix.txt, a 31K text file containing a 80 by
80 matrix, from the top left to the bottom right by only moving right and down.

=head1 EXAMPLES

    perl 81.pl

=head1 USAGE

    81.pl
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
