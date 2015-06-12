#!/usr/bin/env perl

# PODNAME: 43.pl
# ABSTRACT: Sub-string divisibility

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-12

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

my @pandigital;
my @multiples = get_divisible_by(2);
foreach my $first ( 0 .. 9 ) {    ## no critic (ProhibitMagicNumbers)
    push @pandigital, map { $first . $_ } @multiples;
}
@pandigital = filter_not_pandigital( \@pandigital );
foreach my $prime ( 3, 5, 7, 11, 13, 17 ) {  ## no critic (ProhibitMagicNumbers)
    @multiples = get_divisible_by($prime);
    my %next_char_for;
    foreach my $multiple (@multiples) {
        my $prefix = substr $multiple, 0, 2;
        ## no critic (ProhibitMagicNumbers)
        push @{ $next_char_for{$prefix} }, ( substr $multiple, -1, 1 );
        ## use critic
    }
    my @new_pandigital;
    foreach my $pandigital (@pandigital) {
        ## no critic (ProhibitMagicNumbers)
        my $suffix = substr $pandigital, -2, 2;
        ## use critic
        foreach my $next_char ( @{ $next_char_for{$suffix} } ) {
            push @new_pandigital, $pandigital . $next_char;
        }
    }
    @pandigital = filter_not_pandigital( \@new_pandigital );
}

my $sum = 0;
foreach my $pandigital (@pandigital) {
    $sum += $pandigital;
}

printf "%d\n", $sum;

# Get 3 digit numbers divisible by a specified number
sub get_divisible_by {
    my ($divisor) = @_;

    my @numbers;
    my $number = 0;
    while ( $number + $divisor < 1000 ) {    ## no critic (ProhibitMagicNumbers)
        $number += $divisor;
        $number = sprintf '%03d', $number;
        my %digit = map { $_ => 1 } split //xms, $number;
        next if scalar keys %digit != length $number;
        push @numbers, $number;
    }

    return @numbers;
}

# Filter out non-pandigital numbers
sub filter_not_pandigital {
    my ($candidates) = @_;

    my @filtered;
    foreach my $candidate ( @{$candidates} ) {
        my %digit = map { $_ => 1 } split //xms, $candidate;
        next if scalar keys %digit != length $candidate;
        push @filtered, $candidate;
    }

    return @filtered;
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

43.pl

Sub-string divisibility

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Sub-string divisibility". The
problem is: Find the sum of all 0 to 9 pandigital numbers with this property.

=head1 EXAMPLES

    perl 43.pl

=head1 USAGE

    43.pl
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
