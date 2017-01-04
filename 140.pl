#!/usr/bin/env perl

# PODNAME: 140.pl
# ABSTRACT: Modified Fibonacci golden nuggets

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2017-01-04

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
my $ordinal = 30;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @nuggets;
my $n          = 0;
my $up_or_down = 1;
while ( scalar @nuggets < $ordinal ) {
    $n += $up_or_down;
    ## no critic (ProhibitMagicNumbers)
    my $discriminant = sqrt( 5 * $n * $n + 14 * $n + 1 );
    ## use critic
    if ( int $discriminant == $discriminant ) {
        push @nuggets, $n;
        if ( scalar @nuggets > 2 ) {
            ## no critic (ProhibitMagicNumbers)
            $up_or_down = -1;
            $n          = int( $nuggets[-2] * $nuggets[-1] / $nuggets[-3] );
            ## use critic
        }
    }
}

printf "%d\n", sum(@nuggets);

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

140.pl

Modified Fibonacci golden nuggets

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Modified Fibonacci golden
nuggets". The problem is: Find the sum of the first thirty golden nuggets.

=head1 EXAMPLES

    perl 140.pl

=head1 USAGE

    140.pl
        [--ordinal INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--ordinal INT>

The ordinal of the last golden nugget.

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

This software is Copyright (c) 2017 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
