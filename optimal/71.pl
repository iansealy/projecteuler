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
Readonly our @TARGET_FRAC => ( 3, 7 );

# Default options
my $limit = 1_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $best_numer = 0;
my $best_denom = 1;
my $cur_denom  = $limit;
my $min_denom  = 1;
while ( $cur_denom >= $min_denom ) {
    my $cur_numer =
      int( ( $TARGET_FRAC[0] * $cur_denom - 1 ) / $TARGET_FRAC[1] );
    if ( $best_numer * $cur_denom < $cur_numer * $best_denom ) {
        $best_numer = $cur_numer;
        $best_denom = $cur_denom;
        my $delta = $TARGET_FRAC[0] * $cur_denom - $TARGET_FRAC[1] * $cur_numer;
        $min_denom = int( $cur_denom / $delta ) + 1;
    }
    $cur_denom--;
}

printf "%d\n", $best_numer;

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
