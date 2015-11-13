#!/usr/bin/env perl

# PODNAME: 25.pl
# ABSTRACT: 1000-digit Fibonacci number

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-13

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $digits = 1000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $ordinal = 1;
my @fib1    = (1);
my @fib2    = (1);
while ( scalar @fib1 < $digits ) {
    $ordinal++;
    my $carry = 0;
    my @sum;
    foreach my $digit ( 0 .. ( scalar @fib2 ) - 1 ) {
        my $sum = $fib2[$digit] + ( $fib1[$digit] || 0 ) + ( $carry || 0 );
        ## no critic (ProhibitMagicNumbers)
        my $last_digit_of_sum = substr $sum, -1, 1, q{};
        ## use critic
        push @sum, $last_digit_of_sum;
        $carry = $sum;
    }
    my @carry_digits = split //xms, $carry;
    push @sum, reverse @carry_digits;
    @fib1 = @fib2;
    @fib2 = @sum;
}

printf "%d\n", $ordinal;

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

25.pl

1000-digit Fibonacci number

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "1000-digit Fibonacci number". The
problem is: What is the first term in the Fibonacci sequence to contain 1000
digits?

=head1 EXAMPLES

    perl 25.pl --digits 3

=head1 USAGE

    25.pl
        [--digits INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--digits INT>

The number of digits.

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
