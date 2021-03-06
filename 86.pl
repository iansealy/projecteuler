#!/usr/bin/env perl

# PODNAME: 86.pl
# ABSTRACT: Cuboid route

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-11-07

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $target = 1_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $total = 0;
my $m     = 1;
M: while (1) {
    foreach my $ij ( 1 .. 2 * $m ) {
        my $route = sqrt( $ij * $ij + $m * $m );
        if ( int $route == $route ) {
            if ( $ij <= $m ) {
                $total += int $ij / 2;
            }
            else {
                $total += $m - int( ( $ij + 1 ) / 2 ) + 1;
            }
        }
        last M if $total > $target;
    }
    $m++;
}

printf "%d\n", $m;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'target=i' => \$target,
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

86.pl

Cuboid route

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Cuboid route". The problem is:
Find the least value of M such that the number of solutions first exceeds one
million.

=head1 EXAMPLES

    perl 86.pl

=head1 USAGE

    86.pl
        [--target INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--target INT>

The target number of distinct cuboids.

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
