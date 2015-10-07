#!/usr/bin/env perl

# PODNAME: 76.pl
# ABSTRACT: Counting summations

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-10-07

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

no warnings 'recursion';    ## no critic (ProhibitNoWarnings)
use Memoize qw( memoize );

# Default options
my $number = 100;           ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

memoize('pentagonal');
memoize('partitions');

printf "%d\n", partitions($number) - 1;

sub partitions {
    my ($n) = @_;

    return 1 if $n == 0;

    my $partitions = 0;
    my $k          = 1;
    while (1) {
        my $pentagonal = pentagonal($k);
        last if $n - $pentagonal < 0;
        ## no critic (ProhibitMagicNumbers)
        $partitions += (-1)**( $k - 1 ) * partitions( $n - $pentagonal );
        ## use critic
        $k = $k > 0 ? -$k : -$k + 1;
    }

    return $partitions;
}

sub pentagonal {
    my ($n) = @_;

    return ( 3 * $n * $n - $n ) / 2;    ## no critic (ProhibitMagicNumbers)
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'number=i' => \$number,
        'debug'    => \$debug,
        'help'     => \$help,
        'man'      => \$man,
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

76.pl

Counting summations

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Counting summations". The problem
is: How many different ways can one hundred be written as a sum of at least two
positive integers?

=head1 EXAMPLES

    perl 76.pl

=head1 USAGE

    76.pl
        [--number INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--number INT>

The number to express as sums.

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
