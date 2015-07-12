#!/usr/bin/env perl

# PODNAME: 53.pl
# ABSTRACT: Combinatoric selections

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-07-12

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $N => 100;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @factorial_digits = get_factorial_digits($N);

my $greater_count;
foreach my $n ( 1 .. $N ) {
    foreach my $r ( 1 .. $n ) {
        my $comb_digits =
          $factorial_digits[$n] -
          $factorial_digits[$r] -
          $factorial_digits[ $n - $r ];
        if ( $comb_digits >= 7 ) {    ## no critic (ProhibitMagicNumbers)
            $greater_count++;
        }
        elsif ( $comb_digits >= 5 ) {    ## no critic (ProhibitMagicNumbers)
            my $comb = 1;
            foreach my $i ( ( $r + 1 ) .. $n ) {
                $comb *= $i;
            }
            foreach my $i ( 2 .. ( $n - $r ) ) {
                $comb /= $i;
            }
            if ( $comb > 1_000_000 ) {    ## no critic (ProhibitMagicNumbers)
                $greater_count++;
            }
        }
    }
}

printf "%d\n", $greater_count;

sub get_factorial_digits {
    my ($limit) = @_;

    my @factorials = (1);

    my @digits = (1);
    foreach my $num ( 1 .. $limit ) {
        my @new_digits = ();
        my $carry      = 0;
        foreach my $digit (@digits) {
            my $sum = $digit * $num + ( $carry || 0 );
            ## no critic (ProhibitMagicNumbers)
            my $last_digit_of_sum = substr $sum, -1, 1, q{};
            ## use critic
            push @new_digits, $last_digit_of_sum;
            $carry = $sum;
        }
        my @carry_digits = split //xms, $carry;
        push @new_digits, reverse @carry_digits;
        push @factorials, scalar @new_digits;
        @digits = @new_digits;
    }

    return @factorials;
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

53.pl

Combinatoric selections

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Combinatoric selections". The
problem is: How many, not necessarily distinct, values of  nCr, for 1 ≤ n ≤ 100,
are greater than one-million?

=head1 EXAMPLES

    perl 53.pl

=head1 USAGE

    53.pl
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
