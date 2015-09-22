#!/usr/bin/env perl

# PODNAME: 72.pl
# ABSTRACT: Counting fractions

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-09-22

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

my $sieve_limit = int( ( int sqrt $limit - 1 ) / 2 );
my $max_index   = int( ( $limit - 1 ) / 2 );
my @cache;
foreach my $n ( 1 .. $sieve_limit ) {
    if ( !$cache[$n] ) {
        my $p = 2 * $n + 1;
        my $k = 2 * $n * ( $n + 1 );
        while ( $k <= $max_index ) {
            if ( !$cache[$k] ) {
                $cache[$k] = $p;
            }
            $k += $p;
        }
    }
}
my $multiplier = 1;
while ( $multiplier <= $limit ) {
    $multiplier *= 2;
}
$multiplier /= 2;
my $count = $multiplier - 1;
$multiplier /= 2;
my $step_index = int( ( int( $limit / $multiplier ) + 1 ) / 2 );
foreach my $n ( 1 .. $max_index ) {
    if ( $n == $step_index ) {
        $multiplier /= 2;
        $step_index = int( ( int( $limit / $multiplier ) + 1 ) / 2 );
    }
    if ( !$cache[$n] ) {
        $cache[$n] = 2 * $n;
        $count += $multiplier * $cache[$n];
    }
    else {
        my $p        = $cache[$n];
        my $cofactor = int( ( 2 * $n + 1 ) / $p );
        my $factor   = $p;
        if ( $cofactor % $p ) {
            $factor = $p - 1;
        }
        $cache[$n] = $factor * $cache[ int( $cofactor / 2 ) ];
        $count += $multiplier * $cache[$n];
    }
}

printf "%d\n", $count;

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

72.pl

Counting fractions

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Counting fractions". The problem
is: How many elements would be contained in the set of reduced proper fractions
for d ≤ 1,000,000?

=head1 EXAMPLES

    perl 72.pl

=head1 USAGE

    72.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The limit on d.

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
