#!/usr/bin/env perl

# PODNAME: 55.pl
# ABSTRACT: Lychrel numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-07-21

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $LIMIT => 10_000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $count = 0;
NUM: foreach my $num ( 1 .. $LIMIT - 1 ) {
    my @digits = split //xms, $num;
    foreach ( 1 .. 50 ) {    ## no critic (ProhibitMagicNumbers)
        @digits = add_reverse(@digits);
        next NUM if is_palindrome(@digits);
    }
    $count++;
}

printf "%d\n", $count;

# Add number to its reverse
sub add_reverse {
    my (@digits) = @_;

    my @reverse_digits = reverse @digits;
    my @new_digits;
    my $carry = 0;
    while (@digits) {
        my $sum = ( pop @digits ) + ( pop @reverse_digits ) + ( $carry || 0 );
        ## no critic (ProhibitMagicNumbers)
        my $last_digit_of_sum = substr $sum, -1, 1, q{};
        ## use critic
        push @new_digits, $last_digit_of_sum;
        $carry = $sum;
    }
    my @carry_digits = split //xms, $carry;
    push @new_digits, reverse @carry_digits;

    return @new_digits;
}

# Check if number is palindrome
sub is_palindrome {
    my (@digits) = @_;

    my $number     = join q{}, @digits;
    my $rev_number = join q{}, reverse @digits;

    return $number eq $rev_number;
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

55.pl

Lychrel numbers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Lychrel numbers". The problem is:
How many Lychrel numbers are there below ten-thousand?

=head1 EXAMPLES

    perl 55.pl

=head1 USAGE

    55.pl
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
