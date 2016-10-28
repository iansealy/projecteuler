#!/usr/bin/env perl

# PODNAME: 135.pl
# ABSTRACT: Same differences

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-10-28

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
## no critic (ProhibitMagicNumbers)
my $limit     = 1_000_000;
my $solutions = 10;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

# y = z + d
# x = z + 2d
# x^2 - y^2 - z^2 = n
# (z + 2d)^2 - (z + d)^2 - z^2 = n
# 3d^2 + 2dz - z^2 = n
my %count;
foreach my $d ( 1 .. $limit ) {
    my $z = 0;
    while ( $z <= $limit ) {
        $z++;
        ## no critic (ProhibitMagicNumbers)
        my $n = 3 * $d * $d + 2 * $d * $z - $z * $z;
        ## use critic
        last if $n < 0;
        if ( $n > $limit ) {

            # Solve quadratic equation to determine when back below limit
            ## no critic (ProhibitMagicNumbers)
            my $sq_root =
              sqrt( ( 2 * $d ) * ( 2 * $d ) - 4 * ( $limit - 3 * $d * $d ) );
            ## use critic
            my $z1 = int( ( 2 * $d - $sq_root ) / 2 );
            my $z2 = int( ( 2 * $d + $sq_root ) / 2 );
            next if $z2 <= $z;
            $z = $z1 > $z ? $z1 : $z2;
            $z--;
            next;
        }
        $count{$n}++;
    }
}

printf "%d\n",
  scalar grep { defined $count{$_} && $count{$_} == $solutions }
  ( 1 .. $limit );

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'limit=i'     => \$limit,
        'solutions=i' => \$solutions,
        'debug'       => \$debug,
        'help'        => \$help,
        'man'         => \$man,
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

135.pl

Same differences

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Same differences". The problem is:
How many values of n less than one million have exactly ten distinct solutions?

=head1 EXAMPLES

    perl 135.pl --limit 1155 --solutions 10

=head1 USAGE

    135.pl
        [--limit INT]
        [--solutions INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--k INT>

The maximum value of n.

=item B<--factors INT>

The number of distinct solutions.

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
