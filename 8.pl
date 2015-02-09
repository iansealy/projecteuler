#!/usr/bin/env perl

# PODNAME: 8.pl
# ABSTRACT: Largest product in a series

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-02-09

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $SERIES => <<'END';
73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450
END

# Default options
my $digits = 13;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

# Prepare series
my $series = $SERIES;
$series =~ s/\D//xmsg;
my @series = split //xms, $series;

my $i           = $digits;
my @subset      = @series[ 0 .. $digits - 1 ];
my $max_product = product(@subset);
while ( $i < scalar @series ) {

    # Skip ahead if next digit is zero
    if ( !$series[$i] ) {
        $i += $digits;
        next;
    }

    @subset = @series[ $i - $digits + 1 .. $i ];
    my $product = product(@subset);
    if ( $product > $max_product ) {
        $max_product = $product;
    }

    $i++;
}

printf "%d\n", $max_product;

# Get product of a list of numbers
sub product {
    my (@numbers) = @_;

    my $product = 1;
    foreach my $number (@numbers) {
        $product *= $number;
    }

    return $product;
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

8.pl

Largest product in a series

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Largest product in a series". The
problem is: Find the thirteen adjacent digits in the 1000-digit number that
have the greatest product. What is the value of this product?

=head1 EXAMPLES

    perl 8.pl --digits 4

=head1 USAGE

    8.pl
        [--digits INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--digits INT>

The number of adjacent digits.

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
