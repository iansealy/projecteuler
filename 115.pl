#!/usr/bin/env perl

# PODNAME: 115.pl
# ABSTRACT: Counting block combinations II

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-07-30

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use Memoize qw( memoize );

# Constants
Readonly our $TARGET => 1_000_000;

# Default options
my $m = 50;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

memoize('ways');

my $n = $m + 1;
while ( ways( $m, $n ) <= $TARGET ) {
    $n++;
}

printf "%d\n", $n;

# Count ways
sub ways {
    my ( $min_block, $total_length ) = @_;

    my $count = 1;    # All empty

    if ( $total_length < $min_block ) {
        return $count;
    }

    foreach my $start ( 0 .. $total_length - $min_block ) {
        foreach my $block_length ( $min_block .. $total_length - $start ) {
            $count +=
              ways( $min_block, $total_length - $start - $block_length - 1 );
        }
    }

    return $count;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'm=i'   => \$m,
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

115.pl

Counting block combinations II

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Counting block combinations II".
The problem is: For m = 50, find the least value of n for which the fill-count
function first exceeds one million.

=head1 EXAMPLES

    perl 115.pl

=head1 USAGE

    115.pl
        [--m INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--m INT>

Minimum block length.

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
