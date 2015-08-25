#!/usr/bin/env perl

# PODNAME: 66.pl
# ABSTRACT: Diophantine equation

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-08-25

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Math::BigInt;

# Default options
my $limit = 1000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $d_with_largest_x;
my $largest_x = 0;
foreach my $d ( 2 .. $limit ) {
    next if sqrt $d == int sqrt $d;

    my @m = (0);
    my @d = (1);
    my @a = ( int sqrt $d );

    my $x_prev2 = Math::BigInt->new(1);
    my $x_prev1 = Math::BigInt->new( $a[0] );
    my $y_prev2 = Math::BigInt->new(0);
    my $y_prev1 = Math::BigInt->new(1);

    while (1) {
        push @m, $d[-1] * $a[-1] - $m[-1];
        push @d, ( $d - $m[-1] * $m[-1] ) / $d[-1];
        push @a, int( ( $a[0] + $m[-1] ) / $d[-1] );

        my $x = $a[-1] * $x_prev1 + $x_prev2;
        my $y = $a[-1] * $y_prev1 + $y_prev2;

        if ( $x * $x - $d * $y * $y == 1 ) {
            if ( $x > $largest_x ) {
                $d_with_largest_x = $d;
                $largest_x        = $x;
            }
            last;
        }

        $x_prev2 = $x_prev1;
        $x_prev1 = $x;
        $y_prev2 = $y_prev1;
        $y_prev1 = $y;
    }
}

printf "%d\n", $d_with_largest_x;

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

66.pl

Diophantine equation

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Diophantine equation". The
problem is: Find the value of D ≤ 1000 in minimal solutions of x for which the
largest value of x is obtained.

=head1 EXAMPLES

    perl 66.pl

=head1 USAGE

    66.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The limit on D.

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
