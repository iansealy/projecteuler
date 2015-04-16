#!/usr/bin/env perl

# PODNAME: 26.pl
# ABSTRACT: Reciprocal cycles

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-16

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
## no critic (ProhibitMagicNumbers)
my $denominators = 999;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $max_denominator;
my $max_cycle = 0;
DENOM: foreach my $denominator ( 2 .. $denominators ) {
    my $remainder = 1 % $denominator;
    my %first_seen;
    my $digit = 0;
    while ($remainder) {
        $digit++;
        $remainder *= 10;    ## no critic (ProhibitMagicNumbers)
        my $whole = int( $remainder / $denominator );
        $remainder = $remainder % $denominator;
        if ( exists $first_seen{"$whole:$remainder"} ) {

            # Got cycle
            my $cycle = $digit - $first_seen{"$whole:$remainder"};
            if ( $cycle > $max_cycle ) {
                $max_cycle       = $cycle;
                $max_denominator = $denominator;
            }
            next DENOM;
        }
        else {
            $first_seen{"$whole:$remainder"} = $digit;
        }
    }
}

printf "%d\n", $max_denominator;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'denominators=i' => \$denominators,
        'debug'          => \$debug,
        'help'           => \$help,
        'man'            => \$man,
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

26.pl

Reciprocal cycles

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Reciprocal cycles". The problem
is: Find the value of d < 1000 for which 1/d contains the longest recurring
cycle in its decimal fraction part.

=head1 EXAMPLES

    perl 26.pl --denominators 10

=head1 USAGE

    26.pl
        [--denominators INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--denominators INT>

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
