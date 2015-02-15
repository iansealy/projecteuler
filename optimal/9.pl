#!/usr/bin/env perl

# PODNAME: 9.pl
# ABSTRACT: Special Pythagorean triplet

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-02-15

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $SUM => 1000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @triplet = get_pythagorean_triplet_by_sum($SUM);

printf "%d\n", $triplet[0] * $triplet[1] * $triplet[2];

sub get_pythagorean_triplet_by_sum {
    my ($s) = @_;

    my $s2     = int( $SUM / 2 );
    my $mlimit = int( sqrt($s2) + 1 ) - 1;
    foreach my $m ( 2 .. $mlimit ) {
        if ( $s2 % $m == 0 ) {
            my $sm = int( $s2 / $m );
            while ( $sm % 2 == 0 ) {
                $sm = int( $sm / 2 );
            }
            my $k = $m + 1;
            if ( $m % 2 == 1 ) {
                $k = $m + 2;
            }
            while ( $k < 2 * $m && $k <= $sm ) {
                if ( $sm % $k == 0 && gcd( $k, $m ) == 1 ) {
                    my $d = int( $s2 / ( $k * $m ) );
                    my $n = $k - $m;
                    my $a = $d * ( $m * $m - $n * $n );
                    my $b = 2 * $d * $m * $n;
                    my $c = $d * ( $m * $m + $n * $n );
                    return $a, $b, $c;
                }
                $k += 2;
            }
        }
    }

    return 0, 0, 0;
}

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

9.pl

Special Pythagorean triplet

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Special Pythagorean triplet".
The problem is: There exists exactly one Pythagorean triplet for which
a + b + c = 1000. Find the product abc.

=head1 EXAMPLES

    perl 9.pl

=head1 USAGE

    9.pl
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
