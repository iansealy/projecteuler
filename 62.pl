#!/usr/bin/env perl

# PODNAME: 62.pl
# ABSTRACT: Cubic permutations

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-08-13

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Math::BigInt;

# Default options
my $perms = 5;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $current_digits = 1;
my $num            = 0;
my %cubes_for;
my $lowest_cube;
while (1) {
    $num++;

    my $big_num = Math::BigInt->new($num);
    my $cube    = $big_num->bpow(3);         ## no critic (ProhibitMagicNumbers)

    if ( $current_digits < length $cube ) {

        # Check if finished
        foreach my $cubes ( values %cubes_for ) {
            if ( scalar @{$cubes} == $perms ) {
                my $low_cube = ( sort @{$cubes} )[0];
                if ( !defined $lowest_cube || $low_cube < $lowest_cube ) {
                    $lowest_cube = $low_cube;
                }
            }
        }

        # Reset for another digit range
        $current_digits = length $cube;
        %cubes_for      = ();
    }
    last if defined $lowest_cube;

    my $key = join q{}, sort split //xms, $cube;
    push @{ $cubes_for{$key} }, $cube;
}

printf "%s\n", $lowest_cube;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'perms=i' => \$perms,
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

62.pl

Cubic permutations

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Cubic permutations". The problem
is: Find the smallest cube for which exactly five permutations of its digits are
cube.

=head1 EXAMPLES

    perl 62.pl

=head1 USAGE

    62.pl
        [--perms INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--perms INT>

The target number of digit permutations.

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
