#!/usr/bin/env perl

# PODNAME: 138.pl
# ABSTRACT: Special isosceles triangles

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-12-19

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use bignum;
use List::Util qw(sum);

# Default options
my $ordinal = 12;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @legs;

foreach my $n ( 1 .. $ordinal ) {
    push @legs, fib( 6 * $n + 3 ) / 2;    ## no critic (ProhibitMagicNumbers)
}

printf "%d\n", sum(@legs);

sub fib {
    my ($n) = @_;

    ## no critic (ProhibitMagicNumbers)
    return ( ( 1 + sqrt 5 )**$n - ( 1 - sqrt 5 )**$n ) / ( 2**$n * sqrt 5 );
    ## use critic
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'ordinal=i' => \$ordinal,
        'debug'     => \$debug,
        'help'      => \$help,
        'man'       => \$man,
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

138.pl

Special isosceles triangles

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Special isosceles triangles". The
problem is: Find · L for the twelve smallest isosceles triangles for which
h = b ± 1 and b, L are positive integers.

=head1 EXAMPLES

    perl 138.pl --ordinal 2

=head1 USAGE

    138.pl
        [--ordinal INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--ordinal INT>

The ordinal of the last required isosceles triangle.

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
