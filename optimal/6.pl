#!/usr/bin/env perl

# PODNAME: 6.pl
# ABSTRACT: Sum square difference

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-01-31

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $max_num = 100;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

## no critic (ProhibitMagicNumbers)
my $sum_squares = ( 2 * $max_num + 1 ) * ( $max_num + 1 ) * $max_num / 6;
## use critic
my $square_sum = ( $max_num * ( $max_num + 1 ) / 2 )**2;
my $diff = $square_sum - $sum_squares;

printf "%d\n", $diff;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'max_num=i' => \$max_num,
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

6.pl

Sum square difference

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Sum square difference". The
problem is: Find the difference between the sum of the squares of the first one
hundred natural numbers and the square of the sum.

=head1 EXAMPLES

    perl 6.pl --max_num 10

=head1 USAGE

    6.pl
        [--max_num INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--max_num INT>

The number ending the sequence to find the difference of.

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
