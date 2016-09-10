#!/usr/bin/env perl

# PODNAME: 124.pl
# ABSTRACT: Ordered radicals

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-09-10

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
## no critic (ProhibitMagicNumbers)
my $limit   = 100_000;
my $ordinal = 10_000;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @radicals = (1) x ( $limit + 1 );
foreach my $n ( 2 .. $limit ) {
    if ( $radicals[$n] == 1 ) {
        $radicals[$n] = $n;
        my $multiple = $n + $n;
        while ( $multiple <= $limit ) {
            $radicals[$multiple] *= $n;
            $multiple += $n;
        }
    }
}

printf "%d\n",
  ( sort { $radicals[$a] <=> $radicals[$b] || $a <=> $b } ( 1 .. $limit ) )
  [ $ordinal - 1 ];

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'limit=i'   => \$limit,
        'ordinal=i' => \$ordinal,
        'debug'     => \$debug,
        'help'      => \$help,
        'man'       => \$man,
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

124.pl

Ordered radicals

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Ordered radicals". The problem is:
If rad(n) is sorted for 1 ² n ² 100000, find E(10000).

=head1 EXAMPLES

    perl 124.pl --limit 10 --ordinal 4

=head1 USAGE

    124.pl
        [--limit INT]
        [--ordinal INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum value of n.

=item B<--ordinal INT>

The required ordinal.

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
