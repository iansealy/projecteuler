#!/usr/bin/env perl

# PODNAME: 73.pl
# ABSTRACT: Counting fractions in a range

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

use Readonly;

# Constants
Readonly our @LEFT_FRAC  => ( 1, 3 );
Readonly our @RIGHT_FRAC => ( 1, 2 );

# Default options
my $limit = 12_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $count = 0;
foreach my $d ( 2 .. $limit ) {
    my $start_n = int( $LEFT_FRAC[0] / $LEFT_FRAC[1] * $d );
    my $end_n   = int( $RIGHT_FRAC[0] / $RIGHT_FRAC[1] * $d ) + 1;
    foreach my $n ( $start_n .. $end_n ) {
        next if compare_fractions( $n, $d, @LEFT_FRAC ) <= 0;
        last if compare_fractions( $n, $d, @RIGHT_FRAC ) >= 0;
        next if gcd( $n, $d ) > 1;
        $count++;
    }
}

printf "%d\n", $count;

sub compare_fractions {
    my ( $numer1, $denom1, $numer2, $denom2 ) = @_;

    return $numer1 * $denom2 <=> $numer2 * $denom1;
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
