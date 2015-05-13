#!/usr/bin/env perl

# PODNAME: 34.pl
# ABSTRACT: Digit factorials

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-05-13

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

## no critic (ProhibitMagicNumbers)
my @factorial_of = map { factorial($_) } ( 0 .. 9 );
## use critic

my $sum = 0;
## no critic (ProhibitMagicNumbers)
foreach my $number ( 10 .. $factorial_of[9] * 7 ) {
    ## use critic
    my @digits = split //xms, $number;
    my @factorials = map { $factorial_of[$_] } @digits;
    my $factorial_sum = 0;
    foreach my $factorial (@factorials) {
        $factorial_sum += $factorial;
    }
    if ( $number == $factorial_sum ) {
        $sum += $number;
    }
}

printf "%d\n", $sum;

sub factorial {
    my ($number) = @_;

    my $factorial = 1;

    while ( $number > 1 ) {
        $factorial *= $number;
        $number--;
    }

    return $factorial;
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

34.pl

Digit factorials

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Digit factorials". The problem is:
Find the sum of all numbers which are equal to the sum of the factorial of their
digits.

=head1 EXAMPLES

    perl 34.pl

=head1 USAGE

    34.pl
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
