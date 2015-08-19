#!/usr/bin/env perl

# PODNAME: 64.pl
# ABSTRACT: Odd period square roots

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-08-19

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 10_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $odd_count = 0;
foreach my $n ( 2 .. $limit ) {
    next if sqrt $n == int sqrt $n;

    my @m = (0);
    my @d = (1);
    my @a = ( int sqrt $n );

    while (1) {
        push @m, $d[-1] * $a[-1] - $m[-1];
        push @d, ( $n - $m[-1] * $m[-1] ) / $d[-1];
        push @a, int( ( $a[0] + $m[-1] ) / $d[-1] );
        last if $a[-1] == 2 * $a[0];
    }
    if ( scalar @a % 2 == 0 ) {
        $odd_count++;
    }
}

printf "%d\n", $odd_count;

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

64.pl

Odd period square roots

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Odd period square roots". The
problem is: How many continued fractions for N ≤ 10000 have an odd period?

=head1 EXAMPLES

    perl 64.pl

=head1 USAGE

    64.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The limit on N, the number whose square root is to be taken.

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
