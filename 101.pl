#!/usr/bin/env perl

# PODNAME: 101.pl
# ABSTRACT: Optimum polynomial

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-05-09

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

use Readonly;

# Constants
#Readonly our $MAX_N => 4;
Readonly our $MAX_N => 11;

my @seq;
foreach my $n ( 1 .. $MAX_N ) {
    push @seq, polynomial_gen_func($n);
}

my $fits_sum = 0;

foreach my $k ( 1 .. $MAX_N - 1 ) {
    my $potential_fit = 0;
    foreach my $i ( 1 .. $k ) {
        my $numer = 1;
        my $denom = 1;
        foreach my $j ( 1 .. $k ) {
            next if $i == $j;
            $numer *= ( $k + 1 - $j );
            $denom *= ( $i - $j );
        }
        $potential_fit += $seq[ $i - 1 ] * $numer / $denom;
    }
    if ( $potential_fit != $seq[$k] ) {
        $fits_sum += $potential_fit;
    }
}

printf "%d\n", $fits_sum;

sub polynomial_gen_func {
    my ($n) = @_;

    ## no critic (ProhibitMagicNumbers)
    #return $n ** 3;
    return 1 - $n + $n**2 - $n**3 + $n**4 - $n**5 + $n**6 - $n**7 + $n**8 -
      $n**9 + $n**10;
    ## use critic
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

101.pl

Optimum polynomial

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Optimum polynomial". The problem
is: Find the sum of FITs for the BOPs.

=head1 EXAMPLES

    perl 101.pl

=head1 USAGE

    101.pl
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

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
