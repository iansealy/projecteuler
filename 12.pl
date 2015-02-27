#!/usr/bin/env perl

# PODNAME: 12.pl
# ABSTRACT: Highly divisible triangular number

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-02-27

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $divisors = 500;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $ordinal         = 1;
my $triangle_number = 1;
my $num_factors     = 1;

while ( $num_factors <= $divisors ) {
    $ordinal++;
    $triangle_number += $ordinal;
    $num_factors = scalar get_factors($triangle_number);
}

printf "%d\n", $triangle_number;

sub get_factors {
    my ($number) = @_;

    my @factors = ( 1, $number );

    foreach my $i ( 2 .. int sqrt $number ) {
        if ( $number % $i == 0 ) {
            push @factors, $i, $number / $i;
        }
    }

    return @factors;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'divisors=i' => \$divisors,
        'debug'      => \$debug,
        'help'       => \$help,
        'man'        => \$man,
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

12.pl

Highly divisible triangular number

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Highly divisible triangular
number". The problem is: What is the value of the first triangle number to have
over five hundred divisors?

=head1 EXAMPLES

    perl 12.pl --divisors 5

=head1 USAGE

    12.pl
        [--divisors INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--divisors INT>

The number of divisors over which the triangle number should have.

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
