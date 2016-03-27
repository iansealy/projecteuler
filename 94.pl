#!/usr/bin/env perl

# PODNAME: 94.pl
# ABSTRACT: Almost equilateral triangles

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-03-26

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $MAX => 1e9;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $total = 0;

my $m = 1;
M: while (1) {
    $m++;
    my $m2 = $m * $m;
    my $n = $m % 2 ? 0 : -1;    ## no critic (ProhibitMagicNumbers)
    while ( $n < $m - 2 ) {
        $n += 2;
        my $n2 = $n * $n;
        my $a  = $m2 - $n2;
        my $b  = 2 * $m * $n;
        my $c  = $m2 + $n2;
        next if abs( 2 * $a - $c ) != 1 && abs( 2 * $b - $c ) != 1;
        last M if 2 * ( $a + $c ) > $MAX && 2 * ( $b + $c ) > $MAX;
        if ( abs( 2 * $a - $c ) == 1 ) {
            $total += 2 * ( $a + $c );
        }
        elsif ( abs( 2 * $b - $c ) == 1 ) {
            $total += 2 * ( $b + $c );
        }
    }
}

printf "%d\n", $total;

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

94.pl

Almost equilateral triangles

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Almost equilateral triangles". The
problem is: Find the sum of the perimeters of all almost equilateral triangles
with integral side lengths and area and whose perimeters do not exceed one
billion (1,000,000,000).

=head1 EXAMPLES

    perl 94.pl

=head1 USAGE

    94.pl
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
