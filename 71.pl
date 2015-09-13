#!/usr/bin/env perl

# PODNAME: 71.pl
# ABSTRACT: Ordered fractions

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-09-13

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our @RIGHT_FRAC => ( 3, 7 );

# Default options
my $limit = 1_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @left_frac = ( 2, 7 );    ## no critic (ProhibitMagicNumbers)
foreach my $d ( 2 .. $limit ) {
    my $start_n = int( $left_frac[0] / $left_frac[1] * $d );
    my $end_n   = int( $RIGHT_FRAC[0] / $RIGHT_FRAC[1] * $d ) + 1;
    foreach my $n ( $start_n .. $end_n ) {
        next if compare_fractions( $n, $d, @RIGHT_FRAC ) >= 0;
        if ( compare_fractions( $n, $d, @left_frac ) > 0 ) {
            @left_frac = ( $n, $d );
        }
    }
}

printf "%d\n", $left_frac[0];

sub compare_fractions {
    my ( $numer1, $denom1, $numer2, $denom2 ) = @_;

    return $numer1 * $denom2 <=> $numer2 * $denom1;
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

71.pl

Ordered fractions

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Ordered fractions". The problem
is: By listing the set of reduced proper fractions for d ≤ 1,000,000 in
ascending order of size, find the numerator of the fraction immediately to the
left of 3/7.

=head1 EXAMPLES

    perl 71.pl

=head1 USAGE

    71.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum denominator.

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
