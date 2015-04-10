#!/usr/bin/env perl

# PODNAME: 24.pl
# ABSTRACT: Lexicographic permutations

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-04-10

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
## no critic (ProhibitMagicNumbers)
my $digits  = 10;
my $ordinal = 1_000_000;
## use critic
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $permutation;
my %in_permutation;
my $running_total = 0;
foreach my $perm_digits_left ( reverse 1 .. $digits ) {
    my $num_in_batch = factorial($perm_digits_left) / $perm_digits_left;
    foreach my $digit ( 0 .. $digits - 1 ) {
        next if exists $in_permutation{$digit};
        if ( $running_total + $num_in_batch >= $ordinal ) {
            $permutation .= $digit;
            $in_permutation{$digit} = 1;
            last;
        }
        else {
            $running_total += $num_in_batch;
        }
    }
}

printf "%s\n", $permutation;

sub factorial {
    my ($number) = @_;

    my $factorial = 1;

    while ( $number > 1 ) {
        $factorial *= $number;
        $number--;
    }

    return $factorial;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'digits=i'  => \$digits,
        'ordinal=i' => \$ordinal,
        'debug'     => \$debug,
        'help'      => \$help,
        'man'       => \$man,
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

24.pl

Lexicographic permutations

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Lexicographic permutations". The
problem is: What is the millionth lexicographic permutation of the digits 0, 1,
2, 3, 4, 5, 6, 7, 8 and 9?

=head1 EXAMPLES

    perl 24.pl --digits 3 --ordinal 3

=head1 USAGE

    24.pl
        [--digits INT]
        [--ordinal INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--digits INT>

The number of digits to permute.

=item B<--ordinal INT>

The permutation of interest.

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
