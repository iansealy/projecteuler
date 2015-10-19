#!/usr/bin/env perl

# PODNAME: 80.pl
# ABSTRACT: Square root digital expansion

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-10-19

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use Math::BigInt;

# Constants
Readonly our $LIMIT => 100;
Readonly our $BASE  => 10;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $total          = 0;
my $current_square = 0;
foreach my $num ( 1 .. $LIMIT ) {
    if ( sqrt $num == int sqrt $num ) {
        $current_square = $num;
        next;
    }
    my $sqrt = Math::BigInt->new( sqrt $current_square );
    my $div = Math::BigInt->new( ( $num - $current_square ) * $BASE * $BASE );
    while ( length $sqrt < $LIMIT ) {
        my $double = $sqrt * 2;
        my $i      = 0;
        while (1) {
            $i++;
            if ( ( $double * $BASE + $i ) * $i > $div ) {
                $i--;
                last;
            }
        }
        $sqrt = $sqrt * $BASE + $i;
        $div = ( $div - ( $double * $BASE + $i ) * $i ) * $BASE * $BASE;
    }
    foreach my $digit ( split //xms, $sqrt ) {
        $total += $digit;
    }
}

printf "%d\n", $total;

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

80.pl

Square root digital expansion

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Square root digital expansion".
The problem is: For the first one hundred natural numbers, find the total of the
digital sums of the first one hundred decimal digits for all the irrational
square roots.

=head1 EXAMPLES

    perl 80.pl

=head1 USAGE

    80.pl
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
