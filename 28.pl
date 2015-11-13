#!/usr/bin/env perl

# PODNAME: 28.pl
# ABSTRACT: Number spiral diagonals

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-22

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $width = 1001;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $sum           = 1;    # Middle number
my $current_width = 1;
my $increment     = 0;
my $number        = 1;

while ( $current_width < $width ) {
    $current_width += 2;
    $increment     += 2;
    foreach ( 1 .. 4 ) {    ## no critic (ProhibitMagicNumbers)
        $number += $increment;
        $sum    += $number;
    }
}

printf "%d\n", $sum;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'width=i' => \$width,
        'debug'   => \$debug,
        'help'    => \$help,
        'man'     => \$man,
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

28.pl

Number spiral diagonals

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Number spiral diagonals". The
problem is: What is the sum of the numbers on the diagonals in a 1001 by 1001
spiral formed in the same way?

=head1 EXAMPLES

    perl 28.pl --width 5

=head1 USAGE

    28.pl
        [--width INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--width INT>

The width of the number spiral.

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
