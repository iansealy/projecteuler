#!/usr/bin/env perl

# PODNAME: 38.pl
# ABSTRACT: Pandigital multiples

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-05-28

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

my $max_pandigital = 0;
my $number         = 0;
INT: while (1) {
    $number++;
    next if $number =~ m/0/xms;
    my $n = 1;
    while (1) {
        $n++;
        my $concat_product = $number;
        foreach my $multiple ( 2 .. $n ) {
            $concat_product .= $multiple * $number;
        }
        ## no critic (ProhibitMagicNumbers)
        next if length $concat_product < 9;
        last INT if length $concat_product > 9 && $n == 2;
        last if length $concat_product > 9;
        ## use critic
        next if $concat_product =~ m/0/xms;
        my %digit = map { $_ => 1 } split //xms, $concat_product;
        next if scalar keys %digit != 9;    ## no critic (ProhibitMagicNumbers)
        if ( $concat_product > $max_pandigital ) {
            $max_pandigital = $concat_product;
        }
    }
}

printf "%d\n", $max_pandigital;

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

38.pl

Pandigital multiples

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Pandigital multiples". The problem
is: What is the largest 1 to 9 pandigital 9-digit number that can be formed as
the concatenated product of an integer with (1,2, ... , n) where n > 1?

=head1 EXAMPLES

    perl 38.pl

=head1 USAGE

    38.pl
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
