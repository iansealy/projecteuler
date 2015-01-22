#!/usr/bin/env perl

# PODNAME: 4.pl
# ABSTRACT: Largest palindrome product

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-01-19

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $digits = 3;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

## no critic (ProhibitMagicNumbers)
my $high_num = 9 x $digits;
my $low_num  = 10**( $digits - 1 );
## use critic

my $max = 0;

foreach my $num1 ( reverse $low_num .. $high_num ) {
    my $num2     = $num1;
    my $decrease = 1;
    ## no critic (ProhibitMagicNumbers)
    if ( $num1 % 11 ) {

        # $num1 not divisible by 11, so force $num2 to be
        $num2     = int( $num2 / 11 ) * 11;
        $decrease = 11;
        ## use critic
    }
    while ( $num2 >= $low_num ) {
        my $product = $num1 * $num2;
        if ( $product > $max && is_palindrome($product) ) {
            $max = $product;
        }
        $num2 -= $decrease;
    }
}

printf "%d\n", $max;

# Check if number is palindrome
sub is_palindrome {
    my ($number) = @_;

    return $number == reverse $number;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'digits=i' => \$digits,
        'debug'    => \$debug,
        'help'     => \$help,
        'man'      => \$man,
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

4.pl

Largest palindrome product

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Largest palindrome product". The
problem is: Find the largest palindrome made from the product of two 3-digit
numbers.

=head1 EXAMPLES

    perl 4.pl --digits 2

=head1 USAGE

    4.pl
        [--digits INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--number INT>

The number of digits in the numbers to be multiplied.

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
