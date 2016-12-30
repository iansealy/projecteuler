#!/usr/bin/env perl

# PODNAME: 139.pl
# ABSTRACT: Pythagorean tiles

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-12-30

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $LIMIT => 100_000_000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $count  = 0;
my $mlimit = int sqrt $LIMIT;
foreach my $m ( 2 .. $mlimit ) {
    my $m2 = $m * $m;
    foreach my $n ( 1 .. $m - 1 ) {
        next if ( $m + $n ) % 2 == 0 || gcd( $n, $m ) > 1;
        my $n2        = $n * $n;
        my $a         = $m2 - $n2;
        my $b         = 2 * $m * $n;
        my $c         = $m2 + $n2;
        my $perimeter = $a + $b + $c;
        last if $perimeter >= $LIMIT;
        my $tiling = $c / ( $b - $a );
        next if $tiling != int $tiling;
        my $multiple = $perimeter;

        while ( $multiple <= $LIMIT ) {
            $count++;
            $multiple += $perimeter;
        }
    }
}

printf "%d\n", $count;

# Get greatest common divisor
sub gcd {
    my ( $int1, $int2 ) = @_;

    if ( $int1 > $int2 ) {
        ( $int1, $int2 ) = ( $int2, $int1 );
    }

    while ($int1) {
        ( $int1, $int2 ) = ( $int2 % $int1, $int1 );
    }

    return $int2;
}

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

139.pl

Pythagorean tiles

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Pythagorean tiles". The problem
is: Given that the perimeter of the right triangle is less than one-hundred
million, how many Pythagorean triangles would allow such a tiling to take place?

=head1 EXAMPLES

    perl 139.pl

=head1 USAGE

    139.pl
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
