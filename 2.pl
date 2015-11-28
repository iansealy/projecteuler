#!/usr/bin/env perl

# PODNAME: 2.pl
# ABSTRACT: Even Fibonacci numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-01-05

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $MAX_FIB => 4_000_000;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $fib1     = 1;
my $fib2     = 1;
my $sum_even = 0;
while ( $fib2 < $MAX_FIB ) {
    ( $fib1, $fib2 ) = ( $fib2, $fib1 + $fib2 );
    if ( $fib1 % 2 == 0 ) {
        $sum_even += $fib1;
    }
}
printf "%d\n", $sum_even;

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

2.pl

Even Fibonacci numbers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Even Fibonacci numbers". The
problem is: By considering the terms in the Fibonacci sequence whose values do
not exceed four million, find the sum of the even-valued terms.

=head1 EXAMPLES

    perl 2.pl

=head1 USAGE

    2.pl
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
