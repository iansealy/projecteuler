#!/usr/bin/env perl

# PODNAME: 107.pl
# ABSTRACT: Minimal network

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-06-19

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
Readonly our $NETWORK_URL =>
  'https://projecteuler.net/project/resources/p107_network.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @matrix = split /[\r\n]+/xms, get($NETWORK_URL);
my $num_vertices = scalar split /,/xms, $matrix[0];
my @edges;
my $total_weight;
foreach my $from_node ( 1 .. $num_vertices ) {
    my @weights = split /,/xms, $matrix[ $from_node - 1 ];
    foreach my $to_node ( 1 .. $num_vertices ) {
        my $weight = $weights[ $to_node - 1 ];
        next if $weight eq q{-};
        next if $from_node >= $to_node;
        $total_weight += $weight;
        push @edges, [ $weight, $from_node, $to_node ];
    }
}
@edges = sort { $a->[0] <=> $b->[0] } @edges;

my %graph;
my $minimum_weight;
while ( my $edge = shift @edges ) {
    my ( $weight, $node1, $node2 ) = @{$edge};

    my %undiscovered = map { $_ => 1 } ( 1 .. $num_vertices );
    my @s = ($node1);
    while (@s) {
        my $v = pop @s;
        if ( exists $undiscovered{$v} ) {
            delete $undiscovered{$v};
            push @s, keys %{ $graph{$v} };
        }
    }
    if ( exists $undiscovered{$node2} ) {
        $graph{$node1}{$node2} = $weight;
        $graph{$node2}{$node1} = $weight;
        $minimum_weight += $weight;
    }
}

printf "%d\n", $total_weight - $minimum_weight;

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

107.pl

Minimal network

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Minimal network". The problem is:
Using network.txt, a 6K text file containing a network with forty vertices, and
given in matrix form, find the maximum saving which can be achieved by removing
redundant edges whilst ensuring that the network remains connected.

=head1 EXAMPLES

    perl 107.pl

=head1 USAGE

    107.pl
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
