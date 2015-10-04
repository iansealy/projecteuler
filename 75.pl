#!/usr/bin/env perl

# PODNAME: 75.pl
# ABSTRACT: Singular integer right triangles

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-10-04

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $LIMIT => 1_500_000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my %count;
my $mlimit = int sqrt $LIMIT;
foreach my $m ( 2 .. $mlimit ) {
    foreach my $n ( 1 .. $m - 1 ) {
        next if ( $m + $n ) % 2 == 0 || gcd( $n, $m ) > 1;
        my $length = 2 * $m * ( $m + $n );
        my $multiple = $length;
        while ( $multiple <= $LIMIT ) {
            $count{$multiple}++;
            $multiple += $length;
        }
    }
}

printf "%d\n", scalar grep { $_ == 1 } values %count;

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

75.pl

Singular integer right triangles

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Singular integer right triangles".
The problem is: Given that L is the length of the wire, for how many values of
L ≤ 1,500,000 can exactly one integer sided right angle triangle be formed?

=head1 EXAMPLES

    perl 75.pl

=head1 USAGE

    75.pl
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

This software is Copyright (c) 2015 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
