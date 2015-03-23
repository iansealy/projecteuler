#!/usr/bin/env perl

# PODNAME: 19.pl
# ABSTRACT: Counting Sundays

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-03-23

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $START_YEAR       => 1900;
Readonly our $END_YEAR         => 2000;
Readonly our $COUNT_START_YEAR => 1901;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $day_of_week = 1;    # Monday 1st Jan 1900

my $sunday_count = 0;

foreach my $year ( $START_YEAR .. $END_YEAR ) {
    foreach my $days ( get_days_in_month( $year, $year == $END_YEAR ) ) {
        ## no critic (ProhibitMagicNumbers)
        $day_of_week = ( $day_of_week + $days ) % 7;
        ## use critic
        if ( $day_of_week == 0 && $year >= $COUNT_START_YEAR ) {
            $sunday_count++;
        }
    }
}

printf "%d\n", $sunday_count;

sub get_days_in_month {
    my ( $year, $is_last ) = @_;

    ## no critic (ProhibitMagicNumbers)
    my $feb_days = 28;
    if ( $year % 4 == 0 && ( $year % 100 != 0 || $year % 400 == 0 ) ) {
        $feb_days = 29;
    }

    #            Jan            Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    my @days = ( 31, $feb_days, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );
    ## use critic

    if ($is_last) {
        pop @days;
    }

    return @days;
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

19.pl

Counting Sundays

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Counting Sundays". The problem is:
How many Sundays fell on the first of the month during the twentieth century
(1 Jan 1901 to 31 Dec 2000)?

=head1 EXAMPLES

    perl 19.pl

=head1 USAGE

    19.pl
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
