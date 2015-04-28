#!/usr/bin/env perl

# PODNAME: 30.pl
# ABSTRACT: Digit fifth powers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-28

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
## no critic (ProhibitMagicNumbers)
my $power = 5;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $total_sum = 0;

# Work out maximum number of digits
# e.g.            5 * 59049 (295245) > 99999
# e.g.            6 * 59049 (354294) < 999999
## no critic (ProhibitMagicNumbers)
my $max_per_digit = 9**$power;
my $max_digits    = 1;
while ( $max_digits * $max_per_digit > 9 x $max_digits ) {
## use critic
    $max_digits++;
}

my $number     = 2;
my $max_number = 10**$max_digits;    ## no critic (ProhibitMagicNumbers)
while ( $number < $max_number ) {
    my @digits = split //xms, $number;
    my $sum = 0;
    foreach my $digit (@digits) {
        $sum += $digit**$power;
    }
    if ( $sum == $number ) {
        $total_sum += $number;
    }
    $number++;
}

printf "%d\n", $total_sum;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'power=i' => \$power,
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

30.pl

Digit fifth powers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Digit fifth powers". The problem
is: Find the sum of all the numbers that can be written as the sum of fifth
powers of their digits.

=head1 EXAMPLES

    perl 30.pl --power 4

=head1 USAGE

    30.pl
        [--power INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--power INT>

The power to raise digits by.

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
