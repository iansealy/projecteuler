#!/usr/bin/env perl

# PODNAME: 32.pl
# ABSTRACT: Pandigital products

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-05-07

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

# Can only get 9 pandigital number via x * xxxx = xxxx or xx * xxx = xxxx

## no critic (ProhibitMagicNumbers)
my %product =
  map { $_ => 1 }
  ( get_products( 1, 9, 1234, 9876 ), get_products( 12, 98, 123, 987 ) );
## use critic
my $sum = 0;
foreach my $product ( keys %product ) {
    $sum += $product;
}

printf "%d\n", $sum;

sub get_products {
    my (
        $low_multiplicand, $high_multiplicand,
        $low_multiplier,   $high_multiplier
    ) = @_;

    my @products;

    foreach my $multiplicand ( $low_multiplicand .. $high_multiplicand ) {
        next if $multiplicand =~ m/0/xms;
        foreach my $multiplier ( $low_multiplier .. $high_multiplier ) {
            next if $multiplier =~ m/0/xms;
            my $product = $multiplicand * $multiplier;
            next if $product >= 10_000;    ## no critic (ProhibitMagicNumbers)
            next if $product =~ m/0/xms;
            my %digit = map { $_ => 1 } split //xms,
              $multiplicand . $multiplier . $product;
            next if scalar keys %digit != 9; ## no critic (ProhibitMagicNumbers)
            push @products, $product;
        }
    }

    return @products;
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

32.pl

Pandigital products

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Pandigital products". The problem
is: Find the sum of all products whose multiplicand/multiplier/product identity
can be written as a 1 through 9 pandigital.

=head1 EXAMPLES

    perl 32.pl

=head1 USAGE

    32.pl
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
