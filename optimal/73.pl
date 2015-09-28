#!/usr/bin/env perl

# PODNAME: 73.pl
# ABSTRACT: Counting fractions in a range

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-09-28

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Default options
my $limit = 12_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $k0 = int sqrt( $limit / 2 );
my $m0 = int( $limit / ( 2 * $k0 + 1 ) );
my @r_small;
my @r_large;

foreach my $n ( 5 .. $m0 ) {    ## no critic (ProhibitMagicNumbers)
    r( $n, \@r_small, \@r_large );
}
foreach my $j ( reverse 0 .. $k0 - 1 ) {
    r( int( $limit / ( 2 * $j + 1 ) ), \@r_small, \@r_large );
}

printf "%d\n", $r_large[0];

sub f {
    my ($n) = @_;

    ## no critic (ProhibitMagicNumbers)
    my $q = int( $n / 6 );
    my $r = $n % 6;
    my $f = $q * ( 3 * $q - 2 + $r );
    if ( $r == 5 ) {
        ## use critic
        $f++;
    }

    return $f;
}

sub r {
    my ( $n, $r_small, $r_large ) = @_;

    my $switch = int sqrt( $n / 2 );
    my $count  = f($n);
    $count -= f( int( $n / 2 ) );
    ## no critic (ProhibitMagicNumbers)
    my $m = 5;
    my $k = int( ( $n - 5 ) / 10 );
    ## use critic
    while ( $k >= $switch ) {
        my $next_k = int( ( int( $n / ( $m + 1 ) ) - 1 ) / 2 );
        $count -= ( ( $k - $next_k ) * ( $r_small->[$m] || 0 ) );
        $k = $next_k;
        $m++;
    }
    while ( $k > 0 ) {
        $m = int( $n / ( 2 * $k + 1 ) );
        if ( $m <= $m0 ) {
            $count -= ( $r_small->[$m] || 0 );
        }
        else {
            $count -=
              ( $r_large->[ int( ( int( $limit / $m ) - 1 ) / 2 ) ] || 0 );
        }
        $k--;
    }
    if ( $n <= $m0 ) {
        $r_small->[$n] = $count;
    }
    else {
        $r_large->[ int( ( int( $limit / $n ) - 1 ) / 2 ) ] = $count;
    }
    return;
}

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

73.pl

Counting fractions in a range

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Counting fractions in a range".
The problem is: How many fractions lie between 1/3 and 1/2 in the sorted set of
reduced proper fractions for d ≤ 12,000?

=head1 EXAMPLES

    perl 73.pl

=head1 USAGE

    73.pl
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
