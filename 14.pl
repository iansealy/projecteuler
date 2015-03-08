#!/usr/bin/env perl

# PODNAME: 14.pl
# ABSTRACT: Longest Collatz sequence

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-03-08

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 1_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my %cache;

my $longest_chain_length = 0;
my $longest_chain_start  = 1;

foreach my $start ( 2 .. $limit ) {
    my $length = 0;
    my $number = $start;
    while ( $number > 1 ) {

        # Check if rest of chain is cached
        if ( exists $cache{$number} ) {
            $length += $cache{$number};
            last;
        }

        $length++;
        if ( $number % 2 ) {

            # Number is odd
            $number = 3 * $number + 1;    ## no critic (ProhibitMagicNumbers)
        }
        else {
            # Number is even
            $number /= 2;
        }
    }
    $cache{$start} = $length;
    if ( $length > $longest_chain_length ) {
        $longest_chain_length = $length;
        $longest_chain_start  = $start;
    }
}

printf "%d\n", $longest_chain_start;

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

14.pl

Longest Collatz sequence

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Longest Collatz sequence". The
problem is: Which starting number, under one million, produces the longest
chain?

=head1 EXAMPLES

    perl 14.pl

=head1 USAGE

    14.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The starting number below which to find the longest Collatz sequence.

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
