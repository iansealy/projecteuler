#!/usr/bin/env perl

# PODNAME: 36.pl
# ABSTRACT: Double-base palindromes

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-05-22

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

Readonly our $MAX => 1_000_000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $sum = 0;
my $i   = 1;
my $p   = make_palindrome_base_2( $i, 1 );
while ( $p < $MAX ) {
    if ( is_palindrome( $p, 10 ) ) {    ## no critic (ProhibitMagicNumbers)
        $sum += $p;
    }
    $i++;
    $p = make_palindrome_base_2( $i, 1 );
}
$i = 1;
$p = make_palindrome_base_2( $i, 0 );
while ( $p < $MAX ) {
    if ( is_palindrome( $p, 10 ) ) {    ## no critic (ProhibitMagicNumbers)
        $sum += $p;
    }
    $i++;
    $p = make_palindrome_base_2( $i, 0 );
}

printf "%d\n", $sum;

# Get palindrome in base 2
sub make_palindrome_base_2 {
    my ( $number, $odd_length ) = @_;

    my $result = $number;

    if ($odd_length) {
        $number >>= 1;
    }

    while ( $number > 0 ) {
        $result = ( $result << 1 ) + ( $number & 1 );
        $number >>= 1;
    }

    return $result;
}

# Check if number is palindrome
sub is_palindrome {
    my ( $number, $base ) = @_;

    my $reversed = 0;
    my $k        = $number;
    while ( $k > 0 ) {
        $reversed = $base * $reversed + $k % $base;
        $k        = int( $k / $base );
    }

    return $number == $reversed;
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

36.pl

Double-base palindromes

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Double-base palindromes". The
problem is: Find the sum of all numbers, less than one million, which are
palindromic in base 10 and base 2.

=head1 EXAMPLES

    perl 36.pl

=head1 USAGE

    36.pl
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
