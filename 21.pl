#!/usr/bin/env perl

# PODNAME: 21.pl
# ABSTRACT: Amicable numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-03-30

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

my %proper_divisor_sum_of;
foreach my $number ( 1 .. $limit - 1 ) {
    $proper_divisor_sum_of{$number} = sum_proper_divisors($number);
}

my $sum = 0;

foreach my $number ( 2 .. $limit - 1 ) {
    next if $proper_divisor_sum_of{$number} >= $limit;
    next if $proper_divisor_sum_of{$number} == $number;
    if ( $proper_divisor_sum_of{ $proper_divisor_sum_of{$number} } == $number )
    {
        $sum += $number;
    }
}

printf "%d\n", $sum;

sub sum_proper_divisors {
    my ($number) = @_;

    my $proper_divisor_sum = 1;

    foreach my $i ( 2 .. int sqrt $number ) {
        if ( $number % $i == 0 ) {
            $proper_divisor_sum += $i + $number / $i;
        }
    }

    return $proper_divisor_sum;
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

21.pl

Amicable numbers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Amicable numbers". The problem is:
Evaluate the sum of all the amicable numbers under 10000.

=head1 EXAMPLES

    perl 21.pl

=head1 USAGE

    21.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The maximum amicable number.

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
