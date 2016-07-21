#!/usr/bin/env perl

# PODNAME: 113.pl
# ABSTRACT: Non-bouncy numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-07-17

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Memoize qw( memoize );

# Default options
my $exponent = 100;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

memoize('count_increasing');
memoize('count_decreasing');

my $increasing = 0;
foreach my $num_digits ( 1 .. $exponent ) {
    foreach my $last_digit ( 1 .. 9 ) {    ## no critic (ProhibitMagicNumbers)
        $increasing += count_increasing( $last_digit, $num_digits );
    }
}

my $decreasing = 0;
foreach my $num_digits ( 1 .. $exponent ) {
    foreach my $last_digit ( 0 .. 9 ) {    ## no critic (ProhibitMagicNumbers)
        $decreasing += count_decreasing( $last_digit, $num_digits );
    }
    $decreasing--;                         # Don't count 0, 00, 000, etc...
}

my $double_count = 9 * $exponent;          ## no critic (ProhibitMagicNumbers)

printf "%d\n", $increasing + $decreasing - $double_count;

# Count increasing numbers of specific length, ending in certain digit
sub count_increasing {
    my ( $last_digit, $length ) = @_;

    if ( $length == 1 ) {
        return 1;
    }

    my $count = 0;
    foreach my $prev_last_digit ( 1 .. $last_digit ) {
        $count += count_increasing( $prev_last_digit, $length - 1 );
    }

    return $count;
}

# Count decreasing numbers of specific length, ending in certain digit
sub count_decreasing {
    my ( $last_digit, $length ) = @_;

    if ( $length == 1 ) {
        return 1;
    }

    my $count = 0;
    ## no critic (ProhibitMagicNumbers)
    foreach my $prev_last_digit ( $last_digit .. 9 ) {
        ## use critic
        $count += count_decreasing( $prev_last_digit, $length - 1 );
    }

    return $count;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'exponent=i' => \$exponent,
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

113.pl

Non-bouncy numbers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Non-bouncy numbers". The problem
is: How many numbers below a googol (10^100) are not bouncy?

=head1 EXAMPLES

    perl 113.pl

=head1 USAGE

    113.pl
        [--exponent INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--exponent INT>

Maximum value of n as an exponent of 10.

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

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
