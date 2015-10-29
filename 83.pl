#!/usr/bin/env perl

# PODNAME: 83.pl
# ABSTRACT: Path sum: four ways

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-10-29

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
my $url = 'https://projecteuler.net/project/resources/p083_matrix.txt';
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

# Label nodes
my @node;
my $node = 0;
foreach my $i ( 0 .. $rows - 1 ) {
    foreach my $j ( 0 .. $cols - 1 ) {
        $node++;
        $node[$i][$j] = $node;
    }
}

# Make graph
my %graph;

# Up
foreach my $i ( 1 .. $rows - 1 ) {
    foreach my $j ( 0 .. $cols - 1 ) {
        $graph{ $node[$i][$j] }{ $node[ $i - 1 ][$j] } = $matrix[ $i - 1 ][$j];
    }
}

# Down
foreach my $i ( 0 .. $rows - 2 ) {
    foreach my $j ( 0 .. $cols - 1 ) {
        $graph{ $node[$i][$j] }{ $node[ $i + 1 ][$j] } = $matrix[ $i + 1 ][$j];
    }
}

# Left
foreach my $i ( 0 .. $rows - 1 ) {
    foreach my $j ( 1 .. $cols - 1 ) {
        $graph{ $node[$i][$j] }{ $node[$i][ $j - 1 ] } = $matrix[$i][ $j - 1 ];
    }
}

# Right
foreach my $i ( 0 .. $rows - 1 ) {
    foreach my $j ( 0 .. $cols - 2 ) {
        $graph{ $node[$i][$j] }{ $node[$i][ $j + 1 ] } = $matrix[$i][ $j + 1 ];
    }
}

# Dijkstra
$node = 1;
my $destination = $rows * $cols;
my %unvisited = map { $_ => 1 } 2 .. $destination;
my %distance;
$distance{$node} = $matrix[0][0];
while ( exists $unvisited{$destination} ) {
    foreach my $next_node ( keys %{ $graph{$node} } ) {
        if ( !exists $distance{$next_node}
            || $distance{$next_node} >
            $distance{$node} + $graph{$node}{$next_node} )
        {
            $distance{$next_node} =
              $distance{$node} + $graph{$node}{$next_node};
        }
    }
    delete $unvisited{$node};
    $node = (
        sort { $distance{$a} <=> $distance{$b} }
        grep { exists $distance{$_} } keys %unvisited
    )[0];
}

printf "%d\n", $distance{$destination};

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

This script solves the Project Euler problem "Path sum: four ways". The problem
is: Find the minimal path sum, in matrix.txt, a 31K text file containing a 80 by
80 matrix, from the top left to the bottom right by moving left, right, up, and
down.

=head1 EXAMPLES

    perl 83.pl

=head1 USAGE

    83.pl
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
